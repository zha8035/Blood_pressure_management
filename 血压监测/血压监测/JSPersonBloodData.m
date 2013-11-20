//
//  JSPersonBloodData.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSPersonBloodData.h"

@implementation JSPersonBloodData
+(JSPersonBloodData *)initWithData:(NSArray *)data
{
    JSPersonBloodData *peopleBloodData = [[JSPersonBloodData alloc] init];
    peopleBloodData.headUrl = [data objectAtIndex:0];
    peopleBloodData.name = [data objectAtIndex:1];
    peopleBloodData.sex = [data objectAtIndex:2];
    peopleBloodData.age  = [data objectAtIndex:3];
    peopleBloodData.hight = [data objectAtIndex:4];
    peopleBloodData.weight = [data objectAtIndex:5];
    peopleBloodData.dataArray = [data objectAtIndex:6];
    return peopleBloodData;
}
@end
