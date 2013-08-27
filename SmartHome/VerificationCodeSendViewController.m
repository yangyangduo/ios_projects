//
//  VerificationCodeSendViewController.m
//  SmartHome
//
//  Created by Zhao yang on 8/5/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "VerificationCodeSendViewController.h"
#import "VerificationCodeValidationViewController.h"
#import "SMTextField.h"
#import "LongButton.h"
#import "JsonUtils.h"
#import "NSDictionary+NSNullUtility.h"


@interface VerificationCodeSendViewController ()

@end

@implementation VerificationCodeSendViewController{
    UITextField *txtPhoneNumber;
    UILabel *lblPhoneNumber;
    UIButton *btnVerificationCodeSender;
    VerificationCodeValidationViewController *verificationCodeValidationViewController;
    
    UITextField *verification;

    NSTimeInterval resendTimeInterval;
    NSString *accountPhone;
    @private NSString *verificationCode;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    [super initUI];
    
    self.topbar.titleLabel.text = NSLocalizedString(@"verification_code_send.title", @"");
    
    if(lblPhoneNumber == nil) {
        lblPhoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 250, 20)];
        [lblPhoneNumber setText:NSLocalizedString(@"phone_number_register", @"")];
        lblPhoneNumber.font = [UIFont systemFontOfSize:16];
        lblPhoneNumber.backgroundColor = [UIColor clearColor];
        lblPhoneNumber.textColor = [UIColor lightTextColor];
        [self.view addSubview:lblPhoneNumber];
    }
    
    if(txtPhoneNumber == nil) {
        txtPhoneNumber = [SMTextField textFieldWithPoint:CGPointMake(6, lblPhoneNumber.frame.origin.y + 30)];
        txtPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        txtPhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        txtPhoneNumber.delegate = self;
        [self.view addSubview:txtPhoneNumber];
    }
    
    if(btnVerificationCodeSender == nil) {
        btnVerificationCodeSender = [LongButton buttonWithPoint:CGPointMake(5, txtPhoneNumber.frame.origin.y +txtPhoneNumber.frame.size.height + 5)];
        [btnVerificationCodeSender setTitle:NSLocalizedString(@"next_step", @"") forState:UIControlStateNormal];
        [btnVerificationCodeSender addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnVerificationCodeSender];
    }
    
    [txtPhoneNumber becomeFirstResponder];
}

#pragma mark -
#pragma mark service

- (void)sendVerificationCode {
    if([NSString isBlank:txtPhoneNumber.text] || [NSString trim:txtPhoneNumber.text].length != 11) {
        [[AlertView currentAlertView] setMessage:NSLocalizedString(@"phone_format_invalid", @"") forType:AlertViewTypeFailed];
        [[AlertView currentAlertView] alertAutoDisappear:YES lockView:self.view];
        return;
    }
    
    [[AlertView currentAlertView] setMessage:NSLocalizedString(@"please_wait", @"") forType:AlertViewTypeWaitting];
    [[AlertView currentAlertView] alertAutoDisappear:NO lockView:self.view];
    [self.accountService sendVerificationCodeFor:txtPhoneNumber.text success:@selector(verificationCodeSendSuccess:) failed:@selector(verificationCodeSendError:) target:self callback:nil];
}

- (void)verificationCodeSendSuccess:(RestResponse *)resp {
    if(resp.statusCode == 200) {
        NSDictionary *json = [JsonUtils createDictionaryFromJson:resp.body];
        if(json != nil) {
            NSString *_id_ = [json notNSNullObjectForKey:@"id"];
            if(_id_ != nil) {
                if([@"1" isEqualToString:_id_] || [@"-3" isEqualToString:_id_] || [@"-4" isEqualToString:_id_]) {
                    [[AlertView currentAlertView] setMessage:NSLocalizedString(@"send_success", @"") forType:AlertViewTypeSuccess];
                    [[AlertView currentAlertView] delayDismissAlertView];
                    VerificationCodeValidationViewController *nextViewController = [self nextViewController];
                    nextViewController.phoneNumberToValidation = txtPhoneNumber.text;
                    if([@"1" isEqualToString:_id_]) {
                        nextViewController.countDown = 60;
                    } else {
                        NSLog(@" not 60");
                        nextViewController.countDown = 60;
                    }
                    [self.navigationController pushViewController:nextViewController animated:YES];
                    return;
                } else if([@"-1" isEqualToString:_id_]) {
                    [[AlertView currentAlertView] setMessage:NSLocalizedString(@"phone_format_invalid", @"") forType:AlertViewTypeSuccess];
                    [[AlertView currentAlertView] delayDismissAlertView];
                    return;
                } else if([@"-2" isEqualToString:_id_]) {
                    [[AlertView currentAlertView] setMessage:NSLocalizedString(@"phone_has_been_register", @"") forType:AlertViewTypeSuccess];
                    [[AlertView currentAlertView] delayDismissAlertView];
                    return;
                }
            }
        }
    }
    [self verificationCodeSendError:resp];
}

- (VerificationCodeValidationViewController *)nextViewController {
    return [[VerificationCodeValidationViewController alloc] init];
}

- (void)verificationCodeSendError:(RestResponse *)resp {
    if(resp.statusCode == 1001) {
        [[AlertView currentAlertView] setMessage:NSLocalizedString(@"request_timeout", @"") forType:AlertViewTypeSuccess];
    } else {
        [[AlertView currentAlertView] setMessage:NSLocalizedString(@"unknow_error", @"") forType:AlertViewTypeSuccess];
    }
    [[AlertView currentAlertView] delayDismissAlertView];
}

#pragma mark -
#pragma mark text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return range.location < 11;
}

@end