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
    
    _currentPage = 0;
    
    _solvedPages = 0;
    
    return self;
}

- (void)stepSolved:(int)wordIndex {

    self.currentStep.userTranslationIndex = wordIndex;
    
    self.playersScore += self.currentStep.score;
    self.solvedPages ++;
}

- (void) setCurrentPage:(int)currentPage {

    _currentPage = currentPage;
    
    if (_currentPage < 0) {
        
        _currentPage = 0;
    }
    
    if (_currentPage >= _gameSteps.count) {
        
        _currentPage = _gameSteps.count - 1;
    }
}

- (GameModel *)currentStep {
    
    return [self.gameSteps objectAtIndex:self.currentPage];
}
        
- (void)changePage:(int)direction {
    
    self.currentPage += direction;
}

- (BOOL)canChangePageBack {
    
    return self.currentPage > 0;
}

- (BOOL)canChangePageForward {
    
    return (self.currentPage < self.solvedPages) && (self.currentPage + 1 < self.gameSessionTasksLimit);
}

- (BOOL)gameSessionCompleted {
    
    return (self.solvedPages == self.gameSessionTasksLimit);
}

@end