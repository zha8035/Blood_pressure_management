//
//  JSUser.m
//  血压监测
//
//  Created by demo on 13-11-18.
//  Copyright (c) 2013年 Junsheng. All rights reserved.
//

#import "JSUser.h"

@implementation JSUser
+(BOOL)isLogin
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"accountDic"]) {
        return YES;
    }
    return NO;
}

+(NSMutableArray *)familyNumbersArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *a = [[NSUserDefaults standardUserDefaults] valueForKey:@"familyNumber"];
    if (a) {
        for (NSString *key in [a allKeys]) {
            [array addObject:[a objectForKey:key]];
        }
    }
    return array;
}

+(void)addFamilyNumber:(NSArray *)data
{
    NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
    NSDictionary *a = [[NSUserDefaults standardUserDefaults] valueForKey:@"familyNumber"];
    if (a) {
        for (NSString *key in [a allKeys]) {
            [array setObject:[a objectForKey:key] forKey:key];
        }
    }
    [array setValue:data forKey:[data objectAtIndex:1]];
    [[NSUserDefaults standardUserDefaults] setValue:array forKey:@"familyNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)deleteFamilyNumberWithName:(NSString *)name
{
    NSMutableDictionary *a = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"familyNumber"]];
    if (a) {
        [a removeObjectForKey:name];
        [[NSUserDefaults standardUserDefaults] setValue:a forKey:@"familyNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
@end
