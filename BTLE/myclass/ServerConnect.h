//
//  ServerConnect.h
//  HealthABC
//
//  Created by 夏 伟 on 13-12-4.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ServerConnect : NSObject

+(NSData *)doSyncRequest:(NSString *)urlString;

+(NSString *)Login:(NSString *)url;

+(NSDictionary *)getUserInfo:(NSString *)url;
+(NSArray *)getWeightDataHistory:(NSString *)url;
+(NSArray *)getBodyFatDataHistory:(NSString *)url;
+(NSArray *)getBloodPressureDataHistory:(NSString *)url;
+(NSDictionary *)requestCheckCode:(NSString *)url;
+(NSDictionary *)feedBackCheckCode:(NSString *)url;
+(NSDictionary *)getLastData:(NSString *)url;

+(BOOL)uploadUserInfo:(NSString *)url;
+(BOOL)uploadWeightData:(NSString *)url;
+(BOOL)uploadBodyFatData:(NSString *)url;
+(BOOL)uploadBloodPressureData:(NSString *)url;
+(BOOL)uploadWeightTarget:(NSString *)url;
+(BOOL)isConnectionAvailable;
+(BOOL)backCheckCode:(NSString *)url;

+(BOOL)resetPassword:(NSString *)url;

@end
