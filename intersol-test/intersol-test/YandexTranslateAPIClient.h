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

- (void)translateWord:(NSString *)wordToTranslate
              success:(void(^)(NSString *translationResult))success
              failure:(void(^)(NSError *error))failure;

@end
