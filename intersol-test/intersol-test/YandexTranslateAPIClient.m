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

- (void)getLanguages:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString* path = @"getLangs";
    /*
                      key=<API-ключ>
                      & [ui=<код языка>]
                      & [callback=<имя callback-функции>]",
     */
    
     NSDictionary *parameters = @{@"key" : kAPIKey,
                                  @"ui" : @"ru"};
    
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

@end
