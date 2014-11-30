//
//  GameStepModel.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/30/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "GameStepModel.h"

@implementation GameStepModel

@synthesize isSolved;

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        
        return nil;
    }
    
    self.selectedWordsIndexes = [NSMutableArray array];
    self.selectedWordsTranslations = [NSMutableArray array];
    isSolved = NO;
    
    _userTranslationIndex = -1;

    return self;
}

- (void)setCorrectTranslationIndex:(NSNumber *)correctTranslationIndex {
    
    _correctTranslationIndex = correctTranslationIndex;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStepReady" object:self];
}

- (void)setUserTranslationIndex:(int)userTranslationIndex {

    isSolved = YES;
    _userTranslationIndex = userTranslationIndex;
    if (userTranslationIndex == [_correctTranslationIndex integerValue]) {
        
        _score = 10;
    }
}


- (BOOL)isSolved {
    
    return isSolved;
}

- (BOOL) solutionIsCorrect {
    
    return (_userTranslationIndex == [_correctTranslationIndex integerValue]);
}

@end
