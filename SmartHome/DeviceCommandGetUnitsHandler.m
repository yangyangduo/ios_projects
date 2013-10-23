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

@implementation DeviceCommandGetUnitsHandler

- (void)handle:(DeviceCommand *)command {
    [super handle:command];
    if([command isKindOfClass:[DeviceCommandUpdateUnits class]]) {
        
        DeviceCommandUpdateUnits *updateUnitsCommand = (DeviceCommandUpdateUnits *)command;
        
        // update units
        if([NSString isBlank:updateUnitsCommand.masterDeviceCode]) {
            [[SMShared current].memory replaceUnits:updateUnitsCommand.units];
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
        
        BOOL hasUnits = [SMShared current].memory.units.count > 0;
        BOOL anyUnitsBinding = [SMShared current].settings.anyUnitsBinding;
        if(anyUnitsBinding != hasUnits) {
            [SMShared current].settings.anyUnitsBinding = hasUnits;
            [[SMShared current].settings saveSettings];
        }
        
        // notify subscriptions
        NSArray *subscriptions = [[SMShared current].memory getSubscriptionsFor:[self class]];
        if(subscriptions) {
            for(int i=0; i<subscriptions.count; i++) {
                if([[subscriptions objectAtIndex:i] respondsToSelector:@selector(notifyUnitsWasUpdate)]) {
                    [[subscriptions objectAtIndex:i] performSelectorOnMainThread:@selector(notifyUnitsWasUpdate) withObject:nil waitUntilDone:NO];
                }
            }
        }
    }
}

@end
