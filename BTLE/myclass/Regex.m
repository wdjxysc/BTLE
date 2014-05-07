//
//  Regex.m
//  HealthABC
//
//  Created by 夏 伟 on 13-12-14.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "Regex.h"

@implementation Regex


/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) validateMobile:(NSString*) mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end
