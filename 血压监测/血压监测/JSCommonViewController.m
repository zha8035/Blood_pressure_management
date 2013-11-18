//
//  JSCommonViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSCommonViewController.h"

@interface JSCommonViewController ()

@end

@implementation JSCommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.layer.contents = (id)[UIImage imageNamed:@"viewbg"].CGImage;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>6) {
            self.titleLab =[[UILabel alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width, 40)];
        }else{
            self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        }
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.titleLab];
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
