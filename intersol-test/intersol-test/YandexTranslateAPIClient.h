//
//  YandexTranslateAPIClient.h
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface YandexTranslateAPIClient : AFHTTPSessionManager

+ (YandexTranslateAPIClient *)sharedClient;

- (void)getLanguages:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
