//
//  ViewController.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "ViewController.h"

#import "YandexTranslateAPIClient.h"
#import "RandomWordAPIClient.h"

#import "GameModel.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *wordToTranslate;

@property (weak, nonatomic) IBOutlet UIButton *translation1Button;
@property (weak, nonatomic) IBOutlet UIButton *translation2Button;
@property (weak, nonatomic) IBOutlet UIButton *translation3Button;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (weak, nonatomic) IBOutlet UIButton *previousPageButton;

- (IBAction)translationCaseSubmitted:(UIButton *)sender;
- (IBAction)changePage:(UIButton *)sender;

@property (nonatomic) RandomWordAPIClient * randomWordClient;
@property (nonatomic) YandexTranslateAPIClient * translateClient;
@property (nonatomic) GameModel *gameModel;

@end

@implementation ViewController

- (void)displayError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedFailureReason
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)updateButton:(UIButton *)button forIndex:(int)index {
    
    GameStepModel *model = self.gameModel.currentStep;
    
    [button setTitle:[model.selectedWordsTranslations objectAtIndex:index] forState:UIControlStateNormal];
    button.tag = [[model.selectedWordsIndexes objectAtIndex:index] integerValue];
    button.enabled = ! model.isSolved;
/*
    if (model.isSolved) {

        if (button.tag == [model.correctTranslationIndex integerValue]) {
            
            button.backgroundColor = [UIColor greenColor];
        } else {
            
            button.backgroundColor = [UIColor redColor];
        }
    } else {
        
        button.backgroundColor = [UIColor lightGrayColor];
    }
 */
}

- (void)reloadGameView {

    GameStepModel *model = self.gameModel.currentStep;
    
    self.wordToTranslate.text = [self.gameModel.sourceWordsBase objectAtIndex:[model.correctTranslationIndex integerValue]];
    
    if (! model.isSolved) {
        
        self.wordToTranslate.backgroundColor = [UIColor lightGrayColor];
    } else {
        
        if (model.solutionIsCorrect) {
            
            self.wordToTranslate.backgroundColor = [UIColor greenColor];
        } else {
            
            self.wordToTranslate.backgroundColor = [UIColor redColor];
        }
    }
    
    [self updateButton:self.translation1Button forIndex:0];
    [self updateButton:self.translation2Button forIndex:1];
    [self updateButton:self.translation3Button forIndex:2];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%d", self.gameModel.currentPage];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.gameModel.playersScore];
    
    self.nextPageButton.enabled = self.gameModel.canChangePageForward;
    self.previousPageButton.enabled = self.gameModel.canChangePageBack;
}

- (void)requestTranslations {
    
    for (int i = 0; i < self.gameModel.gameSessionTasksLimit; i++) {
        
        GameStepModel * stepModel = [[GameStepModel alloc] init];

        for (int word = 0; word < self.gameModel.gameStepCasesLimit; word++) {

            int wordToTranslateIndex = arc4random_uniform([self.gameModel.sourceWordsBase count]);
            
            [self.translateClient translateWord:[self.gameModel.sourceWordsBase objectAtIndex:wordToTranslateIndex]
                                        success:^(NSString *translationResult) {
                                            
                                            [stepModel.selectedWordsIndexes addObject:[NSNumber numberWithInt:wordToTranslateIndex]];
                                             
                                            [stepModel.selectedWordsTranslations addObject:translationResult];
                                            
                                            if ([stepModel.selectedWordsIndexes count] >= self.gameModel.gameStepCasesLimit) {
                                                
                                                stepModel.correctTranslationIndex = [stepModel.selectedWordsIndexes objectAtIndex:arc4random_uniform([stepModel.selectedWordsIndexes count])];
                                            }
                                        } failure:^(NSError *error) {
                                            
                                            [self displayError:error];
                                        }];
        }
        
        [self.gameModel.gameSteps addObject:stepModel];
    }
}

- (void)requestSourceWords {
    
    self.gameModel.sourceWordsBase = [NSArray arrayWithObjects:@"test",@"beauty", @"fun", @"salt", @"pepper", @"bike", @"daemon", @"chicken", @"cannon", @"folder", @"river", @"rain", nil];

    [self requestTranslations];
    /*
    
    [self.randomWordClient getWords:self.gameModel.gameSessionTasksLimit * self.gameModel.gameStepCasesLimit success:^(NSArray *randomWordsArray) {
        
        self.gameModel.sourceWordsBase = randomWordsArray;
        [self requestTranslations];
    } failure:^(NSError *error) {
        
        [self displayError:error];
    }];
     */
}

- (void)initializeModel {
    
    self.gameModel = [[GameModel alloc] init];
    [self requestSourceWords];
}

- (void)gameStepInitialized:(NSNotification *)notification {

    int index = [self.gameModel.gameSteps indexOfObject:notification.object];
    
    if (self.gameModel.currentPage == index) {
        
        [self reloadGameView];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.scoreLabel.text = @"0";

    self.translateClient = [YandexTranslateAPIClient sharedClient];
    self.randomWordClient = [RandomWordAPIClient sharedClient];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStepInitialized:) name:@"gameStepReady" object:nil];

    [self initializeModel];

    /*
    [self.translateClient translateWord:@"world" success:^(NSString *translationResult) {

        NSLog(@"Translated to: %@", translationResult);
    } failure:^(NSError *error) {
        
        NSLog(@"Failure: %@", error);
    }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)translationCaseSubmitted:(UIButton *)sender {

    [self.gameModel stepSolved:sender.tag];
    [self reloadGameView];
}

- (IBAction)changePage:(UIButton *)sender {
    
    [self.gameModel changePage:sender.tag];
    [self reloadGameView];
}
@end
