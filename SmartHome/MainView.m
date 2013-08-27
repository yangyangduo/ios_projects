//
//  MainView.m
//  SmartHome
//
//  Created by Zhao yang on 8/5/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "MainView.h"
#import "NSString+StringUtils.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NotificationViewController.h"
#import "AirConditionViewController.h"
#import "CameraAdjustViewController.h"

#import "SwitchButton.h"
#import "ScrollNavButton.h"
#define SPEECH_VIEW_TAG                  46001
#define SPEECH_BUTTON_WIDTH              174
#define SPEECH_BUTTON_HEIGHT             186
#define DELAY_START_LISTENING_DURATION   0.6f
#define RECORD_BEGIN_SOUND_ID            1113
#define RECORD_END_SOUND_ID              1114

@implementation MainView {
    SpeechViewState speechViewState;
    RecognizerState recognizerState;
    ConversationView *speechView;
    SpeechRecognitionUtil *speechRecognitionUtil;
    PageableScrollView *pageableScrollView;
    PageableNavView *pageableNavView;
    NSArray *navItems;
    
    UIButton *btnSpeech;
    UIButton *btnShowNotification;
    UIButton *btnShowAffectDevice;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initDefaults {
    [super initDefaults];
    speechViewState = SpeechViewStateClosed;
    recognizerState = RecognizerStateReady;
    speechRecognitionUtil = [[SpeechRecognitionUtil alloc] init];
    speechRecognitionUtil.speechRecognitionNotificationDelegate = self;
}

- (void)initUI {
    [super initUI];
    
    if(btnShowNotification == nil) {
        btnShowNotification = [[UIButton alloc] initWithFrame:CGRectMake(200, 80, 120, 30)];
        [btnShowNotification setTitle:@"通知" forState:UIControlStateNormal];
        [btnShowNotification addTarget:self action:@selector(btnShowNotificationDevicePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnShowNotification];
    }
    
    if(btnSpeech == nil) {
        btnSpeech = [[UIButton alloc] initWithFrame:CGRectMake(((self.frame.size.width - SPEECH_BUTTON_WIDTH/2) / 2), (self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2), (SPEECH_BUTTON_WIDTH / 2), (SPEECH_BUTTON_HEIGHT / 2))];
        [btnSpeech setBackgroundImage:[UIImage imageNamed:@"btn_speech.png"] forState:UIControlStateNormal];
        [btnSpeech setBackgroundImage:[UIImage imageNamed:@"btn_speech.png"] forState:UIControlStateHighlighted];
        [btnSpeech addTarget:self action:@selector(btnSpeechPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSpeech];
    }
    
    if (pageableScrollView ==nil) {
        pageableScrollView = [[PageableScrollView alloc] initWithFrame:CGRectMake(5, 100, 240, 200)];
        pageableScrollView.backgroundColor = [UIColor whiteColor];
        pageableScrollView.delegate = self;
        [self addSubview:pageableScrollView];
    }
    
    if (pageableNavView == nil) {
        UIButton *btn1 = [ScrollNavButton buttonWithNothing];
        [btn1 setTitle:@"客厅" forState:UIControlStateNormal];
        btn1.selected = YES;
        UIButton *btn2 = [ScrollNavButton buttonWithNothing];
        [btn2 setTitle:@"主卧" forState:UIControlStateNormal];
        UIButton *btn3 = [ScrollNavButton buttonWithNothing];
        [btn3 setTitle:@"次卧" forState:UIControlStateNormal];
        UIButton *btn4 = [ScrollNavButton buttonWithNothing];
        [btn4 setTitle:@"厨房" forState:UIControlStateNormal];
        UIButton *btn5 = [ScrollNavButton buttonWithNothing];
        [btn5 setTitle:@"浴室" forState:UIControlStateNormal];
        
        navItems = [[NSArray alloc]initWithObjects:btn1,btn2,btn3,btn4,btn5, nil];
        [navItems enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
            [obj addTarget:self action:@selector(scrollNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }];
        pageableNavView = [[PageableNavView alloc] initWithFrame:CGRectMake(250, 100, 101/2, 200) andNavItemsForVertical:navItems];
        [self addSubview:pageableNavView];
        

        
    }
    
    SwitchButton *sb = [SwitchButton buttonWithPoint:CGPointMake(100, 100)];
    [sb registerImage:[UIImage imageNamed:@"icon_device_off.png"] forStatus:@"off"];
    [sb registerImage:[UIImage imageNamed:@"icon_device_on.png"] forStatus:@"on"];
    sb.status = @"on";
    [self addSubview:sb];
    
    
}
-(void) scrollNavButtonAction:(UIButton *)sender{
    __block NSInteger curNav;
    [navItems enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
        if ([obj isEqual:sender]) {
            curNav = idx;
        }
    }];
    sender.selected = YES;
    pageableScrollView.pageableScrollView.contentOffset = CGPointMake(curNav*pageableScrollView.pageableScrollView.frame.size.width*curNav, pageableScrollView.pageableScrollView.contentOffset.y);
    
    
}
-(void) accessoryBehavior{
    CGFloat itemWidth = pageableScrollView.pageableScrollView.frame.size.width;
    CGFloat xOffset = pageableScrollView.pageableScrollView.contentOffset.x;
    CGPoint navOffset = pageableNavView.pageableNavView.contentOffset;
    CGFloat navHeight = 59/2+10;
    
    NSInteger curPage = xOffset/itemWidth;
    [self scrollNavButtonAction:[navItems objectAtIndex:curPage]];
    CGFloat curNavYOffset = navHeight*curPage;
    if (navOffset.y+pageableNavView.pageableNavView.frame.size.height<curNavYOffset) {
        pageableNavView.pageableNavView.contentOffset = CGPointMake(navOffset.x, navOffset.y+navHeight);
    }
    if(navOffset.y>curNavYOffset){
        pageableNavView.pageableNavView.contentOffset = CGPointMake(navOffset.x, navOffset.y-navHeight);
    }
}
-(void) panAndTouchAccessoryBehavior{
    
}
#pragma mark -
#pragma mark notification && affect button

- (void)btnShowNotificationDevicePressed:(id)sender {
    NotificationViewController *notificationViewController = [[NotificationViewController alloc] init];
    [self.ownerController.navigationController pushViewController:notificationViewController animated:YES];
}

#pragma mark -
#pragma mark speech view

- (void)showSpeechView {
    if(speechViewState != SpeechViewStateClosed) return;
    ConversationView *view = (ConversationView *)[self viewWithTag:SPEECH_VIEW_TAG];
    if(view == nil) {
        view = [self speechView];
        [self addSubview:view];
    }
    speechViewState = SpeechViewStateOpenning;
    [self.ownerController disableGestureForDrawerView];
    [UIView animateWithDuration:0.3f
                animations:^{
                    view.frame = CGRectMake(view.frame.origin.x, 12, view.frame.size.width, view.frame.size.height);
                }
                completion:^(BOOL finished) {
                    speechViewState = SpeechViewStateOpenned;
                    if(speechView.messageCount == 0) [speechView showWelcomeMessage];
                    [self btnSpeechRecordingPressed:nil];
                }];
}

- (void)hideSpeechView {
    if(speechViewState != SpeechViewStateOpenned) return;
    CGFloat viewHeight = self.frame.size.height - SPEECH_BUTTON_HEIGHT / 2 - 12;
    ConversationView *view = [self speechView];
    speechViewState = SpeechViewStateClosing;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         view.frame = CGRectMake(view.frame.origin.x, (0 - viewHeight - 12), view.frame.size.width, view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [[self speechView] hideWelcomeMessage];
                         [[self speechView] removeFromSuperview];
                         [self.ownerController enableGestureForDrawerView];
                         speechViewState = SpeechViewStateClosed;
                     }];
}

#pragma mark -
#pragma mark speech control

- (void)btnSpeechPressed:(id)sender {
    if(speechViewState == SpeechViewStateClosed) {
        [self showSpeechView];
    } else if(speechViewState ==  SpeechViewStateOpenned) {
        [self btnSpeechRecordingPressed:sender];
    }
}

- (void)btnSpeechRecordingPressed:(id)sender {    
    if(recognizerState == RecognizerStateReady) {
        recognizerState = RecognizerStateRecordBegin;
        AudioServicesPlaySystemSound(RECORD_BEGIN_SOUND_ID);
        [self delayStartListening];
    } else if(recognizerState == RecognizerStateRecording) {
        [speechRecognitionUtil stopListening];
    }
}

- (void)delayStartListening {
    [NSTimer scheduledTimerWithTimeInterval:DELAY_START_LISTENING_DURATION target:self selector:@selector(startListening:) userInfo:nil repeats:NO];
}

- (void)startListening:(NSTimer *)timer {
    [speechRecognitionUtil startListening];
}

#pragma mark -
#pragma mark speech recognizer notification delegate

- (void)beginRecord {
    recognizerState = RecognizerStateRecording;
}

- (void)endRecord {
    AudioServicesPlaySystemSound(RECORD_END_SOUND_ID);
    recognizerState = RecognizerStateRecordingEnd;
}

- (void)recognizeCancelled {
}

- (void)speakerVolumeChanged:(int)volume {
}

- (void)recognizeSuccess:(NSString *)result {
    if(![NSString isBlank:result]) {
        ConversationTextMessage *textMessage = [[ConversationTextMessage alloc] init];
        textMessage.messageOwner = MESSAGE_OWNER_MINE;
        textMessage.textMessage = result;
        [speechView addMessage:textMessage];
        //process text message
    } else {
        [self speechRecognizerFailed:@"empty speaking..."];
        //
    }
    recognizerState = RecognizerStateReady;
}

- (void)recognizeError:(int)errorCode {
    [self speechRecognizerFailed:[NSString stringWithFormat:@"error code is %d", errorCode]];
    recognizerState = RecognizerStateReady;
}

- (void)speechRecognizerFailed:(NSString *)message {
    NSLog(@"need alert fail the error message is : [   %@  ]", message);
}

#pragma mark -
#pragma mark text message processor delegate



#pragma mark -
#pragma mark getter and setters

- (ConversationView *)speechView {
    if(speechView == nil) {
        CGFloat viewHeight = self.frame.size.height - SPEECH_BUTTON_HEIGHT/2 - 10 - 10;
        speechView = [[ConversationView alloc] initWithFrame:CGRectMake(0, (0 - viewHeight - 12), 601/2, viewHeight) andContainerView:self];
        speechView.center = CGPointMake(self.center.x, speechView.center.y);
        speechView.tag = SPEECH_VIEW_TAG;
    }
    return speechView;
}


@end
