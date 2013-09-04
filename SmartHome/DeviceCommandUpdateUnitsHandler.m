//
//  DeviceCommandUpdateUnitsHandler.m
//  SmartHome
//
//  Created by hadoop user account on 30/08/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "DeviceCommandUpdateUnitsHandler.h"
#import "Unit.h"

#define DELEFGATE_METHOD @selector(updateUnits:)

@implementation DeviceCommandUpdateUnitsHandler


- (void)handle:(DeviceCommand *)command {
    [super handle:command];
    
    NSLog(@" trigger device command update units .");
    if (command.resultID !=1) return;
    if(![command isKindOfClass:[DeviceCommandUpdateUnits class]]) return;
    DeviceCommandUpdateUnits *updateUnitsCommand = (DeviceCommandUpdateUnits *)command;
    
    Memory *memory = [SMShared current].memory;
    NSArray *newUnits = [memory replaceWithUnits:updateUnitsCommand.units];
    NSLog(@"newUnits=%@,updateUnits=%@",newUnits,updateUnitsCommand.units);
    NSArray *users = [memory getSubscriptionsFor:[DeviceCommandUpdateUnitsHandler class]];
    [users enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:DELEFGATE_METHOD]) {
            [obj performSelector:DELEFGATE_METHOD withObject:newUnits];
        }
    }];
}


@end
