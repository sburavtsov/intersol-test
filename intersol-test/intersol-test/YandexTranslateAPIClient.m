//
//  YandexTranslateAPIClient.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "YandexTranslateAPIClient.h"

NSString * const kAPIKey = @"trnsl.1.1.20141124T170009Z.23014768d74808f2.e8759991d3674f2120e7664adc2da465b520542d";
NSString * const kBaseURLString = @"https://translate.yandex.net/api/v1.5/tr.json/";
NSString * const kTranslationDirection = @"en-ru";
NSString * const kTranslationFormat = @"plain";

@implementation YandexTranslateAPIClient

+ (YandexTranslateAPIClient *)sharedClient {
    
    static YandexTranslateAPIClient *_sharedClient = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (!self) {
        
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

- (void)sendRequestToAPIWithPath:(NSString *)path
                   andParameters:(NSDictionary *)parameters
                         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {

    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            
            failure(task, error);
        }
    }];
}


- (void)translateWord:(NSString *)wordToTranslate
              success:(void(^)(NSString *translationResult))success
              failure:(void(^)(NSError *error))failure {

    NSString* path = @"translate";
    NSDictionary *parameters = @{@"key" : kAPIKey,
                                 @"text" : wordToTranslate,
                                 @"lang" : kTranslationDirection,
                                 @"format" : kTranslationFormat};
    
    [self sendRequestToAPIWithPath:path
                     andParameters:parameters
                           success:^(NSURLSessionDataTask *task, id responseObject) {
 
                               NSDictionary *response = responseObject;

                               if (200 == [response[@"code"] integerValue]) {
                                   
                                   if (success) {
                                       
                                       success([response[@"text"] objectAtIndex:0]);
                                   }
                                   
                               }
                           }
                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                               
                               if (failure) {
                                   
                                   failure(error);
                               }
                           }];
}


- (void)getLanguages:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString* path = @"getLangs";
    NSDictionary *parameters = @{@"key" : kAPIKey,
                                 @"ui" : @"ru"};

    [self sendRequestToAPIWithPath:path andParameters:parameters success:success failure:failure];
}

@end
