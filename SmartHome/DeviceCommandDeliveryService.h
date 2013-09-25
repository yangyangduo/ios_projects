//
//  DeviceCommandDeliveryService.h
//  SmartHome
//
//  Created by Zhao yang on 8/29/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCPCommandService.h"
#import "RestfulCommandService.h"
#import "DeviceCommand.h"

@interface DeviceCommandDeliveryService : NSObject

@property (strong, nonatomic, readonly) TCPCommandService *tcpService;
@property (strong, nonatomic, readonly) RestfulCommandService *restfulService;
@property (assign, nonatomic, readonly) BOOL isService;

- (void)executeDeviceCommand:(DeviceCommand *)command;
- (void)handleDeviceCommand:(DeviceCommand *)command;

/*
 Restful Service Callback Method
 ----------------------------------------------------*/
- (void)getUnitSucess:(RestResponse *)resp;
- (void)getUnitFailed:(RestResponse *)resp;

- (void)startService;
- (void)stopService;

@end
