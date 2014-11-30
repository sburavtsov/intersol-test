//
//  GameStepModel.h
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/30/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStepModel : NSObject

@property (nonatomic) NSMutableArray * selectedWordsIndexes;
@property (nonatomic) NSMutableArray * selectedWordsTranslations;
@property (nonatomic) NSNumber * correctTranslationIndex;
@property (nonatomic) int userTranslationIndex;
@property (nonatomic) int score;

@property (nonatomic, readonly) BOOL isSolved;

@end
