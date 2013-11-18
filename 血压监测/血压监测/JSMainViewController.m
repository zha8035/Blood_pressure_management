//
//  JSMainViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSMainViewController.h"
#import "JSBloodDataCell.h"
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
    
    
    
    dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
    dataTableView.backgroundColor = [UIColor clearColor];
    dataTableView.dataSource = self;
    dataTableView.delegate = self;
    [self.view addSubview:dataTableView];
    
    
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
