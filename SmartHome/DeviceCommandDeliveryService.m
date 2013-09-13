//
//  DeviceCommandDeliveryService.m
//  SmartHome
//
//  Created by Zhao yang on 8/29/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "DeviceCommandDeliveryService.h"

#import "DeviceCommandGetUnitsHandler.h"
#import "DeviceCommandUpdateAccountHandler.h"
#import "DeviceCommandGetAccountHandler.h"
#import "DeviceCommandGetNotificationsHandler.h"
#import "DeviceCommandVoiceControlHandler.h"
#import "DeviceCommandUpdateDevicesHandler.h"
#import "DeviceCommandGetSceneListHandler.h"

@implementation DeviceCommandDeliveryService

@synthesize tcpService;
@synthesize restfulService;
@synthesize isService;

- (id)init {
    self = [super init];
    if(self) {
        [self initDefaults];
    }
    return self;
}

- (void)initDefaults {
    isService = NO;
}

/*
 *
 *
 *
 */
- (void)executeDeviceCommand:(DeviceCommand *)command {
    if(!self.isService) return;
    
    [self.tcpService executeDeviceCommand:command];
}

/*
 *
 *
 *
 *
 */
- (void)handleDeviceCommand:(DeviceCommand *)command {
    
    if(!self.isService) return;
    
    if(command.resultID == -100) {
        NSLog(@"device command has been ignore .. [ %@ ]", command.commandName);
        //ignore this command
        return;
    }
    
    DeviceCommandHandler *handler = nil;
    if([@"FindZKListCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandGetUnitsHandler alloc] init];
    } else if([@"AccountUpdateCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandUpdateAccountHandler alloc] init];
    } else if([@"AccountProfileCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandGetAccountHandler alloc] init];
    } else if([@"AccountMQListCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandGetNotificationsHandler alloc] init];
    } else if([@"FindDeviceSceneCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandGetSceneListHandler alloc] init];
    } else if([@"VoiceControlCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandVoiceControlHandler alloc] init];
    } else if([@"DeviceFingerExcuteCommand" isEqualToString:command.commandName]) {
        handler = [[DeviceCommandUpdateDevicesHandler alloc] init];
    } 
        
    if(handler != nil) {
        [handler handle:command];
    }
}

- (void)startService {
    if(!self.isService) {
        [[SMShared current].memory loadUnitsFromDisk];
        if(![self.tcpService isConnect]) {
            [self performSelectorInBackground:@selector(startTcp) withObject:nil];
        }
        isService = YES;
    }
}

- (void)stopService {
    if(self.isService) {
        [self.tcpService disconnect];
        [[SMShared current].memory syncUnitsToDisk];
        isService = NO;
    }
}

- (void)startTcp {
    [self.tcpService connect];
}

#pragma mark -
#pragma mark getter and setters

- (TCPCommandService *)tcpService {
    if(tcpService == nil) {
        tcpService = [[TCPCommandService alloc] init];
    }
    return tcpService;
}

- (RestfulCommandService *)restfulService {
    return nil;
}

@end