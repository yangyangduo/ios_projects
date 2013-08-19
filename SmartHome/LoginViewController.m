//
//  LoginViewController.m
//  SmartHome
//
//  Created by hadoop user account on 16/08/13.
//  Copyright (c) 2013 hentre. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTextFieldView.h"
#import "LongButton.h"
#define LINE_HIGHT 5
@interface LoginViewController ()

@end

@implementation LoginViewController{
    UILabel *username;
    UILabel *password;
    UILabel *rememberPassword;
    
    UITextField *usernameField;
    UITextField *passwordField;
    
    UIButton *rememberBtn;
    UIButton *loginBtn;
    UIButton *registerBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) initUI{
    [super initUI];
    //CGFloat screenHight = self.view.bounds.size.height;
    //CGFloat screenWidth = self.view.bounds.size.width;
    [self registerTapGestureToResignKeyboard];
    
    username = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 20)];
    username.backgroundColor = [UIColor clearColor];
    username.text = NSLocalizedString(@"username:", @"");
    username.font= [UIFont systemFontOfSize:12];
    username.textColor = [UIColor whiteColor];
    [self.view addSubview:username];
    
    usernameField = [CustomTextFieldView textFieldWithPoint:CGPointMake(5, username.frame.origin.y+LINE_HIGHT+20)];
    [self.view addSubview:usernameField];
    

    
    password = [[UILabel alloc] initWithFrame:CGRectMake(10, usernameField.frame.origin.y+usernameField.bounds.size.height+LINE_HIGHT, 100, 20)];
    password.text = NSLocalizedString(@"password:", @"");
    password.textColor = [UIColor whiteColor];
    password.backgroundColor = [UIColor clearColor];
    password.font= [UIFont systemFontOfSize:12];
    [self.view addSubview:password];
    


    passwordField = [CustomTextFieldView textFieldWithPoint:CGPointMake(5, password.frame.origin.y+LINE_HIGHT+20)];
    [passwordField setSecureTextEntry:YES];
    [self.view addSubview:passwordField];
    
    loginBtn = [LongButton buttonWithPoint:CGPointMake(5, passwordField.frame.origin.y+passwordField.bounds.size.height+LINE_HIGHT)];
    [loginBtn setTitle:NSLocalizedString(@"login", @"") forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    rememberBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, loginBtn.frame.origin.y+loginBtn.bounds.size.height+LINE_HIGHT, 38/2, 40/2)];
    [rememberBtn setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [rememberBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [rememberBtn addTarget:self action:@selector(rememberBtnTouchInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rememberBtn];
    
    rememberPassword = [[UILabel alloc]  initWithFrame:CGRectMake(5+rememberBtn.frame.size.width+LINE_HIGHT, rememberBtn.frame.origin.y, 100, 20)];
    rememberPassword.font = [UIFont systemFontOfSize:12];
    rememberPassword.backgroundColor = [UIColor clearColor];
    rememberPassword.text = NSLocalizedString(@"remember.password", @"");
    rememberPassword.textColor = [UIColor whiteColor];
    [self.view addSubview:rememberPassword];
    
    
}
-(void) rememberBtnTouchInside{
    rememberBtn.selected = !rememberBtn.selected;
}
@end
