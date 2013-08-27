//
//  AirconditionSwitchButton.m
//  SmartHome
//
//  Created by Zhao yang on 8/21/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "AirconditionSwitchButton.h"
#import "AirConditionViewController.h"

@implementation AirconditionSwitchButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initDefaults {
    [super initDefaults];
}

- (void)initUI {
    [super initUI];
    [self registerImage:[UIImage imageNamed:@"icon_device_off.png"] forStatus:@"off"];
    [self registerImage:[UIImage imageNamed:@"icon_device_on.png"] forStatus:@"on"];
}

- (void)btnPressed:(id)sender {
    AirConditionViewController *airConditionViewController = [[AirConditionViewController alloc] init];
    [self.ownerController presentModalViewController:airConditionViewController animated:YES];
}

@end
