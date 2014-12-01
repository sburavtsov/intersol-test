//
//  YandexTranslateAPIClient.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "RandomWordAPIClient.h"

NSString * const kWordnikAPIKey = @"9f98cbf17a7523955200b017b6405817f806cb86b7aef7e0f";
NSString * const kBaseWordAPIURLString = @"http://api.wordnik.com:80/v4/";

NSString * const kWordnikPassword = @"intersol-test-password";
NSString * const kWordnikUsername = @"sburavtsov";

@implementation RandomWordAPIClient



+ (RandomWordAPIClient *)sharedClient {
    
    static RandomWordAPIClient *_sharedClient = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
       
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseWordAPIURLString]];
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
    
    self.signedIn = NO;

    return self;
}

- (void)getWordInternal:(int)count
                success:(void(^)(NSArray *randomWordsArray))succes
                failure:(void(^)(NSError *error))failure {
    
    NSString* path = @"words.json/randomWords";
    NSDictionary *parameters = @{@"hasDictionaryDef" : @YES,
                                 @"includePartOfSpeech" : @"noun",
                                 @"excludePartOfSpeech" : @"proper-noun,noun-plural",
                                 @"minCorpusCount" : @35,
                                 @"maxCorpusCount" : @-1,
                                 @"minDictionaryCount" : @25,
                                 @"maxDictionaryCount" : @-1,
                                 @"minLength" : @5,
                                 @"maxLength" : @10,
                                 @"limit" : [NSNumber numberWithInt:count],
                                 @"api_key" : kWordnikAPIKey};
    
    [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@", responseObject);
        NSArray *response = responseObject;
        
        NSMutableArray *words = [NSMutableArray array];
        for (NSDictionary *wordDictionary in response) {
            
            [words addObject:wordDictionary[@"word"]];
        }
        
        if (succes) {
            
            succes(words);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
    
}

- (void)getWords:(int)count
         success:(void(^)(NSArray *randomWordsArray))success
         failure:(void(^)(NSError *error))failure {

    
    if (self.signedIn) {
        
        [self getWordInternal:count success:success failure:failure];
    } else {

        NSString* apath = [NSString stringWithFormat:@"account.json/authenticate/%@", kWordnikUsername];
        NSDictionary *aparameters = @{@"password" : kWordnikPassword,
                                      @"api_key" : kWordnikAPIKey};
        
        [self GET:apath parameters:aparameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"%@", responseObject);

            self.signedIn = YES;
            [self getWordInternal:count success:success failure:failure];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            self.signedIn = NO;
            NSLog(@"Wordnik Error: %@", error);
            failure(error);
        }];
    }

    
}

@end
