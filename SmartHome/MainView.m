//
//  MainView.m
//  SmartHome
//
//  Created by Zhao yang on 8/5/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//


#import "MainView.h"
//#import "NotificationsViewController.h"
//#import "UIColor+ExtentionForHexString.h"
//#import "SMDateFormatter.h"
//#import "SceneMode.h"
//#import "CommandFactory.h"
//#import "NotificationsFileManager.h"
//#import "UnitView.h"
//
//#define SPEECH_BUTTON_WIDTH              173
//#define SPEECH_BUTTON_HEIGHT             173
//
//typedef NS_ENUM(NSInteger, SpeechViewState) {
//    SpeechViewStateOpenning   = 1,
//    SpeechViewStateOpenned    = 2,
//    SpeechViewStateClosing    = 3,
//    SpeechViewStateClosed     = 4
//};
//
//typedef NS_ENUM(NSInteger, RecognizerState) {
//    RecognizerStateReady,
//    RecognizerStateRecordBegin,
//    RecognizerStateRecording,
//    RecognizerStateRecordingEnd,
//    RecognizerStateProceesing
//};

@implementation MainView {
//    SpeechViewState speechViewState;
//    RecognizerState recognizerState;
//    ConversationView *speechView;
//    UnitView *unitView;
//    SpeechRecognitionUtil *speechRecognitionUtil;
//
//    UIButton *btnSpeech;
//    UIImageView *imgSpeechVolumnAffect;
//    
//    UIButton *btnUnit;
//    UIButton *btnScene;
//    
//    UIView *notificationView;
//    UIButton *btnMessage;
//    UILabel *lblMessage;
//    UILabel *lblTime;
//    UILabel *lblAffectDevice;
//    UIButton *btnMessageCount;
//    
//    SMNotification *displayNotification;
//    
//    NSString *titleString;
//    NSString *stateString;
//    NSString *statusString;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//- (void)initDefaults {
//    [super initDefaults];
//    
//    speechViewState = SpeechViewStateClosed;
//    recognizerState = RecognizerStateReady;
//}
//
//- (void)subscribeEvents {
//    [[SMShared current].memory subscribeHandler:[DeviceCommandGetUnitsHandler class] for:self];
//    [[SMShared current].memory subscribeHandler:[DeviceCommandGetNotificationsHandler class] for:self];
//    [[SMShared current].memory subscribeHandler:[DeviceCommandVoiceControlHandler class] for:self];
//    [[SMShared current].memory subscribeHandler:[DeviceCommandDeliveryService class] for:self];
//}
//
//- (void)unSubscribeEvents {
//    [[SMShared current].memory unSubscribeHandler:[DeviceCommandGetUnitsHandler class] for:self];
//    [[SMShared current].memory unSubscribeHandler:[DeviceCommandGetNotificationsHandler class] for:self];
//    [[SMShared current].memory unSubscribeHandler:[DeviceCommandVoiceControlHandler class] for:self];
//    [[SMShared current].memory unSubscribeHandler:[DeviceCommandDeliveryService class] for:self];
//}
//
//- (void)initUI {
//    [super initUI];
//    
//    [self.topbar.rightButton setBackgroundImage:[UIImage imageNamed:@"icon_red.png"] forState:UIControlStateNormal];
//    [self.topbar.rightButton setBackgroundImage:[UIImage imageNamed:@"icon_red.png"] forState:UIControlStateHighlighted];
//
//#pragma mark -
//#pragma selection button (units && scene)
//    
//    CGFloat margin = (self.bounds.size.height-self.topbar.frame.size.height-355)/4;
//    if(btnUnit == nil) {
//        btnUnit = [[UIButton alloc] initWithFrame:CGRectMake(15, self.topbar.frame.size.height+margin, 227 / 2, 73 / 2)];
//        [btnUnit setBackgroundImage:[UIImage imageNamed:@"btn_unit.png"] forState:UIControlStateNormal];
//        [btnUnit setBackgroundImage:[UIImage imageNamed:@"btn_unit.png"] forState:UIControlStateHighlighted];
//        [btnUnit addTarget:self action:@selector(btnShowUnitsList:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btnUnit];
//    }
//    
//    if(btnScene == nil) {
//        btnScene = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 227/2-15, self.topbar.frame.size.height+margin, 227 /2, 73 / 2)];
//        [btnScene setBackgroundImage:[UIImage imageNamed:@"btn_scene.png"] forState:UIControlStateNormal];
//        [btnScene setBackgroundImage:[UIImage imageNamed:@"btn_scene.png"] forState:UIControlStateHighlighted];
//        [btnScene addTarget:self action:@selector(btnShowSceneList:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btnScene];
//    }
//    
//#pragma mark -
//#pragma mark speech button
//    
//    if(imgSpeechVolumnAffect == nil) {
//        imgSpeechVolumnAffect = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2), 417 / 2, 195 / 2)];
//        
//        NSMutableArray *animateImages = [NSMutableArray arrayWithCapacity:5];
//        for(int i=1; i<=5; i++) {
//            NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"sp-a-%d@2x", i] ofType:@"png"];
//            [animateImages addObject:[UIImage imageWithContentsOfFile:filePath]];
//        }
//        imgSpeechVolumnAffect.animationImages = animateImages;
//        imgSpeechVolumnAffect.animationDuration = 1.5f;
//        imgSpeechVolumnAffect.hidden = YES;
//        [self addSubview:imgSpeechVolumnAffect];
//    }
//    
//    if(btnSpeech == nil) {
//        btnSpeech = [[UIButton alloc] initWithFrame:CGRectMake(((self.frame.size.width - SPEECH_BUTTON_WIDTH/2) / 2), (self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2 - 7), (SPEECH_BUTTON_WIDTH / 2), (SPEECH_BUTTON_HEIGHT / 2))];
//        [btnSpeech setBackgroundImage:[UIImage imageNamed:@"btn_speech.png"] forState:UIControlStateNormal];
//        [btnSpeech setBackgroundImage:[UIImage imageNamed:@"btn_speech.png"] forState:UIControlStateHighlighted];
//        
//        [btnSpeech addTarget:self action:@selector(btnSpeechTouchDown:) forControlEvents:UIControlEventTouchDown];
//        [btnSpeech addTarget:self action:@selector(btnSpeechTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        [btnSpeech addTarget:self action:@selector(btnSpeechTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//        [btnSpeech addTarget:self action:@selector(btnSpeechTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
//        [btnSpeech addTarget:self action:@selector(btnSpeechTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
//        
//        [self addSubview:btnSpeech];
//        
//        imgSpeechVolumnAffect.center = CGPointMake(160, btnSpeech.center.y - 1);
//    }
//    
//#pragma mark -
//#pragma mark units view
//    
//    if(unitView == nil) {
//        unitView = [UnitView unitViewWithPoint:CGPointMake(0, (self.bounds.size.height - 198 / 2 - margin-180)) ownerViewController:self.ownerController];
//        [self addSubview:unitView];
//    }
//    
//#pragma mark -
//#pragma mark notifications view
//    
//    if(notificationView == nil) {
//        notificationView = [[UIView alloc] initWithFrame:CGRectMake(10, (unitView.frame.origin.y - 40 - margin), [UIScreen mainScreen].bounds.size.width, 40)];
//        
//        btnMessage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25/2, 30/2)];
//        btnMessage.center = CGPointMake(btnMessage.center.x, notificationView.bounds.size.height / 2);
//        [btnMessage setBackgroundImage:[UIImage imageNamed:@"icon_sound"] forState:UIControlStateNormal];
//        [btnMessage addTarget:self action:@selector(tapGestureHandler) forControlEvents:UIControlEventTouchUpInside];
//        [notificationView addSubview:btnMessage];
//    
//        lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(btnMessage.frame.origin.x+25/2+15,btnMessage.frame.origin.y-10, 120, 20)];
//        lblMessage.backgroundColor = [UIColor clearColor];
//        lblMessage.font = [UIFont systemFontOfSize:14];
//        lblMessage.text = @"";
//        lblMessage.textColor = [UIColor lightTextColor];
//        lblMessage.userInteractionEnabled = YES;
//        [lblMessage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler)]];
//        [notificationView addSubview:lblMessage];
//    
//        lblTime = [[UILabel alloc]initWithFrame:CGRectMake(lblMessage.frame.origin.x, lblMessage.frame.origin.y+lblMessage.frame.size.height, 100, 10)];
//        lblTime.backgroundColor =[UIColor clearColor];
//        lblTime.text = @"";
//        lblTime.font = [UIFont systemFontOfSize:12];
//        lblTime.textColor = [UIColor lightTextColor];
//        [notificationView addSubview: lblTime];
//        
//        UIImageView *imgAffectDevice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"device_count.png"]];
//        imgAffectDevice.frame = CGRectMake(lblMessage.frame.origin.x+lblMessage.frame.size.width + 40, 0, 44/2, 46/2);
//        imgAffectDevice.center = CGPointMake(imgAffectDevice.center.x, notificationView.bounds.size.height / 2);
//        [notificationView addSubview:imgAffectDevice];
//        
//        lblAffectDevice = [[UILabel alloc] initWithFrame:CGRectMake(imgAffectDevice.frame.origin.x+imgAffectDevice.frame.size.width + 10, 0, 20, 20)];
//        lblAffectDevice.center = CGPointMake(lblAffectDevice.center.x, notificationView.bounds.size.height / 2);
//        lblAffectDevice.text = @"0";
//        lblAffectDevice.textColor = [UIColor colorWithHexString:@"dfa800"];
//        lblAffectDevice.font = [UIFont systemFontOfSize:14];
//        lblAffectDevice.backgroundColor = [UIColor clearColor];
//        [notificationView addSubview:lblAffectDevice];
//    
//        UIButton *btnNotification = [[UIButton alloc] initWithFrame:CGRectMake(lblAffectDevice.frame.origin.x+30, 0, 44/2, 46/2)];
//        [btnNotification setBackgroundImage:[UIImage imageNamed:@"message_count.png"] forState:UIControlStateNormal];
//        [btnNotification setBackgroundImage:[UIImage imageNamed:@"message_count.png"] forState:UIControlStateHighlighted];
//        btnNotification.center = CGPointMake(btnNotification.center.x, notificationView.bounds.size.height / 2);
//        [btnNotification addTarget:self action:@selector(btnShowNotificationPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [notificationView addSubview:btnNotification];
//
//        btnMessageCount = [[UIButton alloc] initWithFrame:CGRectMake(btnNotification.frame.origin.x+btnNotification.frame.size.width-5, 0, 40, 20)];
//        btnMessageCount.center = CGPointMake(btnMessageCount.center.x, notificationView.bounds.size.height /2 );
//        [btnMessageCount setTitle:@"" forState:UIControlStateNormal];
//        [btnMessageCount setTitleColor:[UIColor colorWithHexString:@"dfa800"] forState:UIControlStateNormal];
//        btnMessageCount.backgroundColor = [UIColor clearColor];
//        btnMessageCount.titleLabel.font = [UIFont systemFontOfSize:14];
//        [btnMessageCount addTarget:self action:@selector(btnShowNotificationPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [notificationView addSubview:btnMessageCount];
//        
//        [self addSubview:notificationView];
//    }
//}
//
//- (void)setUp {
//    [self subscribeEvents];
//}
//
///*
// *
// *
// *
// */
//- (void)viewBecomeActive {
//    [self notifyUnitsWasUpdate];
//    [self notifyUpdateNotifications];
//}
//
//#pragma mark-
//#pragma mark notification
//
//// show notification details
//
//- (void)tapGestureHandler {
//    if (displayNotification == nil) return;
//    displayNotification.hasRead = YES;
//    NotificationsFileManager *fileManager = [[NotificationsFileManager alloc] init];
//    [fileManager update:[[NSArray alloc] initWithObjects:displayNotification, nil] deleteList:nil];
//    [self notifyUpdateNotifications];
//    NotificationDetailsViewController *handler = [[NotificationDetailsViewController alloc] initWithNotification:displayNotification];
////    handler.deleteNotificationDelegate = self;
////    handler.cfNotificationDelegate = self;
//    [self.ownerController.navigationController pushViewController:handler animated:YES];
//}
//
//- (void)didAgreeOrRefuse:(NSString *)operation {
//    if (operation == nil) return;
//    displayNotification.text = [displayNotification.text stringByAppendingString:NSLocalizedString(operation, @"")];
//    displayNotification.hasProcess = YES;
//    NotificationsFileManager *fileManager = [[NotificationsFileManager alloc] init];
//    [fileManager update:[[NSArray alloc] initWithObjects:displayNotification, nil] deleteList:nil];
//    [self notifyUpdateNotifications];
//}
//
//- (void)didWhenDeleted {
//    NotificationsFileManager *fileManager = [[NotificationsFileManager alloc] init];
//    [fileManager update:nil deleteList:[[NSArray alloc] initWithObjects:displayNotification, nil]];
//    [[AlertView currentAlertView] setMessage:NSLocalizedString(@"delete_success", @"") forType:AlertViewTypeSuccess];
//    [[AlertView currentAlertView] delayDismissAlertView];
//    [self notifyUpdateNotifications];
//}
//
//- (NSInteger)countOfNotRead:(NSArray *)notificationsArr {
//    NSInteger count = 0;
//    for (SMNotification *notification in notificationsArr) {
//        if(!notification.hasRead) count++;
//    }
//    return count;
//}
//
//- (void)updateNotifications:(NSArray *)notifications {
//    if (notifications == nil || notifications.count == 0) {
//        lblMessage.text = NSLocalizedString(@"everythings_fine", @"");
//        lblTime.text = [NSString emptyString];
//        [btnMessageCount setTitle:@"0" forState:UIControlStateNormal];
//        displayNotification = nil;
//        return;
//    }
//    NSTimeInterval lastTime = 0;
//    NSTimeInterval alLastTime = 0;
//    SMNotification *lastNotHandlerAlNotification;
//    for (SMNotification *notification in notifications) {
//        if ([notification.createTime timeIntervalSince1970]>=lastTime) {
//            lastTime = [notification.createTime timeIntervalSince1970];
//            displayNotification = notification;
//        }
//        if ([notification.type isEqualToString:@"AL"] && alLastTime<[notification.createTime timeIntervalSince1970] && !notification.hasRead) {
//            alLastTime = [notification.createTime timeIntervalSince1970];
//            lastNotHandlerAlNotification = notification;
//        }
//    }
//    if(lastNotHandlerAlNotification != nil) {
//        displayNotification = lastNotHandlerAlNotification;
//    }
//    lblMessage.text = displayNotification.text;
//    lblTime.text =  [SMDateFormatter dateToString:displayNotification.createTime format:@"MM-dd HH:mm"];
//    [btnMessageCount setTitle:[NSString stringWithFormat:@"%i",[self countOfNotRead:notifications]] forState:UIControlStateNormal];
//    return;
//}
//
//- (void)showNotificationDetailsByIdentifier:(NSString *)identifier {
//    if([NSString isBlank:identifier]) return;
//    NSArray *notifications = [[NotificationsFileManager fileManager] readFromDisk];
//    if(notifications != nil) {
//        for(SMNotification *notification in notifications) {
//            if([notification.identifier isEqualToString:identifier]) {
//                NotificationDetailsViewController *handler = [[NotificationDetailsViewController alloc] initWithNotification:notification];
////                handler.deleteNotificationDelegate = self;
////                handler.cfNotificationDelegate = self;
//                [self.ownerController.navigationController pushViewController:handler animated:NO];
//                break;
//            }
//        }
//    }
//}
//
//#pragma mark -
//#pragma mark selection view delegate
//
//- (void)selectionViewNotifyItemSelected:(id)item from:(NSString *)source {
//    if([NSString isBlank:source]) return;
//    SelectionItem *it = item;
//    if(it == nil) return;
//    if([@"scene" isEqualToString:source]) {
//        DeviceCommandUpdateDevice *updateDeviceCommand = (DeviceCommandUpdateDevice *)[CommandFactory commandForType:CommandTypeUpdateDevice];
//        updateDeviceCommand.masterDeviceCode = [SMShared current].memory.currentUnit.identifier;
//        [updateDeviceCommand addCommandString:[NSString stringWithFormat:@"scene-%@", it.identifier]];
//        [[SMShared current].deliveryService executeDeviceCommand:updateDeviceCommand
//         ];
//    } else if([@"units" isEqualToString:source]) {
//        [[SMShared current].memory changeCurrentUnitTo:it.identifier];
//        [self notifyUnitsWasUpdate];
//        [[SMShared current].deliveryService fireRefreshUnit];
//    }
//}
//
//
//#pragma mark -
//#pragma mark voice control handler
//
//- (void)notifyVoiceControlAccept:(DeviceCommandVoiceControl *)command {
//    if(command == nil || speechView == nil) return;
//    if(speechViewState == SpeechViewStateOpenned) {
//        ConversationTextMessage *textMessage = [[ConversationTextMessage alloc] init];
//        textMessage.messageOwner = MESSAGE_OWNER_MINE;
//        textMessage.textMessage = command.voiceText;
//        textMessage.timeMessage = [SMDateFormatter dateToString:[NSDate date] format:@"HH:mm:ss"];
//        [speechView addMessage:textMessage];
//        if(command.resultID != 1) {
//            ConversationTextMessage *textMessage = [[ConversationTextMessage alloc] init];
//            textMessage.messageOwner = MESSAGE_OWNER_THEIRS;
//            textMessage.textMessage = command.describe;
//            textMessage.timeMessage = [SMDateFormatter dateToString:[NSDate date] format:@"HH:mm:ss"];
//            [speechView addMessage:textMessage];
//        }
//    }
//}
//
//#pragma mark -
//#pragma mark device command upate unit handler
//
//- (void)notifyUnitsWasUpdate {
//    @synchronized(self) {
//        Unit *unit = [SMShared current].memory.currentUnit;
//        if(unit != nil && ![NSString isBlank:unit.name]) {
//            titleString = unit.name;
//            statusString = unit.status;
//        } else {
//            titleString = [NSString emptyString];
//        }
//        [self updateTitleLabel];
//        [unitView loadOrRefreshUnit:unit];
//        lblAffectDevice.text =  [NSString stringWithFormat:@"%d", (unit == nil) ? 0 : unit.avalibleDevicesCount];
//    }
//}
//
//- (void)notifyDevicesStatusWasUpdate:(DeviceCommandUpdateDevices *)command {
//    if(unitView != nil) {
//        [unitView notifyStatusChanged];
//    }
//    
//    if([NSString isBlank:command.voiceText] || speechView == nil) return;
//    
//    NSString *successMsg = [NSString stringWithFormat:@"[%@]", NSLocalizedString(@"execution_success", @"")] ;
//    NSString *successErr = [NSString stringWithFormat:@"[%@]", NSLocalizedString(@"execution_failed", @"")] ;
//    NSString *executeResult = (command.resultID == 1) ? successMsg : successErr;
//    
//    if(speechViewState == SpeechViewStateOpenned) {
//        ConversationTextMessage *textMessage = [[ConversationTextMessage alloc] init];
//        textMessage.messageOwner = MESSAGE_OWNER_THEIRS;
//        textMessage.textMessage = [NSString stringWithFormat:@"%@ %@", command.voiceText, executeResult];
//        textMessage.timeMessage = [SMDateFormatter dateToString:[NSDate date] format:@"HH:mm:ss"];
//        [speechView addMessage:textMessage];
//    }
//}
//
//#pragma mark
//#pragma mark device command get notifications handler
//
//- (void)notifyUpdateNotifications {
//    NSArray *notifications = [[NotificationsFileManager fileManager] readFromDisk];
//    if(notifications == nil || notifications.count == 0) {
//        // notifications is empty
//        [self updateNotifications:nil];
//    }else {
//        // has notifications
//        [self updateNotifications:notifications];
//    }
//}
//
//#pragma mark -
//#pragma mark command delivery service delegate
//
//- (void)changeStateIconColor:(NSString *)colorStr {
//    [self.topbar.rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@.png", colorStr]] forState:UIControlStateNormal];
//    [self.topbar.rightButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%@.png", colorStr]] forState:UIControlStateHighlighted];
//}
//
//- (void)commandDeliveryServiceNotifyNetworkModeMayChanged:(NetworkMode)lastedNetwokMode {
//    
//    /*
//     *    Change Title label
//     */
//    
//    if(lastedNetwokMode == 1) {
//        // External
//        if([SMShared current].deliveryService.tcpService.isConnectted) {
//            stateString = NSLocalizedString(@"external", @"");
//        } else if([SMShared current].deliveryService.tcpService.isConnectting) {
//            stateString = NSLocalizedString(@"connectting", @"");
//        } else {
//            stateString = NSLocalizedString(@"disconnect", @"");
//        }
//    } else if(lastedNetwokMode == 2) {
//        // Internal
//        stateString = NSLocalizedString(@"internal", @"");
//    } else {
//        // Unknow
//        stateString = NSLocalizedString(@"disconnect", @"");
//    }
//    
//    [self updateTitleLabel];
//    
//    /*
//     *    Change Cloud Icon Color
//     */
//    
//    if(lastedNetwokMode == 1) {
//        if([SMShared current].deliveryService.tcpService.isConnectted) {
//            if([@"在线" isEqualToString:[SMShared current].memory.currentUnit.status]) {
//                [self changeStateIconColor:@"green"];
//            } else {
//                [self changeStateIconColor:@"yellow"];
//            }
//        } else {
//            [self changeStateIconColor:@"red"];
//        }
//        
//    } else if(lastedNetwokMode == 2) {
//        if([SMShared current].deliveryService.tcpService.isConnectted) {
//            [self changeStateIconColor:@"green"];
//        } else {
//            [self changeStateIconColor:@"yellow"];
//        }
//    } else {
//        [self changeStateIconColor:@"red"];
//    }
//    
//}
//
//- (void)updateTitleLabel {
//    if([NSString isBlank:stateString]) {
//        [self commandDeliveryServiceNotifyNetworkModeMayChanged:[SMShared current].deliveryService.currentNetworkMode];
//        return;
//    }
//    if(![NSString isBlank:titleString]) {
//        self.topbar.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", titleString, stateString];
//    } else {
//        self.topbar.titleLabel.text = NSLocalizedString(@"app.name", @"");
//    }
//}
//
//- (void)clearStateString {
//    stateString = [NSString emptyString];
//}
//
//#pragma mark -
//#pragma mark button pressed
//
//- (void)btnShowNotificationPressed:(id)sender {
////    NotificationsViewController *notificationViewController = [[NotificationsViewController alloc] initFrom:self];
////    [self.ownerController.navigationController pushViewController:notificationViewController animated:YES];
//}
//
//- (void)btnShowSceneList:(id)sender {
//    NSMutableArray *sList = [NSMutableArray array];
//    if([SMShared current].memory.currentUnit != nil) {
//        if([SMShared current].memory.currentUnit.scenesModeList != nil) {
//            for(SceneMode *sm in [SMShared current].memory.currentUnit.scenesModeList) {
//                [sList addObject:[[SelectionItem alloc] initWithIdentifier:[NSString stringWithFormat:@"%d", sm.code] andTitle:sm.name]];
//            }
//        }
//    }
//    [SelectionView showWithItems:sList selectedIdentifier:[NSString emptyString] source:@"scene" delegate:self];
//}
//
//- (void)btnShowUnitsList:(id)sender {
//    NSMutableArray *unitsList = [NSMutableArray array];
//    for(Unit *unit in [SMShared current].memory.units) {
//        [unitsList addObject:[[SelectionItem alloc] initWithIdentifier:unit.identifier andTitle:unit.name]];
//    }
//    NSString *selectedUnitIdentifier = [SMShared current].memory.currentUnit == nil ? [NSString emptyString] : [SMShared current].memory.currentUnit.identifier;
//
//    [SelectionView showWithItems:unitsList selectedIdentifier:selectedUnitIdentifier source:@"units" delegate:self];
//}
//
//
//#pragma mark -
//#pragma mark speech view
//
//- (void)showSpeechView {
//    if(speechViewState != SpeechViewStateClosed) return;
//    
//    speechViewState = SpeechViewStateOpenning;
//    [self.ownerController disableGestureForDrawerView];
//    
//    ConversationView *view = [self speechView];
//    [self addSubview:view];
//
//    [UIView animateWithDuration:0.3f
//                animations:^{
//                    view.frame = CGRectMake(view.frame.origin.x, ([UIDevice systemVersionIsMoreThanOrEuqal7] ? 22 : 12), view.frame.size.width, view.frame.size.height);
//                }
//                completion:^(BOOL finished) {
//                    speechViewState = SpeechViewStateOpenned;
//                    if(speechView.messageCount == 0) [speechView showWelcomeMessage];
//                }];
//}
//
//- (void)hideSpeechView {
//    if(speechViewState != SpeechViewStateOpenned) return;
//    
//    if(recognizerState != RecognizerStateReady) {
//        [speechRecognitionUtil stopListening];
//    }
//    
//    speechViewState = SpeechViewStateClosing;
//    [self.ownerController enableGestureForDrawerView];
//    
//    CGFloat viewHeight = self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2 - ([UIDevice systemVersionIsMoreThanOrEuqal7] ? 22 : 12);
//    ConversationView *view = [self speechView];
//    
//    [UIView animateWithDuration:0.3f
//                     animations:^{
//                         view.frame = CGRectMake(view.frame.origin.x, (0 - viewHeight - ([UIDevice systemVersionIsMoreThanOrEuqal7] ? 22 : 12)), view.frame.size.width, view.frame.size.height);
//                     }
//                     completion:^(BOOL finished) {
//                         [[self speechView] clearMessages];
//                         [[self speechView] hideWelcomeMessage];
//                         [[self speechView] removeFromSuperview];
//                         speechViewState = SpeechViewStateClosed;
//                     }];
//}
//
//- (void)startSpeechAnimate {
//    if(imgSpeechVolumnAffect != nil) {
//        imgSpeechVolumnAffect.hidden = NO;
//        if(!imgSpeechVolumnAffect.isAnimating) {
//            [imgSpeechVolumnAffect startAnimating];
//        }
//    }
//}
//
//- (void)stopSpeechAnimate {
//    if(imgSpeechVolumnAffect != nil) {
//        if(imgSpeechVolumnAffect.isAnimating) {
//            [imgSpeechVolumnAffect stopAnimating];
//        }
//        imgSpeechVolumnAffect.hidden = YES;
//    }
//}
//
//#pragma mark -
//#pragma mark speech control
//
//- (void)resetRecognizer {
//    [self stopSpeechAnimate];
//    recognizerState = RecognizerStateReady;
//}
//
//- (void)btnSpeechTouchUpInside:(id)sender {
//    if(speechViewState == SpeechViewStateClosed) {
//        [self showSpeechView];
//    } else if(speechViewState == SpeechViewStateOpenned) {
//        [speechRecognitionUtil stopListening];
//    }
//}
//
//- (void)btnSpeechTouchDown:(id)sender {
//    if(speechViewState == SpeechViewStateOpenned) {
//        if(recognizerState == RecognizerStateReady) {
//            recognizerState = RecognizerStateRecordBegin;
//            [self startListening:nil];
//        }
//    }
//}
//
//- (void)btnSpeechTouchUpOutside:(id)sender {
//    [speechRecognitionUtil cancel];
//}
//
//- (void)btnSpeechTouchDragExit:(id)sender {
//    //touch down and dragg out of button
//}
//
//- (void)btnSpeechTouchDragEnter:(id)sender {
//    //touch down and dragg enter button when previous status is out of button
//}
//
//- (void)startListening:(NSTimer *)timer {
//    if(speechRecognitionUtil == nil) {
//        speechRecognitionUtil = [[SpeechRecognitionUtil alloc] init];
//        speechRecognitionUtil.speechRecognitionNotificationDelegate = self;
//    }
//    if(![speechRecognitionUtil startListening]) {
//#ifdef DEBUG
//        NSLog(@"[SPEECH VIEW] Start lisenting failed.");
//#endif
//    }
//}
//
//#pragma mark -
//#pragma mark speech recognizer notification delegate
//
//- (void)beginRecord {
//    recognizerState = RecognizerStateRecording;
//    [self startSpeechAnimate];
//}
//
//- (void)endRecord {
//    recognizerState = RecognizerStateRecordingEnd;
//    [self stopSpeechAnimate];
//}
//
//- (void)recognizeCancelled {
//    [self speechRecognizerFailed:@"Cancelled by user."];
//}
//
//- (void)speakerVolumeChanged:(int)volume {
//    if(recognizerState == RecognizerStateRecording) {
////        int v = volume / 3;
////        if(v > 9) v = 9;
////        if(v < 0) v = 0;
////        [btnSpeech setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_speech_0%d.png", v]] forState:UIControlStateNormal];
//    }
//}
//
//- (void)recognizeSuccess:(NSString *)result {
//    [self resetRecognizer];
//    if(![NSString isBlank:result]) {
//        //process text message
//#ifdef DEBUG
//        NSLog(@"[SPEECH VIEW] Send voice command [%@].", result);
//#endif
//        DeviceCommandVoiceControl *command = (DeviceCommandVoiceControl *)[CommandFactory commandForType:CommandTypeUpdateDeviceViaVoice];
//        command.masterDeviceCode = [SMShared current].memory.currentUnit.identifier;
//        command.voiceText = result;
//        [[SMShared current].deliveryService executeDeviceCommand:command];
//    } else {
//        [self speechRecognizerFailed:@"no speaking"];
//    }
//}
//
//- (void)recognizeError:(int)errorCode {
//    [self resetRecognizer];
//    [self speechRecognizerFailed:[NSString stringWithFormat:@"error code is %d", errorCode]];
//}
//
//- (void)speechRecognizerFailed:(NSString *)message {
//#ifdef DEBUG
//    NSLog(@"[SPEECH RECOGNIZER] Recognize failed, reason is [ %@ ]", message);
//#endif
//}
//
//#pragma mark -
//#pragma mark text message processor delegate
//
//
//- (void)destory {
//    [self unSubscribeEvents];
//#ifdef DEBUG
//    NSLog(@"[Main View] Destroyed.");
//#endif
//}
//
//#pragma mark -
//#pragma mark getter and setters
//
//- (ConversationView *)speechView {
//    if(speechView == nil) {
//        CGFloat viewHeight = self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2 - 32;
//        speechView = [[ConversationView alloc] initWithFrame:CGRectMake(0, (0 - viewHeight - ([UIDevice systemVersionIsMoreThanOrEuqal7] ? 22 : 12)), 601/2, viewHeight) andContainer:self];
//        speechView.center = CGPointMake(self.center.x, speechView.center.y);
//    }
//    return speechView;
//}

@end
