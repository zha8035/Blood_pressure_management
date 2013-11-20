//
//  JSFamilyViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSFamilyViewController.h"
#import "JSUser.h"

#import "JSAddFamilyViewController.h"
@interface JSFamilyViewController ()
{
    UITableView *dataTableView;
    NSMutableArray *familyNumbersArray;
}
@end

@implementation JSFamilyViewController

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
	familyNumbersArray = [JSUser familyNumbersArray];
    //添加列表
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.titleLab.frame.origin.y+65, self.view.frame.size.width, self.view.frame.size.height-(self.titleLab.frame.origin.y+65))];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    [self.view addSubview:dataTableView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    self.titleLab.text = @"家庭成员";
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
        cell.delegate = self;
        cell.isCanRemove = YES;
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)addFamilyNumberClick
{
    JSAddFamilyViewController *addFamilyVC = [[JSAddFamilyViewController alloc] init];
    [self presentViewController:addFamilyVC animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSPersonBloodData *data = [JSPersonBloodData initWithData:[familyNumbersArray objectAtIndex:indexPath.row]];
    JSAddFamilyViewController *addFamilyVC = [[JSAddFamilyViewController alloc] init];
    addFamilyVC.personData = data;
    [self presentViewController:addFamilyVC animated:YES completion:nil];
    
    [dataTableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
