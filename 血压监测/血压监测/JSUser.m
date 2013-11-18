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
@end
