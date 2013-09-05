//
//  PopViewController.h
//  SmartHome
//
//  Created by Zhao yang on 8/27/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "BaseViewController.h"
#import "TopbarView.h"

@protocol StatusChangeDelegate <NSObject>

- (void)notifyStatusChangedFor:(NSString *)deviceId;

@end

@interface PopViewController : BaseViewController

@property (strong, nonatomic) TopbarView *topbar;
@property (strong, nonatomic) UIViewController *preViewController;
@property (assign, nonatomic) id<StatusChangeDelegate> delegate;

- (void)generateTopbar;
- (void)dismiss;

@end
