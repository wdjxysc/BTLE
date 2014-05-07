//
//  TestHistoryStepViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "TestHistoryStepViewController.h"
#import "Blecontroller.h"
#import "MySingleton.h"

@interface TestHistoryStepViewController ()

@end

@implementation TestHistoryStepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_histroystepDataReceived:) name:HistoryDataNotification object:nil];
    
    self.dataString = [[NSMutableString alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)_histroystepDataReceived:(NSNotification *)notification
{
    NSData *revData = [[MySingleton sharedSingleton].myblecontroller historystepdata];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    for(int i = 0;i<[revData length];i++){
        [self.dataString appendFormat:@"%@ ",[self parseByteToHexString:byte[i]]];
    }
    
    [self.dataString appendString:@"\r\n"];
    
    //解析数据
    if([revData length]==18){
        int timeinterval = byte[5]*256*256*256 + byte[4]*256*256 + byte[3]*256 + byte[2];
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:timeinterval];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [mydateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        
        NSString *currentDateStr = [mydateFormatter stringFromDate:date];
        
        NSString *str = [[NSString alloc]initWithFormat:@"UTC_TIME:%@  ",currentDateStr];
        
        int sporttimeinterval = byte[9]*256*256*256 + byte[8]*256*256 + byte[7]*256 + byte[6];
        int sportmin = sporttimeinterval%60;
        
        NSString *sporttimestr = [[NSString alloc]initWithFormat:@"sporttime(min):%d  ",sportmin];
        
        int stepnum = byte[13]*256*256*256 + byte[12]*256*256 + byte[11]*256 + byte[10];
        int stepnuno2 = byte[17]*256*256*256 + byte[16]*256*256 + byte[15]*256 + byte[14];
        
        NSString *stepnumstr = [[NSString alloc]initWithFormat:@"step:%d  stepo2:%d  ",stepnum,stepnuno2];
        
        [self.dataString appendFormat:@"%@%@%@ \r\n",str,sporttimestr,stepnumstr];
    }
    
    dataHistoryStepLabel.text = self.dataString;
}

-(void)utcTimeTest
{
//    int timeinterval = 0x02*256*256*256 + 0xc0*256*256 + 0x01*256 + 0x00;
//    int timeinterval1 = 0x02*256*256*256 + 0xbe*256*256 + 0xaf*256 + 0x5d;
//    int timeinterval2 = 0x02*256*256*256 + 0xbd*256*256 + 0x5e*256 + 0x00;
    
    int timeinterval3 = 46137600;
    
    //
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:timeinterval3];
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [mydateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSString *currentDateStr = [mydateFormatter stringFromDate:date];
    
    [self.dataString appendString:currentDateStr];
    dataHistoryStepLabel.text = self.dataString;
    NSLog(@"%@",[NSTimeZone localTimeZone]);
    NSLog(@"%@",currentDateStr);
}

-(NSString *)parseByteToHexString:(Byte)byte
{
    NSString *str = [[NSString alloc]initWithFormat:@"%X",byte];
    
    if([str length] == 1)
    {
        str = [[NSString alloc]initWithFormat:@"0%@",str];
    }
    
    return str;
}

-(IBAction)updateTimeBtnPressed:(id)sender
{
    NSDate *nowlocaldate = [self getNowDateFromatAnDate:[NSDate date]];
    int timeinterval = [nowlocaldate timeIntervalSinceReferenceDate];
    Byte b1 = timeinterval/(256*256*256);
    Byte b2 = timeinterval/(256*256)%256;
    Byte b3 = timeinterval/256%256;
    Byte b4 = timeinterval%256;
    Byte sendbyte[] = {b4, b3, b2, b1};
    NSData *data = [[NSData alloc]initWithBytes:sendbyte length:sizeof(sendbyte)];
    
    [[MySingleton sharedSingleton].myblecontroller setCurrentTime:data];
    //timeinterval	int	411300923	411300923
}

-(IBAction)setUserInfo:(id)sender
{
    [self setUserInfoToDevice];
}

-(void)setUserInfoToDevice
{
    double weight = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"] doubleValue];
    
//    double height =[[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
//    double stepsize =[[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
//    
//    int x1 =[[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
//    int x2 =((int)(weight*10))%256;
//    int x3 =((int)(weight*10))/256;
//    int x4 =[[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
    Byte b1 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
    Byte b2 = ((int)(weight*10))%256;
    Byte b3 = ((int)(weight*10))/256;
    Byte b4 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
    Byte sendbyte[] = {b1, b2, b3, b4};
    NSData *data = [[NSData alloc]initWithBytes:sendbyte length:sizeof(sendbyte)];
    [[MySingleton sharedSingleton].myblecontroller setUserInfo:data];
}


//根据utc时间获取系统当前当地时间
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
@end
