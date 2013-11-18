//
//  JSPersonBloodData.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSPersonBloodData.h"

@implementation JSPersonBloodData
+(JSPersonBloodData *)initWithData:(NSDictionary *)data
{
    JSPersonBloodData *peopleBloodData = [[JSPersonBloodData alloc] init];
    peopleBloodData.bloodPressureArray = [[NSMutableArray alloc] init];
    peopleBloodData.bloodArray = [[NSMutableArray alloc] init];
    return peopleBloodData;
}
@end
