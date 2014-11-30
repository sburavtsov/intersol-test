//
//  GameModel.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/30/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "GameModel.h"
@implementation GameModel

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        
        return nil;
    }
    
    self.gameSteps = [NSMutableArray array];
    
    self.gameStepCasesLimit = 3;
    
    self.gameSessionTasksLimit = 15;
    
    self.currentPage = 0;
    
    return self;
}

@end