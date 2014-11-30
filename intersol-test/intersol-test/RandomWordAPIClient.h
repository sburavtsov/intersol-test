//
//  RandomWordAPIClient.h
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/28/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//
#import "AFHTTPSessionManager.h"

@interface RandomWordAPIClient : AFHTTPSessionManager

@property (nonatomic) BOOL signedIn;

+ (RandomWordAPIClient *)sharedClient;

- (void)getWords:(int)count
         success:(void(^)(NSArray *randomWordsArray))success
         failure:(void(^)(NSError *error))failure;

@end
