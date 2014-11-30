//
//  GameStepModel.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/30/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "GameStepModel.h"

@implementation GameStepModel

- (instancetype)init {
    
    self = [super init];
    
    if (!self) {
        
        return nil;
    }
    
    self.selectedWordsIndexes = [NSMutableArray array];
    self.selectedWordsTranslations = [NSMutableArray array];

    return self;
}

- (void)setCorrectTranslationIndex:(int)correctTranslationIndex {
    
    _correctTranslationIndex = correctTranslationIndex;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStepReady" object:self];
}


@end
