//
//  MyDevicesView.h
//  SmartHome
//
//  Created by hadoop user account on 12/08/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"
#import "XXEventSubscriber.h"

@interface MyDevicesView : NavigationView <UITableViewDelegate, UITableViewDataSource, XXEventSubscriber>

@end
