//
//  JSCommonViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSCommonViewController.h"
#import "PNColor.h"
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
        
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 38, 300, 2)];
        lineImageView.image = [UIImage imageNamed:@"line_bg"];
        [self.titleLab addSubview:lineImageView];
        
        UIImage *noDataImage = [UIImage imageNamed:@"nodata"];
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200*noDataImage.size.height/noDataImage.size.width)];
        _noDataImageView.image = noDataImage;
        _noDataImageView.center = self.view.center;
        _noDataImageView.alpha = 0;
        _noDataImageView.backgroundColor = PNWhite;
        _noDataImageView.layer.cornerRadius = 8;
        _noDataImageView.layer.borderWidth =2;
        _noDataImageView.layer.borderColor = PNGreen.CGColor;
        [self.view addSubview:_noDataImageView];
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
