//
//  JSLoginViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSLoginViewController.h"
#import "PNColor.h"
#import "JSRegisterViewController.h"
#import "JSUser.h"
@interface JSLoginViewController ()
{
    float posiY;
    UITextField *userNameTextField;
    UITextField *passwordTextField;
}
@end

@implementation JSLoginViewController

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
    NSArray *titles = @[@"用户名",@"密码"];
    for (int i=0; i<titles.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLab.frame.origin.y+90+50*i, 70, 20)];
        lab.textColor = PNGreen;
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.text = [titles objectAtIndex:i];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:lab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.titleLab.frame.origin.y+80+50*i, 200, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = [NSString stringWithFormat:@"点击输入%@",[titles objectAtIndex:i]];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textField addTarget:self action:@selector(textBeginEdit) forControlEvents:UIControlEventEditingDidBegin];
        [self.view addSubview:textField];
        if (i == 0 ) {
            userNameTextField = textField;
        }else{
            passwordTextField = textField;
            passwordTextField.secureTextEntry = YES;
        }
        
    }
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    loginButton.layer.cornerRadius =5;
//    loginButton.layer.borderWidth = 2;
//    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.layer.backgroundColor = PNGreen.CGColor;
    loginButton.center = CGPointMake(160, 250);
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(250, self.view.frame.size.height-50, 100, 40)];
    registerButton.layer.cornerRadius = 20;
//    registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    registerButton.layer.borderWidth =2;
    registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    [registerButton setTitle:@"注册 " forState:UIControlStateNormal];
    registerButton.layer.backgroundColor = PNBlue.CGColor;
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
	// Do any additional setup after loading the view.
}
-(void)loginButtonClick
{
    if (userNameTextField.text.length>0&&passwordTextField.text.length>0) {
        if ([JSUser loginWithName:userNameTextField.text andWithPassword:passwordTextField.text]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写完成基本信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
-(void)registerButtonClick
{
    JSRegisterViewController *registerVC = [[JSRegisterViewController alloc] init];
    registerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:registerVC animated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.titleLab.text = @"登录";
}
-(void)textBeginEdit
{
    if (self.view.frame.origin.y >=0) {
        posiY = self.view.frame.origin.y;
        CGRect frame = self.view.frame;
        frame.origin.y = -20;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.frame = frame;
            self.titleLab.alpha = 0;
        } completion:nil];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    if (self.view.frame.origin.y <0) {
        CGRect frame = self.view.frame;
        frame.origin.y = posiY;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.frame = frame;
            self.titleLab.alpha = 1;
        } completion:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
