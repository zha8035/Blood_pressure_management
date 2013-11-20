//
//  JSRegisterViewController.m
//  血压监测
//
//  Created by demo on 13-11-20.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSRegisterViewController.h"
#import "PNColor.h"
@interface JSRegisterViewController ()
{
    BOOL isEdit;
    BOOL isCanSave;
    float posiY;
    
    UITextField *emailTextField;
    UITextField *nameTextField;
    UITextField *passwordTextField;
    UITextField *rePasswordTextField;
}
@end

@implementation JSRegisterViewController

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
	UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10,20, 60, 35)];
    backButton.layer.cornerRadius = 5;
    backButton.layer.masksToBounds = YES;
    backButton.layer.borderColor = [UIColor whiteColor].CGColor;
    backButton.layer.borderWidth = 2;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
    [backButton setTitleColor:PNGreen forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20.0];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(20,self.view.frame.size.height- 60, 200, 40)];
    addButton.layer.cornerRadius = 5;
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderColor = [UIColor whiteColor].CGColor;
    addButton.layer.borderWidth = 2;
    [addButton setTitle:@"注册" forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
    [addButton setTitleColor:PNGreen forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20.0];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.center = CGPointMake(160, 330);
    [self.view addSubview:addButton];
    
    
    NSArray *titles = @[@"邮箱",@"用户名",@"密码",@"确认密码"];
    for (int i =0; i<titles.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLab.frame.origin.y+90+50*i, 90, 20)];
        lab.textColor = PNGreen;
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.text = [titles objectAtIndex:i];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:lab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.titleLab.frame.origin.y+80+50*i, 200, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = [NSString stringWithFormat:@"点击输入%@",[titles objectAtIndex:i]];
        textField.tag = i+100;
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
        [self.view addSubview:textField];
        if (i == 0) {
            emailTextField = textField;
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }else if(i > 1){
            textField.secureTextEntry = YES;
        }
        if (i == 1) {
            nameTextField = textField;
        }else if (i == 2){
            passwordTextField = textField;
        }else{
            rePasswordTextField = textField;
        }
    }
}
//触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isEdit) {
        return;
    }
    isCanSave = YES;
    for (UIView *v in self.view.subviews) {
        if ([v.class isSubclassOfClass:[UITextField class]]) {
            [v resignFirstResponder];
            if (((UITextField *)v).text.length == 0) {
                isCanSave = NO;
            }
        }
    }
    isEdit = NO;
    CGRect frame = self.view.frame;
    frame.origin.y = posiY;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
        
    }];
}
//编辑开始
-(void)textFieldBeginEdit:(UITextField *)textField
{
    if (!isEdit) {
        isEdit = YES;
        posiY = self.view.frame.origin.y;
    }
    CGRect frame = self.view.frame;
    frame.origin.y = -20*(textField.tag-100+1);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addButtonClick
{
    if (!isCanSave) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写完成基本信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.titleLab.text = @"注册";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
