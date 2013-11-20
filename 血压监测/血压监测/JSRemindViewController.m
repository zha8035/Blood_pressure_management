//
//  JSRemindViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSRemindViewController.h"
#import "PNColor.h"
@interface JSRemindViewController ()

@end

@implementation JSRemindViewController

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
    self.titleLab.text = @"提醒";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(270, self.view.frame.size.height - 60, 40, 40)];
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
- (void)addButtonClick
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
