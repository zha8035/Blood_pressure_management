//
//  JSAddDataViewController.m
//  血压监测
//
//  Created by demo on 13-11-19.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSAddDataViewController.h"
#import "PNColor.h"
#import "JSUser.h"
#import "JSAddFamilyViewController.h"
#import "JSFamilyNumberCell.h"
@interface JSAddDataViewController ()
{
    UITableView *dataTableView;
    NSMutableArray *familyNumbersArray;
    
    UITapGestureRecognizer *selfViewTap;
    
    float posiY;
    BOOL isEdit;
    BOOL isCanSave;
    UIView *bgView;
    
    UIView *resultView;
    UILabel *resultHighLab;
    UILabel *resultLowLab;
    UILabel *resultBloodLab;
    UILabel *resultLab;
}
@end

@implementation JSAddDataViewController

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
	
    NSArray *titles = @[@"收缩压",@"舒张压",@"脉搏",@"时间"];
    
    for (int i=0; i<titles.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 90+50*i, 70,50)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor = PNGreen;
        lab.text = [titles objectAtIndex:i];
        [self.view addSubview:lab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 90+50*i, 200, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.placeholder = [NSString stringWithFormat:@"点击输入%@",[titles objectAtIndex:i]];
        [textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingDidBegin];
        if (i == 3) {
            NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
            NSDate *curDate = [NSDate date];//获取当前日期
            [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//这里去掉 具体时间 保留日期
            textField.text = [formater stringFromDate:curDate];
            textField.enabled = NO;
        }
        textField.tag = 100+i;
        [self.view addSubview:textField];
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
    
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(20,self.view.frame.size.height- 60, 40, 40)];
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
    
    
    bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    bgView.alpha = 0;
    [self.view addSubview:bgView];
    
    familyNumbersArray = [JSUser familyNumbersArray];
    //添加列表
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,300)];
    dataTableView.layer.contents = (id)[UIImage imageNamed:@"viewbg"].CGImage;
    dataTableView.layer.borderColor = PNGreen.CGColor;
    dataTableView.layer.borderWidth =3;
    dataTableView.layer.cornerRadius =10;
    dataTableView.alpha = 0;
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    dataTableView.center = self.view.center;
    [self.view addSubview:dataTableView];
    
    resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    resultView.center = self.view.center;
    resultView.layer.contents = (id)[UIImage imageNamed:@"viewbg"].CGImage;
    resultView.layer.borderColor = PNGreen.CGColor;
    resultView.layer.borderWidth =3;
    resultView.layer.cornerRadius =10;
    resultView.alpha = 0;
    resultView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:resultView];
    
    UIImageView *colorBarImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 300, 30)];
    colorBarImageview.image = [UIImage imageNamed:@"colorbar"];
    [resultView addSubview:colorBarImageview];
    
    //添加结果说明
    resultLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    resultLab.layer.cornerRadius = 5;
    resultLab.layer.borderColor = [UIColor whiteColor].CGColor;
    resultLab.layer.borderWidth = 2;
    resultLab.backgroundColor = PNGreen;
    resultLab.font = [UIFont boldSystemFontOfSize:20];
    resultLab.text = @"正常";
    resultLab.textColor = [UIColor whiteColor];
    resultLab.textAlignment = NSTextAlignmentCenter;
    resultLab.center = CGPointMake(150, 90);
    [resultView addSubview:resultLab];
    
    //添加高压
    resultHighLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 70, 30)];
    resultHighLab.text = @"120";
    resultHighLab.backgroundColor = [UIColor clearColor];
    resultHighLab.font = [UIFont boldSystemFontOfSize:30];
    resultHighLab.textAlignment = NSTextAlignmentRight;
    resultHighLab.textColor = [UIColor whiteColor];
    [resultView addSubview:resultHighLab];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(85, 130, 100, 30)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = @"收缩压 \nmmHg";
    lab.numberOfLines = 0;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:12];
    lab.backgroundColor = [UIColor clearColor];
    [resultView addSubview:lab];
    //添加高压
    resultLowLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 70, 30)];
    resultLowLab.text = @"80";
    resultLowLab.backgroundColor = [UIColor clearColor];
    resultLowLab.font = [UIFont boldSystemFontOfSize:30];
    resultLowLab.textAlignment = NSTextAlignmentRight;
    resultLowLab.textColor = [UIColor whiteColor];
    [resultView addSubview:resultLowLab];
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 130, 100, 30)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = @"舒张压 \nmmHg";
    lab.numberOfLines = 0;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:12];
    lab.backgroundColor = [UIColor clearColor];
    [resultView addSubview:lab];
    
    //添加分割线
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.backgroundColor = [UIColor grayColor].CGColor;
    lineLayer.frame = CGRectMake(20, 160, 260, 2);
    [resultView.layer addSublayer:lineLayer];
    
    //添加心率
    resultBloodLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 165, 300, 30)];
    resultBloodLab.text = @"80";
    resultBloodLab.backgroundColor = [UIColor clearColor];
    resultBloodLab.font = [UIFont boldSystemFontOfSize:30];
    resultBloodLab.textAlignment = NSTextAlignmentCenter;
    resultBloodLab.textColor = [UIColor whiteColor];
    [resultView addSubview:resultBloodLab];
    
    lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 165, 100, 30)];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = @"心率 \nBMP";
    lab.numberOfLines = 0;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:12];
    lab.backgroundColor = [UIColor clearColor];
    [resultView addSubview:lab];
    
    //添加确定按钮
    
    //添加手势
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheView)]];
    
    selfViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheSelfView)];
    [self.view addGestureRecognizer:selfViewTap];
}
-(void)tapTheSelfView
{
    if (isEdit) {
        [self.view removeGestureRecognizer:selfViewTap];
        bgView.alpha = 0;
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
}
-(void)tapTheView
{
    dataTableView.alpha = 0;
    resultView.alpha = 0;
    bgView.alpha = 0;
}
-(void)addButtonClick
{
    if (!isCanSave) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先填写完成基本信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    CGRect frame = dataTableView.frame;
    frame.origin.x = 320;
    dataTableView.frame = frame;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        dataTableView.alpha = 1;
        dataTableView.center = self.view.center;
        bgView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//编辑开始
-(void)textFieldBeginEdit:(UITextField *)textField
{
    if (!isEdit) {
        isEdit = YES;
        posiY = self.view.frame.origin.y;
    }
    [self.view addGestureRecognizer:selfViewTap];
    CGRect frame = self.view.frame;
    frame.origin.y = -40*(textField.tag-100+1);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.titleLab.text = @"添加数据";
    familyNumbersArray = [JSUser familyNumbersArray];
    [dataTableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return familyNumbersArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell = @"Cell";
    JSFamilyNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == Nil) {
        cell = [[JSFamilyNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    JSPersonBloodData *data = [JSPersonBloodData initWithData:[familyNumbersArray objectAtIndex:indexPath.row]];
    [cell upCellDataWith:data];
    return cell;
}
-(void)reloadFamilyData
{
    [self viewDidAppear:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *view = [[UIButton alloc] init];
    [view setBackgroundImage:[UIImage imageNamed:@"menubg"] forState:UIControlStateNormal];
    [view addTarget:self action:@selector(addFamilyNumberClick) forControlEvents:UIControlEventTouchUpInside];
    [view setTitle:@"添加新成员" forState:UIControlStateNormal];
    
    return view;
}
-(void)addFamilyNumberClick
{
    JSAddFamilyViewController *addFamilyVC = [[JSAddFamilyViewController alloc] init];
    [self presentViewController:addFamilyVC animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSPersonBloodData *data = [JSPersonBloodData initWithData:[familyNumbersArray objectAtIndex:indexPath.row]];
    
    CGRect tableFrame = dataTableView.frame;
    tableFrame.origin.x = -320;
    CGRect resultFrame = resultView.frame;
    resultFrame.origin.x = 320;
    resultView.frame = resultFrame;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        resultView.center = self.view.center;
        dataTableView.frame = tableFrame;
        dataTableView.alpha = 0;
        resultView.alpha = 1;
    } completion:^(BOOL finished) {
        [dataTableView deselectRowAtIndexPath:indexPath animated:NO];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
