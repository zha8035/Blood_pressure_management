//
//  JSBloodData.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSBloodData.h"

@implementation JSBloodData

+(JSBloodData *)initWithData:(NSDictionary *)data
{
    JSBloodData *bloodData = [[JSBloodData alloc] init];
    bloodData.highBloodPressure = 120;
    bloodData.lowBloodPressure = 80;
    bloodData.bloodPressureTime = @"12-11-11";
    bloodData.bloodTime = @"120-2-9";
    return bloodData;
}
@end
