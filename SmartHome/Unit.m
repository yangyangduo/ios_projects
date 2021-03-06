//
//  Unit.m
//  SmartHome
//
//  Created by Zhao yang on 8/30/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "Unit.h"

@interface Unit()

@end

@implementation Unit

@synthesize identifier;
@synthesize localPort;
@synthesize localIP;
@synthesize name;
@synthesize status;
@synthesize updateTime;
@synthesize zones;
@synthesize devices;
@synthesize hashCode;

@synthesize sceneHashCode;
@synthesize scenesModeList = _scenesModeList_;
@synthesize securityScenesModeList = _securityScenesModeList_;

@synthesize avalibleDevicesCount;

- (id)initWithJson:(NSDictionary *)json {
    self = [super init];
    if(self) {
        if(json != nil) {
            self.identifier = [json stringForKey:@"_id"];
            
            if(self.identifier != nil) {
                self.identifier = [self.identifier substringToIndex:self.identifier.length-4];
            }
            
            self.localIP = [json stringForKey:@"localIp"];
            self.name = [json stringForKey:@"name"];
            self.localPort = [json integerForKey:@"localPort"];
            self.status = [json stringForKey:@"status"];
            self.hashCode = [json numberForKey:@"hashCode"];
            self.updateTime = [json dateForKey:@"updateTime"];
            self.sceneHashCode = [json numberForKey:@"sceneHashCode"];
            
            NSArray *_zones_ = [json notNSNullObjectForKey:@"zones"];
            if(_zones_ != nil) {
                for(int i=0; i<_zones_.count; i++) {
                    NSDictionary *_zone_ = [_zones_ objectAtIndex:i];
                    Zone *zone = [[Zone alloc] initWithJson:_zone_];
                    zone.unit = self;
                    [self.zones addObject:zone];
                }
            }
            
            NSArray *_scenes_ = [json notNSNullObjectForKey:@"scenesList"];
            if(_scenes_ != nil) {
                for(int i=0; i<_scenes_.count; i++) {
                    NSDictionary *_scene_ = [_scenes_ objectAtIndex:i];
                    [self.scenesModeList addObject:[[SceneMode alloc] initWithJson:_scene_]];
                }
            }
        }
    }
    return self;
}

- (NSDictionary *)toJson {
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    [json setObject:([NSString isBlank:self.identifier] ? [NSString emptyString] : [NSString stringWithFormat:@"%@A001", self.identifier]) forKey:@"_id"];
    
    [json setMayBlankString:self.localIP forKey:@"localIp"];
    [json setMayBlankString:self.name forKey:@"name"];
    [json setInteger:self.localPort forKey:@"localPort"];
    [json setMayBlankString:self.status forKey:@"status"];
    [json setDateLongLongValue:self.updateTime forKey:@"updateTime"];
    
    [json setObject:(self.hashCode == nil ? [NSNumber numberWithInteger:0] : self.hashCode) forKey:@"hashCode"];
    [json setObject:(self.sceneHashCode == nil ? [NSNumber numberWithInteger:0] : self.sceneHashCode) forKey:@"sceneHashCode"];
    
    // zones ...
    NSMutableArray *_zones_ = [NSMutableArray array];
    for(int i=0; i<self.zones.count; i++) {
        Zone *zone = [self.zones objectAtIndex:i];
        [_zones_ addObject:[zone toJson]];
    }
    [json setObject:_zones_ forKey:@"zones"];
    
    // scene hash code
    
    // scenesModeList
    NSMutableArray *_smodes_ = [NSMutableArray array];
    for(int i=0; i<self.scenesModeList.count; i++) {
        SceneMode *smode = [self.scenesModeList objectAtIndex:i];
        [_smodes_ addObject:[smode toJson]];
    }
    [json setObject:_smodes_ forKey:@"scenesList"];
    
    return json;
}

- (NSMutableArray *)zones {
    if(zones == nil) {
        zones = [NSMutableArray array];
    }
    return zones;
}

- (Zone *)zoneForId:(NSString *)_id_ {
    if([NSString isBlank:_id_]) return nil;
    for(int i=0; i<self.zones.count; i++) {
        Zone *zone = [self.zones objectAtIndex:i];
        if([_id_ isEqualToString:zone.identifier]) {
            return zone;
        }
    }
    return nil;
}

- (Device *)deviceForId:(NSString *)_id_ {
    if([NSString isBlank:_id_]) return nil;
    for(int i=0; i<self.zones.count; i++) {
        Zone *zone = [self.zones objectAtIndex:i];
        Device *device = [zone deviceForId:_id_];
        if(device != nil) {
            return device;
        }
    }
    return nil;
}

- (NSMutableArray *)scenesModeList {
    if(_scenesModeList_ == nil) {
        _scenesModeList_ = [NSMutableArray array];
    }
    return _scenesModeList_;
}

- (NSArray *)devices {
    NSMutableArray *_devices_ = [NSMutableArray array];
    if(self.zones.count != 0) {
        for(int i=0; i<self.zones.count; i++) {
            Zone *zone = [self.zones objectAtIndex:i];
            if(zone.devices != nil && zone.devices.count > 0) {
                [_devices_ addObjectsFromArray:zone.devices];
            }
        }
    }
    return _devices_;
}

- (NSUInteger)avalibleDevicesCount {
    int count = 0;
    for(Device *device in [self devices]) {
        if(device.state == 0) {
            count++;
        }
    }
    return count;
}

- (void)refreshSecurityScenesModeList {
    @synchronized(self) {
        if(_securityScenesModeList_ == nil) {
            _securityScenesModeList_ = [NSMutableArray array];
        } else {
            [_securityScenesModeList_ removeAllObjects];
        }
        for(int i=0; i<self.scenesModeList.count; i++) {
            SceneMode *sm = [self.scenesModeList objectAtIndex:i];
            if(sm.isSecurityMode) {
                [_securityScenesModeList_ addObject:sm];
            }
        }
    }
}

- (NSMutableArray *)securityScenesModeList {
    @synchronized(self) {
        if(_securityScenesModeList_ == nil) {
            [self refreshSecurityScenesModeList];
        }
        return _securityScenesModeList_;
    }
}

@end
