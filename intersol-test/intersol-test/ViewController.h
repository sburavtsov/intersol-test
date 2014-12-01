//
//  ViewController.h
//  intersol-test
//
//  Created by Sergey Buravtsov on 11/25/14.
//  Copyright (c) 2014 Sergey Buravtsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameCenterManager/GameCenterManager.h>
#import <Vkontakte-iOS-SDK-LV/VkontakteSDK.h>

@interface ViewController : UIViewController <GameCenterManagerDelegate, VKConnectorDelegate, VKRequestDelegate>

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController;

@end

