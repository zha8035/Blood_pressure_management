//
//  JSMainViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSMainViewController.h"
#import "JSBloodDataCell.h"
#import "PNColor.h"
#import "JSUser.h"
#import "JSPersonBloodData.h"
#import "JSAddDataViewController.h"
#import "JSAddFamilyViewController.h"
#define tableviewSectionTitleHeight 50

@interface JSMainViewController ()
{
    UITableView *dataTableView;
    NSMutableArray *familyNumbersArray;
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
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(270, self.view.frame.size.height-60, 40, 40)];
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
-(void)addButtonClick
{
    JSAddDataViewController *addVc = [[JSAddDataViewController alloc] init];
    [addVc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:addVc animated:YES completion:nil];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JSPersonBloodData *personData = [JSPersonBloodData initWithData:[familyNumbersArray objectAtIndex:section]];
    
    UIView *view = [[UIView alloc] init];
    view.layer.contents = (id)[UIImage imageNamed:@"menubg"].CGImage;
    
    CALayer *lay = [[CALayer alloc] init];
    lay.backgroundColor = [UIColor whiteColor].CGColor;
    lay.frame = CGRectMake(0, 0, 320, 1);
    [view.layer addSublayer:lay];
    
    UIView *headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    headBgView.center = CGPointMake(30, 25);
    headBgView.layer.cornerRadius = 20;
    headBgView.layer.masksToBounds = YES;
    headBgView.layer.borderWidth = 2;
    headBgView.layer.borderColor = PNGreen.CGColor;
    headBgView.backgroundColor = [UIColor whiteColor];
    [view addSubview:headBgView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    headImageView.center = headBgView.center;
    headImageView.image = [UIImage imageNamed:personData.headUrl];
    [view addSubview:headImageView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0,100, tableviewSectionTitleHeight)];
    nameLab.text = personData.name;
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
    return familyNumbersArray.count;
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
    
    JSBloodDataCell *cell = [[JSBloodDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentify"];
//    if (cell == nil) {
//        cell = [[JSBloodDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
//    }
    JSPersonBloodData *data = [JSPersonBloodData initWithData:[familyNumbersArray objectAtIndex:indexPath.section]];
    [cell upCellDataWithPersonData:data];
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.titleLab.text = @"首页";
    familyNumbersArray = [JSUser familyNumbersArray];
    
    [dataTableView reloadData];
    if (familyNumbersArray.count == 0) {
        [self performSelector:@selector(addFamilyNumber) withObject:nil afterDelay:1];
    }
}
-(void)addFamilyNumber
{
    JSAddFamilyViewController *addFamilyVC = [[JSAddFamilyViewController alloc] init];
    [self presentViewController:addFamilyVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
