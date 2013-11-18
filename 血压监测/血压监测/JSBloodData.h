//
//  JSBloodData.h
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSBloodData : NSObject
@property (nonatomic,assign) NSUInteger highBloodPressure;
@property (nonatomic,assign) NSUInteger lowBloodPressure;
@property (nonatomic,strong) NSString *bloodPressureTime;
@property (nonatomic,strong) NSString *bloodTime;

+(JSBloodData *)initWithData:(NSDictionary *)data;
@end
