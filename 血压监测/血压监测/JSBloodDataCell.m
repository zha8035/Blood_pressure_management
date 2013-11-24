//
//  JSBloodDataCell.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSBloodDataCell.h"
#import "PNChart.h"
#import "JSUser.h"

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
        
        
        UILabel *bLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 20, cellHight)];
        bLab.text = @"血\n压";
        bLab.numberOfLines = 0;
        bLab.font = [UIFont boldSystemFontOfSize:20];
        bLab.backgroundColor = [UIColor clearColor];
        bLab.textColor = [UIColor whiteColor];
        [myScrollView addSubview:bLab];
        
        bLab = [[UILabel alloc] initWithFrame:CGRectMake( self.frame.size.width, 0, 20, cellHight)];
        bLab.text = @"心\n率";
        bLab.numberOfLines = 0;
        bLab.font = [UIFont boldSystemFontOfSize:20];
        bLab.backgroundColor = [UIColor clearColor];
        bLab.textColor = [UIColor whiteColor];
        [myScrollView addSubview:bLab];
        //Add BarChart
        highBloodChart = [[PNChart alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-140,cellHight)];
        highBloodChart.backgroundColor = [UIColor clearColor];
        highBloodChart.type = PNBarType;
        highBloodChart.strokeColor = PNRed;
        [highBloodChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
        [myScrollView addSubview:highBloodChart];
        
        lowBloodChart = [[PNChart alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-130, cellHight)];
        lowBloodChart.backgroundColor = [UIColor clearColor];
        lowBloodChart.type = PNBarType;
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
        [bloodChart setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
        [myScrollView addSubview:bloodChart];
        
        //添加低压
        bloodLabel = [[UILabel alloc] initWithFrame:CGRectMake(myScrollView.frame.size.width+25, 20, 50, 30)];
        bloodLabel.backgroundColor = [UIColor clearColor];
        bloodLabel.textAlignment = NSTextAlignmentCenter;
        bloodLabel.textColor = [UIColor whiteColor];
        bloodLabel.font = [UIFont boldSystemFontOfSize:25];
        [myScrollView addSubview:bloodLabel];
        
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

        
        [myScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheCell)]];
    }
    return self;
}
-(void)tapTheCell
{
    [self.delegate selectCellWithIndex:self.tag];
}
-(void)upCellDataWithPersonData:(JSPersonBloodData *)data
{
    NSArray *dataArray = data.dataArray;
   
    highLabel.text = [[[dataArray objectAtIndex:0] componentsSeparatedByString:SEP] objectAtIndex:0];
    if ([highLabel.text intValue] > 150) {
        highLayer.backgroundColor = PNRed.CGColor;
    }else if([highLabel.text intValue] < 90){
        highLayer.backgroundColor = PNBlue.CGColor;
    }else{
        highLayer.backgroundColor = PNGreen.CGColor;
    }
    
    
    lowLabel.text = [[[dataArray objectAtIndex:0] componentsSeparatedByString:SEP] objectAtIndex:1];
    if ([lowLabel.text intValue] > 90) {
        lowLayer.backgroundColor = PNRed.CGColor;
    }else if([lowLabel.text intValue] < 60){
        lowLayer.backgroundColor = PNBlue.CGColor;
    }else{
        lowLayer.backgroundColor = PNGreen.CGColor;
    }
    bloodLabel.text = [[[dataArray objectAtIndex:0] componentsSeparatedByString:SEP] objectAtIndex:2];
    if ([bloodLabel.text intValue] > 100) {
        bloodLayer.backgroundColor = PNRed.CGColor;
    }else if([bloodLabel.text intValue] < 60){
        bloodLayer.backgroundColor = PNBlue.CGColor;
    }else{
        bloodLayer.backgroundColor = PNGreen.CGColor;
    }
    //时间
    NSString *timeStr = [[[dataArray objectAtIndex:0] componentsSeparatedByString:SEP] lastObject];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStr intValue]] ;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYY-MM-dd"];
    NSString *  endTimeString=[dateformatter stringFromDate:confromTimesp];
    bloodTimePressureLabel.text = [NSString stringWithFormat:@"【%@】",endTimeString];
    bloodTimeLabel.text = [NSString stringWithFormat:@"【%@】",endTimeString];
    
    NSMutableArray *bloodChartDatas = [NSMutableArray array];
    NSMutableArray *bloodHighPressureDatas = [NSMutableArray array];
    NSMutableArray *bloodLowPressureDatas = [NSMutableArray array];

    for (int i=0; i<5; i++) {
        NSArray *array = [[dataArray objectAtIndex:i] componentsSeparatedByString:SEP];
        [bloodHighPressureDatas insertObject:[array objectAtIndex:0] atIndex:0];
        [bloodLowPressureDatas insertObject:[array objectAtIndex:1] atIndex:0];
        [bloodChartDatas addObject:[array objectAtIndex:2]];
    }
    [bloodHighPressureDatas addObject:@"200"];
    [bloodLowPressureDatas addObject:@"200"];
    
    [highBloodChart setYValues:bloodHighPressureDatas];
    [lowBloodChart setYValues:bloodLowPressureDatas];
    
    [highBloodChart strokeChart];
    [lowBloodChart strokeChart];
    
    
    [bloodChart setYValues:bloodChartDatas];
    [bloodChart strokeChart];
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
