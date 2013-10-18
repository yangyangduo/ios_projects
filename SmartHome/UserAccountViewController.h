//
//  UserAccountViewController.h
//  SmartHome
//
//  Created by hadoop user account on 2/09/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "NavViewController.h"
#import "SMCell.h"
#import "ModifyInfoViewController.h"
#import "DeviceCommandUpdateAccountHandler.h"
#import "DeviceCommandGetAccountHandler.h"

@interface UserAccountViewController : NavViewController<UITableViewDataSource, UITableViewDelegate, TextViewDelegate,UIAlertViewDelegate, DeviceCommandGetAccountDelegate, DeviceCommandUpdateAccountDelegate>

@property (nonatomic,strong) NSMutableDictionary *infoDictionary;

@end
