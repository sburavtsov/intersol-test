//
//  ViewController.m
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import "ViewController.h"

#import "YandexTranslateAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    YandexTranslateAPIClient *translateClient = [YandexTranslateAPIClient sharedClient];
    
    [translateClient getLanguages:^(NSURLSessionDataTask *task, id responseObject) {

        NSLog(@"Success: %@", responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"Failure: %@", error);
    }];
}
     
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
