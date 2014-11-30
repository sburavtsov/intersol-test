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

    return self;
}

- (void)setCorrectTranslationIndex:(NSNumber *)correctTranslationIndex {
    
    _correctTranslationIndex = correctTranslationIndex;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStepReady" object:self];
}

- (void)setUserTranslationIndex:(int)userTranslationIndex {

    isSolved = YES;
    
    if (userTranslationIndex == [_correctTranslationIndex integerValue]) {
        
        _score = 10;
    }
}


- (BOOL)isSolved {
    
    return isSolved;
}

@end
