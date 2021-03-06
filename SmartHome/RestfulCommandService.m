//
//  RestfulCommandService.m
//  SmartHome
//
//  Created by Zhao yang on 9/2/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "RestfulCommandService.h"
#import "NSString+StringUtils.h"
#import "SMShared.h"
#import "XXEventSubscriptionPublisher.h"
#import "DeviceCommandEvent.h"

@implementation RestfulCommandService

- (id)init {
    self = [super init];
    if(self) {
        [super setupWithUrl:[NSString emptyString]];
        self.client.timeoutInterval = 6;
    }
    return self;
}

- (void)executeCommand:(DeviceCommand *)command {
    Unit *unit = [[SMShared current].memory findUnitByIdentifier:command.masterDeviceCode];
    if(unit != nil) {
        command.restAddress = unit.localIP;
        command.restPort = unit.localPort;
    }
    
    if([COMMAND_GET_UNITS isEqualToString:command.commandName]) {
        DeviceCommandGetUnit *getUnitCommand = (DeviceCommandGetUnit *)command;
        if([NSString isBlank:getUnitCommand.unitServerUrl]) {
            [self getUnitByIdentifier:getUnitCommand.masterDeviceCode address:getUnitCommand.restAddress port:getUnitCommand.restPort hashCode:getUnitCommand.hashCode];
        } else {
            [self getUnitByUrl:getUnitCommand.unitServerUrl];
        }
    } else if([COMMAND_KEY_CONTROL isEqualToString:command.commandName]) {
        DeviceCommandUpdateDevice *updateDevice = (DeviceCommandUpdateDevice *)command;
        NSData *data = [JsonUtils createJsonDataFromDictionary:[updateDevice toDictionary]];
        [self updateDeviceWithAddress:updateDevice.restAddress port:updateDevice.restPort data:data];
    } else if([COMMAND_GET_SCENE_LIST isEqualToString:command.commandName]) {
        Unit *unit = [[SMShared current].memory findUnitByIdentifier:command.masterDeviceCode];
        if(unit != nil) {
            NSString *url = [NSString stringWithFormat:@"http://%@:%d/scenecfg?hashCode=%d", unit.localIP, unit.localPort, unit.sceneHashCode.integerValue];
            [self getSceneListByUrl:url unitIdentifier:command.masterDeviceCode];
        }
    } else if([COMMAND_GET_CAMERA_SERVER isEqualToString:command.commandName]) {
        if([command isKindOfClass:[DeviceCommandGetCameraServer class]]) {
            DeviceCommandGetCameraServer *getCameraServerCmd = (DeviceCommandGetCameraServer *)command;
            DeviceCommandReceivedCameraServer *cmd = [[DeviceCommandReceivedCameraServer alloc] init];
            cmd.commandName = COMMAND_GET_CAMERA_SERVER;
            cmd.cameraId = getCameraServerCmd.cameraId;
            cmd.commmandNetworkMode = CommandNetworkModeInternal;
            [self publishCommand:cmd];
        }
    }
}

- (NSString *)executorName {
    return @"RESTFUL SERVICE";
}

#pragma mark -
#pragma mark 

- (void)publishCommand:(DeviceCommand *)command {
    DeviceCommandEvent *event = [[DeviceCommandEvent alloc] initWithDeviceCommand:command];
    [[XXEventSubscriptionPublisher defaultPublisher] publishWithEvent:event];
}

#pragma mark -
#pragma mark Update devices from rest server

- (void)updateDeviceWithAddress:(NSString *)address port:(NSInteger)port data:(NSData *)data {
    NSString *url = [NSString stringWithFormat:@"http://%@:%d/executor", address, port];
    [self.client postForUrl:url acceptType:@"application/json" contentType:@"application/json" body:data success:@selector(updateDeviceSuccess:) error:@selector(updateDeviceFailed:) for:self callback:nil];
}

- (void)updateDeviceSuccess:(RestResponse *)resp {
    if(resp.statusCode == 200) {
        DeviceCommand *command = [CommandFactory commandFromJson:[JsonUtils createDictionaryFromJson:resp.body]];
        command.commmandNetworkMode = CommandNetworkModeInternal;
        [self publishCommand:command];
        return;
    }
    
    [self updateDeviceFailed:resp];
}

- (void)updateDeviceFailed:(RestResponse *)resp {
#ifdef DEBUG
    NSLog(@"[RESTFUL COMMAND SERVICE] Update device failed, status code is %d", resp.statusCode);
#endif
}

#pragma mark -
#pragma mark Get units from rest server

- (void)getUnitByIdentifier:(NSString *)unitIdentifier address:(NSString *)addr port:(NSInteger)port hashCode:(NSNumber *)hashCode {
        NSString *url = [NSString stringWithFormat:@"http://%@:%d/gatewaycfg?hashCode=%d", addr, port, hashCode.integerValue];
        [self getUnitByUrl:url];
}

- (void)getUnitByUrl:(NSString *)url {
    [self.client getForUrl:url acceptType:@"application/json" success:@selector(getUnitSucess:) error:@selector(getUnitFailed:) for:self callback:nil];
}

- (void)getUnitSucess:(RestResponse *)resp {
    if(resp.statusCode == 200) {
        NSDictionary *json = [JsonUtils createDictionaryFromJson:resp.body];
        if(json != nil) {
            Unit *unit = [[Unit alloc] initWithJson:json];
            if(unit != nil) {
                DeviceCommandUpdateUnits *updateUnit = [[DeviceCommandUpdateUnits alloc] init];
                updateUnit.commandName = COMMAND_GET_UNITS;
                updateUnit.masterDeviceCode = unit.identifier;
                updateUnit.commmandNetworkMode = CommandNetworkModeInternal;
                [updateUnit.units addObject:unit];
                //Current network mode must be internal, because this callback is from rest service .
                [[SMShared current].deliveryService setCurrentNetworkMode:NetworkModeInternal];
                [self publishCommand:updateUnit];
            }
        }
        return;
    } else if(resp.statusCode == 204) {
        // ignore this ... do not need to refresh local unit
        return;
    }
    [self getUnitFailed:resp];
}

- (void)getUnitFailed:(RestResponse *)resp {
#ifdef DEBUG
    NSLog(@"[RESTFUL COMMAND SERVICE] Get unit failed, staus code is %d", resp.statusCode);
#endif
}

#pragma mark -
#pragma mark Scene list from rest server

- (void)getSceneListByUrl:(NSString *)url unitIdentifier:(NSString *)identifier {
    [self.client getForUrl:url acceptType:@"application/json" success:@selector(getSceneListSuccess:) error:@selector(getSceneListFailed:) for:self callback:identifier];
}

- (void)getSceneListSuccess:(RestResponse *)resp {
    if(resp.statusCode == 200) {
        NSDictionary *json = [JsonUtils createDictionaryFromJson:resp.body];
        if(json != nil) {
            DeviceCommandUpdateSceneMode *command = [[DeviceCommandUpdateSceneMode alloc] initWithDictionary:json];
            command.commandName = COMMAND_GET_SCENE_LIST;
            command.masterDeviceCode = resp.callbackObject;
            command.commmandNetworkMode = CommandNetworkModeInternal;
            [self publishCommand:command];
            return;
        }
    } else if(resp.statusCode == 204) {
        // ignore this ... do not need to refresh local scene list
        return;
    }
    [self getSceneListFailed:resp];
}

- (void)getSceneListFailed:(RestResponse *)resp {
#ifdef DEBUG
    NSLog(@"[RESTFUL COMMAND SERVICE] Get scene list failed, staus code is %d", resp.statusCode);
#endif
}

@end
