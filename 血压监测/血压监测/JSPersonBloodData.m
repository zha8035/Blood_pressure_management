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
    peopleBloodData.headUrl = [data objectForKey:@"headImage"];
    peopleBloodData.name = [data objectForKey:@"name"];
    peopleBloodData.sex = [data objectForKey:@"sex"];
    peopleBloodData.age  = [data objectForKey:@"age"];
    peopleBloodData.hight = [data objectForKey:@"height"];
    peopleBloodData.weight = [data objectForKey:@"weight"];
    peopleBloodData.dataArray = [data objectForKey:@"dataArray"];
    return peopleBloodData;
}
@end
