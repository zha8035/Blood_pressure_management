//
//  JSTabBarViewController.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSTabBarViewController.h"
#import "PNColor.h"
@interface JSTabBarViewController ()
{
    UIImageView *menuView;
    UIImageView *selectView;
    UIButton *menuButton;
    BOOL isCanMenu;
}
@end

@implementation JSTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self makeTabBarHidden:YES];
    }
    return self;
}
-(void)setMenu
{
    
    UIViewController *currentVC=[self selectedViewController];
    int forward=1;
    if(menuView.frame.origin.x==0){
        forward=-1;
        currentVC.view.userInteractionEnabled=YES;
    }else{
        currentVC.view.userInteractionEnabled=NO;
    }
    menuView.center=CGPointMake(menuView.center.x+forward*80, menuView.center.y);
    menuButton.center=CGPointMake(menuButton.center.x+forward*80, menuButton.center.y);
    currentVC.view.center=CGPointMake(currentVC.view.center.x+forward*80, currentVC.view.center.y);
    isCanMenu=YES;
    
}
//菜单按钮事件
-(void)menuButtonClick
{
    
    UIViewController *currentVC=[self selectedViewController];
    int forward=1;
    if(menuView.frame.origin.x==0){
        forward=-1;
        currentVC.view.userInteractionEnabled=YES;
    }else{
        currentVC.view.userInteractionEnabled=NO;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        menuView.center=CGPointMake(menuView.center.x+forward*80, menuView.center.y);
        menuButton.center=CGPointMake(menuButton.center.x+forward*80, menuButton.center.y);
        //currentVC.view.center=CGPointMake(currentVC.view.center.x+forward*80, currentVC.view.center.y);
    } completion:^(BOOL finished) {
        isCanMenu=YES;
    }];
}
-(void)tabTitleButtonClick:(UIButton *)button
{
    if (!isCanMenu) {
        return;
    }
    isCanMenu=NO;
    CGRect frame=selectView.frame;
    frame.origin.x=-80;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selectView.frame=frame;
    } completion:^(BOOL finished) {
        CGRect frame=selectView.frame;
        frame.origin.y=45+60*button.tag;
        selectView.frame=frame;
        frame.origin.x=0;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            selectView.frame=frame;
        } completion:^(BOOL finished) {
            self.selectedIndex=button.tag;
            [self menuButtonClick];
        }];
    }];
    
}

- (void)makeTabBarHidden:(BOOL)hide {
    if ( [self.view.subviews count] < 2 )
        return;
    
    UIView *contentView;
    
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    
    if ( hide ){
        contentView.frame = self.view.bounds;
    }
    else{
        contentView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - self.tabBar.frame.size.height);
    }
    
    self.tabBar.hidden = hide;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    isCanMenu=YES;
	//添加菜单
    menuView=[[UIImageView alloc] initWithFrame:CGRectMake(-80, 20, 80, [[UIScreen mainScreen] bounds].size.height)];
    menuView.userInteractionEnabled=YES;
    menuView.layer.contents = (id)[UIImage imageNamed:@"menubg"].CGImage;
    [self.view addSubview:menuView];
    
    
    //添加选择view
    selectView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 45, 80, 55)];
    selectView.image = [UIImage imageNamed:@"viewbg"];
    [menuView addSubview:selectView];
    
    UIImageView *sImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 52, 80, 3)];
    sImageView.backgroundColor=PNFreshGreen;
    [selectView addSubview:sImageView];
    
    NSArray *tabTitles=@[@"首页",@"家庭成员",@"提醒",@"退出登录"];
    for (int i=0; i<tabTitles.count; i++) {
        //添加标签背景
        
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 80,50)];
        button.center=CGPointMake(40,70+60*i);
        [button addTarget:self action:@selector(tabTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [menuView addSubview:button];
        
        
        UILabel *lab= [[ UILabel alloc] initWithFrame:CGRectMake(25, 15, 50, 25)];
        lab.textColor = [UIColor whiteColor];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [tabTitles objectAtIndex:i];
        lab.font = [UIFont boldSystemFontOfSize:12];
        lab.layer.cornerRadius = 12.5;
        //lab.layer.contents = (id)[UIImage imageNamed:@"viewbg"].CGImage;
        [button addSubview:lab];
    }
    
    UIImage *menuImage= [UIImage imageNamed:@"菜单"];
    menuButton=[[UIButton alloc] initWithFrame:CGRectMake(-18, 20, menuImage.size.width/menuImage.size.height*40, 40)];
    [menuButton addTarget:self action:@selector(menuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    menuButton.layer.masksToBounds = YES;
    menuButton.layer.contents = (id)[UIImage imageNamed:@"menubg"].CGImage;
    menuButton.layer.cornerRadius = 20;
    [menuButton setBackgroundImage:menuImage forState:UIControlStateNormal];
    //[menuButton setBackgroundImage:imageWithPath(@"选择-凹陷", @"png") forState:UIControlStateHighlighted];
    [self.view addSubview:menuButton];
    //添加手势
    UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipTheView:)];
    swip.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swip];
    
    swip=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipTheView:)];
    swip.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    
    //添加云同步
//    UIImage *cloudImage = [UIImage imageNamed:@"storefront_icon_data_on"];
//    UIButton *cloudButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 20, 30*cloudImage.size.width/cloudImage.size.height, 30)];
//    [cloudButton setBackgroundImage:cloudImage forState:UIControlStateNormal];
//    [self.view addSubview:cloudButton];
}
-(void)swipTheView:(UISwipeGestureRecognizer *)swip
{
    float p=menuView.frame.origin.x;
    switch (swip.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            if(p==-80){
                [self menuButtonClick];
            }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            if(p==0){
                [self menuButtonClick];
            }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
