//
//  ServerConnect.m
//  HealthABC
//
//  Created by 夏 伟 on 13-12-4.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "ServerConnect.h"
#import "MySingleton.h"

@implementation ServerConnect

//登陆
//登陆成功返回@“0”
//   失败返回 errormessage
+(NSString *)Login:(NSString *)url
{
    NSString *s;
    NSData *dataRev = [self doSyncRequest:url];
    NSData *jasonData = dataRev;
    if(jasonData != nil)
    {
        NSString *str = [[NSString alloc]initWithData:jasonData encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        NSRange range = [str rangeOfString:@"true"];
        if(range.length != 0)
        {
            NSLog(@"Login success！");
            NSRange range1 = [str rangeOfString:@"authkey"];
            NSRange range2 = [str rangeOfString:@"userid"];
            
            if(range1.length != 0 && range2.length != 0)
            {
                NSUInteger head = range1.location + range1.length + 3;
                NSUInteger end = range2.location - 3;
                NSString *authkey;
                authkey = [str substringWithRange:NSMakeRange(head, end-head)];
                
                NSLog(@"authkey = %@",authkey);
                NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
                
                
                [MySingleton sharedSingleton].authKey = authkey;
                [[MySingleton sharedSingleton].nowuserinfo setValue:authkey forKey:@"AuthKey"];
                NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
                s = @"0";
            }
        }
        else
        {
            NSError *error;
            id jasonObject = [NSJSONSerialization JSONObjectWithData:jasonData options:NSJSONReadingAllowFragments error:&error];
            if([jasonObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dictionary = (NSDictionary *)jasonObject;
                s =[[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"errormessage"]];
            }
        }
    }
    
    return s;
}

//获取用户信息
+(NSDictionary *)getUserInfo:(NSString *)url
{
    NSDictionary *dictionary;
    
    NSData *dataRev = [self doSyncRequest:url];
    
    if(dataRev == nil)
    {
        return nil;
    }
    
    NSError *error = nil;
    //[{"like_name":"wahaha","age":"26","birthday":"1987","profesion":"1","sex":"0","height":"182.0","weight":"68.0","stepSize":"75.0","mobile":"18820995660","address":"","email":"null"}]
    NSString *str = [[NSString alloc]initWithData:dataRev encoding:NSUTF8StringEncoding];
    
//    str = @"{\"like_name\":\"wahaha\",\"age\":\"26\",\"birthday\":\"1987\",\"profesion\":\"1\",\"sex\":\"0\",\"height\":\"182.0\",\"weight\":\"68.0\",\"stepSize\":\"75.0\",\"mobile\":\"18820995660\",\"address\":\"\",\"email\":\"null\"}";
    str = [str substringWithRange:NSMakeRange(1, str.length-1)];
    str = [str substringWithRange:NSMakeRange(0, str.length-1)];
    NSLog(@"%@",str);
    NSData *strdata = [str dataUsingEncoding:NSUTF8StringEncoding];

    id jsonObject = [NSJSONSerialization JSONObjectWithData:strdata options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"jsonObject : %@",jsonObject);
    
    if(jsonObject != nil)
    {
        NSLog(@"成功转为json数据");
        if([jsonObject isKindOfClass:[NSDictionary class]])
        {
            dictionary = (NSDictionary *)jsonObject;
            NSLog(@"Dictionary = %@",dictionary);
            
            NSString *like_name = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"like_name"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:like_name forKey:@"UserName"];
            NSString *age = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"age"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:age forKey:@"Age"];
            NSString *birthday = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"birthday"]];
            NSLog(@"birthday:%@",birthday);
            [[MySingleton sharedSingleton].nowuserinfo setValue:birthday forKey:@"Birthday"];
            NSString *height = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"height"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:height forKey:@"Height"];
            NSString *profesion = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"profesion"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:profesion forKey:@"Profesion"];
            NSString *sex = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"sex"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:sex forKey:@"Gender"];
            NSString *stepSize = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"stepSize"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:stepSize forKey:@"StepSize"];
            NSString *weight = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"weight"]];
            [[MySingleton sharedSingleton].nowuserinfo setValue:weight forKey:@"Weight"];
            
            NSLog(@"MySingleton Weight = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"]);
        }
        else if([jsonObject isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)jsonObject;
            NSLog(@"Array = %@",array);

        }
    }

    return dictionary;
}

+(NSDictionary *)requestCheckCode:(NSString *)url
{
    BOOL b = false;
    
    NSDictionary *dictionary;
    
    NSData *dataRev = [self doSyncRequest:url];
    
    if(dataRev == nil)
    {
        return false;
    }
    
    NSError *error = nil;
    NSString *str = [[NSString alloc]initWithData:dataRev encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSData *strdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:strdata options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"jsonObject : %@",jsonObject);
    
    if(jsonObject != nil)
    {
        NSLog(@"成功转为json数据");
        if([jsonObject isKindOfClass:[NSDictionary class]])
        {
            dictionary = (NSDictionary *)jsonObject;
            NSLog(@"Dictionary = %@",dictionary);
            
            NSString *success = [[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"success"]];
            if([success isEqualToString:@"1"])
            {
                b = true;
            }
        }
        else if([jsonObject isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)jsonObject;
            NSLog(@"Array = %@",array);
        }
    }

    
    return dictionary;
}

+(BOOL)backCheckCode:(NSString *)url
{
    BOOL b = false;
    NSData *revData = [self doSyncRequest:url];
    if(revData.length == 0) //没有任何返回表示：成功...
    {
        b = true;
    }
    return b;
}


+(BOOL)uploadBodyFatData:(NSString *)url
{
    BOOL b = false;
    NSData *revData = [self doSyncRequest:url];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:revData options:NSJSONReadingAllowFragments error:&error];
    if(jsonObject != nil)
    {
        if([jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = (NSDictionary *)jsonObject;
            if([[[NSString alloc]initWithFormat:@"%@",[dictionary valueForKey:@"success"]]isEqualToString:@"true"])
            {
                b = true;
            }
        }
    }
    return  b;
}

+(NSDictionary *)getLastData:(NSString *)url
{
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSData *revData =[self doSyncRequest:url];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:revData options:NSJSONReadingAllowFragments error:&error];
    if(jsonObject != nil)
    {
        if([jsonObject isKindOfClass:[NSDictionary class]])
        {
            dic = (NSDictionary *)jsonObject;
        }
    }

    return dic;
}

//同步请求
+(NSData *)doSyncRequest:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//转化为正确格式的url
    NSLog(@"%@",urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20.0];
    
    NSHTTPURLResponse *response;
    NSError *error;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error != nil)
    {
        NSLog(@"Error on load = %@", [error localizedDescription]);
        return nil;
    }
    
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode != 200)//200服务器返回网页成功
        {
            return nil;
        }
        
        NSLog(@"Headers: %@", [httpResponse allHeaderFields]);
    }
    
    return data;
}

//检查网络是否连接
+ (BOOL) isConnectionAvailable
{
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.ebelter.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        return FALSE;
    } else {
        return TRUE;
    }
}


@end
