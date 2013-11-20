//
//  JSUser.h
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSPersonBloodData.h"
#define SEP @"***"
@interface JSUser : NSObject
+(BOOL)isLogin;

+(NSMutableArray *)familyNumbersArray;

+(void)addFamilyNumber:(NSArray *)data;

+(void)deleteFamilyNumberWithName:(NSString *)name;

+(void)addBlood2FamilyNumberWithName:(NSString *)name andWithData:(NSString *)str;
@end
