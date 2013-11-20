//
//  JSPersonBloodData.h
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSPersonBloodData : NSObject
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *headUrl;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *weight;
@property (nonatomic,strong) NSString *hight;
+(JSPersonBloodData *)initWithData:(NSDictionary *)data;
@end
