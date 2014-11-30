//
//  GameModel.h
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/30/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStepModel.h"

@interface GameModel : NSObject

@property (nonatomic) NSArray * sourceWordsBase;

@property (nonatomic) NSMutableArray * gameSteps;

@property (nonatomic, readonly) GameStepModel * currentStep;

@property (nonatomic) int playersScore;

@property (nonatomic) int currentPage;

@property (nonatomic) int solvedPages;

@property (nonatomic) int gameStepCasesLimit;

@property (nonatomic) int gameSessionTasksLimit;

- (void)stepSolved:(int)wordIndex;
- (void)changePage:(int)direction;

@property (nonatomic, readonly) BOOL canChangePageForward;
@property (nonatomic, readonly) BOOL canChangePageBack;

@end
