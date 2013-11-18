//
//  JSMainViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSMainViewController.h"
#import "JSBloodDataCell.h"

#define tableviewSectionTitleHeight 50

@interface JSMainViewController ()
{
    UITableView *dataTableView;
}
@end

@implementation JSMainViewController

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
    
    
    
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.titleLab.frame.origin.y+65, self.view.frame.size.width, self.view.frame.size.height-(self.titleLab.frame.origin.y+65))];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    [self.view addSubview:dataTableView];
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.layer.contents = (id)[UIImage imageNamed:@"menubg"].CGImage;
    
    CALayer *lay = [[CALayer alloc] init];
    lay.backgroundColor = [UIColor whiteColor].CGColor;
    lay.frame = CGRectMake(0, 0, 320, 1);
    [view.layer addSublayer:lay];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    headImageView.layer.cornerRadius = 20;
    headImageView.backgroundColor = [UIColor grayColor];
    [view addSubview:headImageView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0,100, tableviewSectionTitleHeight)];
    nameLab.text = @"妹妹";
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont boldSystemFontOfSize:25];
    [view addSubview:nameLab];
    
//    UIImageView *sepImageView=[[UIImageView alloc] initWithFrame:CGRectMake(100, tableviewSectionTitleHeight-2, 220, 2)];
//    sepImageView.image = [UIImage imageNamed:@"line_bg"];
//    sepImageView.contentMode = UIViewContentModeLeft;
//    [view addSubview:sepImageView];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableviewSectionTitleHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell=@"Cell";
    JSBloodDataCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[JSBloodDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    return cell;
}
-(void)viewDidAppear:(BOOL)animated
{
    self.titleLab.text = @"首页";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
