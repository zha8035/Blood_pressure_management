//
//  JSAddFamilyViewController.m
//  血压监测
//
//  Created by demo on 13-11-19.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSAddFamilyViewController.h"
#import "PNColor.h"
#import "JSUser.h"
#import "JSPersonBloodData.h"
@interface JSAddFamilyViewController ()
{
    UIButton *headImageView;
    BOOL isEdit;
    float posiY;
    
    NSString *headImageName;
    
    UIActionSheet *headSelectSheet;
    BOOL isCanSave;
    
    UITextField *nameTextField;
    UITextField *sexTextField;
    UITextField *ageTextField;
    UITextField *hightTextField;
    UITextField *weightTextField;
    
    UIActionSheet *sexActionSheet;
}
@end

@implementation JSAddFamilyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.titleLab.text = @"添加成员";
    if (self.personData) {
        [headImageView setBackgroundImage:[UIImage imageNamed:self.personData.headUrl] forState:UIControlStateNormal];
        headImageName = self.personData.headUrl;
        nameTextField.text = self.personData.name;
        ageTextField.text = self.personData.age;
        sexTextField.text = self.personData.sex;
        weightTextField.text = self.personData.weight;
        hightTextField.text = self.personData.hight;
        
        isCanSave = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    headImageName = @"headImage0";
    
    UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    headBgView.center = CGPointMake(160, 130);
    headBgView.layer.cornerRadius = 60;
    headBgView.layer.masksToBounds = YES;
    headBgView.layer.borderWidth = 2;
    headBgView.layer.borderColor = PNGreen.CGColor;
    headBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headBgView];
    
    headImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [headImageView addTarget:self action:@selector(headButtonClick) forControlEvents:UIControlEventTouchUpInside];
    headImageView.center = headBgView.center;
    [headImageView setBackgroundImage:[UIImage imageNamed:@"headImage0"] forState:UIControlStateNormal];
    [self.view addSubview:headImageView];
    
    NSArray *titles = @[@"成员姓名",@"性别",@"年龄",@"身高",@"重量"];
    for (int  i=0; i<titles.count; i++) {
        
        UILabel *tiLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLab.frame.origin.y+205+50*i, 90, 20)];
        tiLab.text = [titles objectAtIndex:i];
        tiLab.textColor = PNGreen;
        tiLab.font = [UIFont boldSystemFontOfSize:20];
        tiLab.backgroundColor = [UIColor clearColor];
        tiLab.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:tiLab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, self.titleLab.frame.origin.y+190+50*i, 200, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = [NSString stringWithFormat:@"点击输入%@",[titles objectAtIndex:i]];
        textField.tag = i;
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
            [textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
        
        
        if (i>0) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        [self.view addSubview:textField];
        if (i == 0) {
            nameTextField = textField;
        }else if(i == 1){
            sexTextField = textField;
            sexTextField.enabled = NO;
            UIButton *sexButton = [[UIButton alloc] initWithFrame:sexTextField.frame];
            [sexButton addTarget:self action:@selector(sexButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sexButton];
        }else if(i == 2){
            ageTextField = textField;
        }else if(i == 3){
            hightTextField = textField;
        }else{
            weightTextField = textField;
        }
    }
    
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
    
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, 40, 40)];
    addButton.layer.cornerRadius = 20;
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderColor = [UIColor whiteColor].CGColor;
    addButton.layer.borderWidth = 2;
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
    [addButton setTitleColor:PNGreen forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:43.0];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}
//选取xingbie
-(void)sexButtonClick
{
    if (sexActionSheet == Nil) {
        sexActionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        imageView.image = [UIImage imageNamed:@"menubg"];
        [sexActionSheet addSubview:imageView];
        
        NSArray *titles = @[@"2",@"4"];
        for (int i=0; i<titles.count; i++) {
            
            UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            headBgView.center = CGPointMake(120+95*i, 50);
            headBgView.layer.cornerRadius = 40;
            headBgView.layer.masksToBounds = YES;
            headBgView.layer.borderWidth = 2;
            headBgView.layer.borderColor = PNGreen.CGColor;
            headBgView.backgroundColor = [UIColor whiteColor];
            [sexActionSheet addSubview:headBgView];
            
            UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [headView addTarget:self action:@selector(selectSexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            headView.tag = i;
            headView.center = headBgView.center;
            [headView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"headImage%@",[titles objectAtIndex:i]]] forState:UIControlStateNormal];
            [sexActionSheet addSubview:headView];
        }
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 30, 100)];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.backgroundColor = PNGreen;
        [sexActionSheet addSubview:cancelButton];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:cancelButton.bounds];
        lab.text = @"取\n消";
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor clearColor];
        [cancelButton addSubview:lab];
    }
    [self touchesBegan:Nil withEvent:nil];
    [sexActionSheet showInView:self.view];
}
//性别
-(void)selectSexButtonClick:(UIButton *)button
{
    NSArray *sexs = @[@"男",@"女"];
    sexTextField.text = [sexs objectAtIndex:button.tag];
    [sexActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addButtonClick
{
    if (isCanSave) {
        NSArray *array = @[headImageName,nameTextField.text,sexTextField.text,ageTextField.text,hightTextField.text,weightTextField.text,[[NSArray alloc] init]];
        [JSUser addFamilyNumber:array];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写完成基本信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
- (void)headButtonClick
{
    if (headSelectSheet == Nil) {
        headSelectSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        imageView.image = [UIImage imageNamed:@"menubg"];
        [headSelectSheet addSubview:imageView];
        UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, 280, 300)];
        myScrollView.pagingEnabled = YES;
        [headSelectSheet addSubview:myScrollView];
        for (int i=0; i<7; i++) {
            
            UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            headBgView.center = CGPointMake(50+95*i, 50);
            headBgView.layer.cornerRadius = 40;
            headBgView.layer.masksToBounds = YES;
            headBgView.layer.borderWidth = 2;
            headBgView.layer.borderColor = PNGreen.CGColor;
            headBgView.backgroundColor = [UIColor whiteColor];
            [myScrollView addSubview:headBgView];
            
            UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [headView addTarget:self action:@selector(selectHeadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            headView.tag = i;
            headView.center = headBgView.center;
            [headView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"headImage%d",i]] forState:UIControlStateNormal];
            [myScrollView addSubview:headView];
        }
        [myScrollView setContentSize:CGSizeMake(50+95*7, 300)];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 30, 100)];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.backgroundColor = PNGreen;
        [headSelectSheet addSubview:cancelButton];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:cancelButton.bounds];
        lab.text = @"取\n消";
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor clearColor];
        [cancelButton addSubview:lab];
    }
    [self touchesBegan:nil withEvent:nil];
    [headSelectSheet showInView:self.view];
}
-(void)cancelButtonClick
{
    [headSelectSheet dismissWithClickedButtonIndex:0 animated:YES];
    [sexActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)selectHeadButtonClick:(UIButton *)button
{
    headImageName = [NSString stringWithFormat:@"headImage%ld",(long)button.tag];
    [headImageView setBackgroundImage:[UIImage imageNamed:headImageName] forState:UIControlStateNormal];
    [headSelectSheet dismissWithClickedButtonIndex:0 animated:YES];
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
    if (textField.tag == 4) {
        frame.origin.y = -47*(textField.tag);
    }else{
        frame.origin.y = -47*(textField.tag+1);
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
