//
//  DeviceCommandGetNotificationsHandler.m
//  SmartHome
//
//  Created by Zhao yang on 9/4/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "DeviceCommandGetNotificationsHandler.h"
#import "NotificationsFileManager.h"

@implementation DeviceCommandGetNotificationsHandler

- (void)handle:(DeviceCommand *)command {
    [super handle:command];
    if([command isKindOfClass:[DeviceCommandUpdateNotifications class]]) {
        NSLog(@"trigger get notification handler...");
        DeviceCommandUpdateNotifications *receivedNotificationsCommand = (DeviceCommandUpdateNotifications *)command;
        // do service here ...
        
        [[NotificationsFileManager fileManager] writeToDisk:receivedNotificationsCommand.notifications];
    }
}

@end
