//
//  DeviceCommandGetUnitsHandler.m
//  SmartHome
//
//  Created by hadoop user account on 30/08/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "DeviceCommandGetUnitsHandler.h"
#import "CommandFactory.h"
#import "Unit.h"
#import "UnitsListUpdatedEvent.h"
#import "XXEventSubscriptionPublisher.h"

@implementation DeviceCommandGetUnitsHandler

- (void)handle:(DeviceCommand *)command {
    [super handle:command];
    if([command isKindOfClass:[DeviceCommandUpdateUnits class]]) {
        
        DeviceCommandUpdateUnits *updateUnitsCommand = (DeviceCommandUpdateUnits *)command;
        
        // update units
        if([NSString isBlank:updateUnitsCommand.masterDeviceCode]) {
            [[SMShared current].memory replaceUnits:updateUnitsCommand.units];
            if(updateUnitsCommand.units != nil) {
                for(int i=0; i<updateUnitsCommand.units.count; i++) {
                    Unit *unit = [updateUnitsCommand.units objectAtIndex:i];
                    DeviceCommand *cmd = [CommandFactory commandForType:CommandTypeGetSceneList];
                    cmd.masterDeviceCode = unit.identifier;
                    cmd.hashCode = unit.sceneHashCode;
                    cmd.commmandNetworkMode = CommandNetworkModeExternal;
                    [[SMShared current].deliveryService executeDeviceCommand:cmd];
                }
            }
        // update unit
        } else {
            if(updateUnitsCommand.resultID == -1) {
                // this unit is has not binding before, need to remove it .
                [[SMShared current].memory removeUnitByIdentifier:updateUnitsCommand.masterDeviceCode];
            } else {
                if(updateUnitsCommand.units.count > 0) {
                    Unit *unit = [updateUnitsCommand.units objectAtIndex:0];
                    [[SMShared current].memory updateUnit:unit];
                }
            }
        }
        
        [[XXEventSubscriptionPublisher defaultPublisher] publishWithEvent:[[UnitsListUpdatedEvent alloc] init]];
    }
}

@end
