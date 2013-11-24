//
//  JSDetailViewController.h
//  血压监测
//
//  Created by demo on 13-11-20.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSCommonViewController.h"
#import "JSPersonBloodData.h"
#import "XYPieChart.h"
@interface JSDetailViewController : JSCommonViewController<XYPieChartDelegate, XYPieChartDataSource>
@property (nonatomic,strong) JSPersonBloodData *personData;
@end
