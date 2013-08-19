//
//  LongButton.m
//  SmartHome
//
//  Created by hadoop user account on 16/08/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "LongButton.h"

@implementation LongButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIButton *) buttonWithPoint:(CGPoint) point{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(point.x, point.y, 616/2, 96/2)];
    [button setBackgroundImage:[UIImage imageNamed:@"long_button.png"] forState:UIControlStateNormal];
    return button;
    
}


@end