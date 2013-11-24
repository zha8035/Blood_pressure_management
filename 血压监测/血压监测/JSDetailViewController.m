//
//  JSDetailViewController.m
//  血压监测
//
//  Created by demo on 13-11-20.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSDetailViewController.h"
#import "PNColor.h"
#import "JSUser.h"
@interface JSDetailViewController ()
{
    XYPieChart *bloodPieChart;
    int bloodHigh;
    int bloodNormal;
    int bloodLow;
}
@end

@implementation JSDetailViewController

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
    
    
    UIScrollView *chartScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, 320, self.view.frame.size.height-90)];
    [self.view addSubview:chartScrollView];
    
    
    bloodPieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200) Center:CGPointMake(160, 110) Radius:M_PI_2];
    [bloodPieChart setAnimationSpeed:1.0];
    [bloodPieChart setStartPieAngle:M_PI_2];
    bloodPieChart.dataSource = self;
    bloodPieChart.delegate = self;
    [chartScrollView addSubview:bloodPieChart];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSArray *dataArray = self.personData.dataArray;
    
    for (int i=0;i<dataArray.count; i++) {
        float value = [[[[dataArray objectAtIndex:i] componentsSeparatedByString:SEP] objectAtIndex:2] floatValue];
        if (value > 100) {
            bloodHigh++;
        }else if(value < 60){
            bloodLow++;
        }else{
            bloodNormal++;
        }
    }
    [bloodPieChart reloadData];
}
-(void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.titleLab.text = self.personData.name;
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    
    return 3;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    if (pieChart == bloodPieChart) {
        if (index == 0) {
            return MAX(0.1, bloodHigh);
        }else if(index == 1){
            return MAX(0.1, bloodNormal);
        }else{
            return MAX(0.1, bloodLow);
        }
    }
    return 0;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return PNRed;
    }else if(index == 1){
        return PNGreen;
    }else{
        return PNBlue;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
