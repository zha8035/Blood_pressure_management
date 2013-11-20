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
+(void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accountDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)loginWithName:(NSString *)name andWithPassword:(NSString *)password
{
    NSMutableDictionary *namesArray = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"accounts"]];
    if (namesArray==nil) {
        namesArray = [NSMutableDictionary dictionary];
    }
    NSDictionary *accountDic = [namesArray objectForKey:name];
    
    if (accountDic) {
        if ([[accountDic objectForKey:@"password"] isEqualToString:password]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:name forKey:@"name"];
            [dic setObject:password forKey:@"password"];
            
            [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"accountDic"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你的账号不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    return NO;
}
+(BOOL)registerWithUserData:(NSDictionary *)data
{
    NSMutableDictionary *namesArray = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"accounts"]];
    if ([namesArray objectForKey:[data objectForKey:@"name"]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号已被注册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }else{
        [namesArray setObject:data forKey:[data objectForKey:@"name"]];
        [[NSUserDefaults standardUserDefaults] setValue:namesArray forKey:@"accounts"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}
+(NSMutableArray *)familyNumbersArray
{
    NSString *key = [NSString stringWithFormat:@"familyNumber-%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"accountDic"] objectForKey:@"name"]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *a = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (a) {
        for (NSString *key in [a allKeys]) {
            [array addObject:[a objectForKey:key]];
        }
    }
    return array;
}

+(void)addFamilyNumber:(NSArray *)data
{
    NSArray *keys = @[@"headImage",@"name",@"sex",@"age",@"height",@"weight",@"dataArray"];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    for (int i=0; i<data.count; i++) {
        [dataDic setValue:[data objectAtIndex:i] forKey:[keys objectAtIndex:i]];
    }
    NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
    NSString *key = [NSString stringWithFormat:@"familyNumber-%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"accountDic"] objectForKey:@"name"]];
    NSDictionary *a = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    if (a) {
        for (NSString *key in [a allKeys]) {
            [array setObject:[a objectForKey:key] forKey:key];
        }
    }
    
    [array setValue:dataDic forKey:[dataDic objectForKey:@"name"]];
    [[NSUserDefaults standardUserDefaults] setValue:array forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)deleteFamilyNumberWithName:(NSString *)name
{
    NSString *key = [NSString stringWithFormat:@"familyNumber-%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"accountDic"] objectForKey:@"name"]];
    NSMutableDictionary *a = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:key]];
    if (a) {
        [a removeObjectForKey:name];
        [[NSUserDefaults standardUserDefaults] setValue:a forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)addBlood2FamilyNumberWithName:(NSString *)name andWithData:(NSString *)str
{
    NSString *key = [NSString stringWithFormat:@"familyNumber-%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"accountDic"] objectForKey:@"name"]];
    NSMutableDictionary *a = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:key]];
    if (a) {
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:[a objectForKey:name]];
        NSMutableArray *dataArray = [dataDic objectForKey:@"dataArray"];
        [dataArray insertObject:str atIndex:0];
        [a setValue:dataDic forKey:name];
        
        [[NSUserDefaults standardUserDefaults] setValue:a forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
