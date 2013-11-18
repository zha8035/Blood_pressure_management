//
//  JSBloodDataCell.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSBloodDataCell.h"
#import "PNChart.h"


#define cellHight 120
@interface JSBloodDataCell ()
{
    PNChart *lowBloodChart;
    PNChart *highBloodChart;
    PNChart *bloodChart;
    
    UILabel *highLabel;
    CALayer *highLayer;
    UILabel *lowLabel;
    CALayer *lowLayer;
    
    UILabel *bloodLabel;
    CALayer *bloodLayer;
    
    UILabel *bloodTimePressureLabel;
    UILabel *bloodTimeLabel;
    UIPageControl *pageControl;
}
@end
@implementation JSBloodDataCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CALayer *labLayer = [[CALayer alloc] init];
        labLayer.frame = CGRectMake(0, 10, 5, cellHight-30);
        labLayer.backgroundColor = PNFreshGreen.CGColor;
        [self.layer addSublayer:labLayer];
        
        
        
        UIScrollView *myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-10, cellHight)];
        myScrollView.pagingEnabled = YES;
        myScrollView.delegate = self;
        [myScrollView setContentSize:CGSizeMake(self.frame.size.width*2-20, self.frame.size.height)];
        [self addSubview:myScrollView];
        
        
        UILabel *bloodLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 20, cellHight)];
        bloodLab.text = @"血\n压";
        bloodLab.numberOfLines = 0;
        bloodLab.font = [UIFont boldSystemFontOfSize:20];
        bloodLab.backgroundColor = [UIColor clearColor];
        bloodLab.textColor = [UIColor whiteColor];
        [myScrollView addSubview:bloodLab];
        
        bloodLab = [[UILabel alloc] initWithFrame:CGRectMake( self.frame.size.width, 0, 20, cellHight)];
        bloodLab.text = @"心\n率";
        bloodLab.numberOfLines = 0;
        bloodLab.font = [UIFont boldSystemFontOfSize:20];
        bloodLab.backgroundColor = [UIColor clearColor];
        bloodLab.textColor = [UIColor whiteColor];
        [myScrollView addSubview:bloodLab];
        //Add BarChart
        highBloodChart = [[PNChart alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-120,cellHight)];
        highBloodChart.backgroundColor = [UIColor clearColor];
        highBloodChart.type = PNBarType;
        highBloodChart.strokeColor = PNRed;
        [highBloodChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
        [highBloodChart setYValues:@[@"1",@"10",@"2",@"6",@"3"]];
        [highBloodChart strokeChart];
        [myScrollView addSubview:highBloodChart];
        
        lowBloodChart = [[PNChart alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-120, cellHight)];
        lowBloodChart.backgroundColor = [UIColor clearColor];
        lowBloodChart.type = PNBarType;
        //[barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
        [lowBloodChart setYValues:@[@"10",@"16",@"9",@"6",@"3"]];
        [lowBloodChart strokeChart];
        
        [myScrollView addSubview:lowBloodChart];
        
        //添加高压
        highLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 50, 30)];
        highLabel.backgroundColor = [UIColor clearColor];
        highLabel.text = @"120";
        highLabel.textAlignment = NSTextAlignmentCenter;
        highLabel.textColor = [UIColor whiteColor];
        highLabel.font = [UIFont boldSystemFontOfSize:25];
        [myScrollView addSubview:highLabel];
        
        highLayer = [[CALayer alloc] init];
        highLayer.frame = CGRectMake(SCREEN_WIDTH-80, 40, 10, 10);
        highLayer.backgroundColor = PNGreen.CGColor;
        highLayer.cornerRadius = 5;
        [myScrollView.layer addSublayer:highLayer];
        
        
        UILabel *hiLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 50, 30)];
        hiLab.backgroundColor = [UIColor clearColor];
        hiLab.text =@"收缩压";
        hiLab.textColor = [UIColor whiteColor];
        hiLab.font = [UIFont systemFontOfSize:12];
        [myScrollView addSubview:hiLab];
        //添加低压
        lowLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 50, 50, 30)];
        lowLabel.backgroundColor = [UIColor clearColor];
        lowLabel.text = @"80";
        lowLabel.textAlignment = NSTextAlignmentCenter;
        lowLabel.textColor = [UIColor whiteColor];
        lowLabel.font = [UIFont boldSystemFontOfSize:25];
        [myScrollView addSubview:lowLabel];
        
        lowLayer = [[CALayer alloc] init];
        lowLayer.frame = CGRectMake(SCREEN_WIDTH-80, 80, 10, 10);
        lowLayer.backgroundColor = PNGreen.CGColor;
        lowLayer.cornerRadius = 5;
        [myScrollView.layer addSublayer:lowLayer];
        
        UILabel *lowLab= [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 50, 50, 30)];
        lowLab.backgroundColor = [UIColor clearColor];
        lowLab.text =@"舒张压";
        lowLab.textColor = [UIColor whiteColor];
        lowLab.font = [UIFont systemFontOfSize:12];
        [myScrollView addSubview:lowLab];
        //添加血压时间
        bloodTimePressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width-100, 90, 100, 20)];
        bloodTimePressureLabel.text = @"【10-10 10:50】";
        bloodTimePressureLabel.textColor = PNGreen;
        bloodTimePressureLabel.backgroundColor = [UIColor clearColor];
        bloodTimePressureLabel.font = [UIFont systemFontOfSize:10];
        bloodTimePressureLabel.textAlignment = NSTextAlignmentRight;
        [myScrollView addSubview:bloodTimePressureLabel];
        
        //添加心率
        bloodChart = [[PNChart alloc] initWithFrame:CGRectMake(self.frame.size.width-10+100, 0, SCREEN_WIDTH-110, cellHight)];
        bloodChart.backgroundColor = [UIColor clearColor];
        [bloodChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
        [bloodChart setYValues:@[@"1",@"10",@"2",@"6",@"3"]];
        [bloodChart strokeChart];
        [myScrollView addSubview:bloodChart];
        
        //添加低压
        bloodLab = [[UILabel alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width+25, 20, 50, 30)];
        bloodLab.backgroundColor = [UIColor clearColor];
        bloodLab.text = @"80";
        bloodLab.textAlignment = NSTextAlignmentCenter;
        bloodLab.textColor = [UIColor whiteColor];
        bloodLab.font = [UIFont boldSystemFontOfSize:25];
        [myScrollView addSubview:bloodLab];
        
        bloodLayer = [[CALayer alloc] init];
        bloodLayer.frame = CGRectMake(myScrollView.frame.size.width+45, 60, 10, 10);
        bloodLayer.backgroundColor = PNGreen.CGColor;
        bloodLayer.cornerRadius = 5;
        [myScrollView.layer addSublayer:bloodLayer];
        
        UILabel *blLab= [[UILabel alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width+75, 20, 50, 30)];
        blLab.backgroundColor = [UIColor clearColor];
        blLab.text =@"BPM";
        blLab.textColor = [UIColor whiteColor];
        blLab.font = [UIFont systemFontOfSize:12];
        [myScrollView addSubview:blLab];
        
        
        //添加血压时间
        bloodTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width+10, 90, 100, 20)];
        bloodTimeLabel.text = @"【10-10 10:50】";
        bloodTimeLabel.textColor = PNGreen;
        bloodTimeLabel.backgroundColor = [UIColor clearColor];
        bloodTimeLabel.font = [UIFont systemFontOfSize:10];
        bloodTimeLabel.textAlignment = NSTextAlignmentRight;
        [myScrollView addSubview:bloodTimeLabel];
        //添加页数
        pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages =2;
        pageControl.center = CGPointMake(self.frame.size.width/2, cellHight-10);
        [self addSubview:pageControl];

    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
