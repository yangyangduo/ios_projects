//
//  AppDelegate.h
//  SmartHome
//
//  Created by Zhao yang on 8/5/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmsService.h"
#import "GlobalSettings.h"
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SmsService *smsService;
@property (strong, nonatomic) GlobalSettings *settings;
@property (strong, nonatomic) RootViewController *rootViewController;

@end
