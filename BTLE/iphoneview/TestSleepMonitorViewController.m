//
//  TestSleepMonitorViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "TestSleepMonitorViewController.h"
#import "Blecontroller.h"
#import "MySingleton.h"

@interface TestSleepMonitorViewController ()

@end

@implementation TestSleepMonitorViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sleepmonitorDataReceived:) name:SleepMonitorDataNotification object:nil];
    
    self.dataMutableString = [[NSMutableString alloc]init];
    self.onedataMutableDictionary = [[NSMutableDictionary alloc]init];
    self.oneSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
    self.totalSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
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

-(void)_sleepmonitorDataReceived:(NSNotification *)notification
{
    NSData *revData = [[MySingleton sharedSingleton].myblecontroller sleepmonitordata];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    for(int i = 0;i<[revData length];i++){
        [self.dataMutableString appendFormat:@"%@ ",[self parseByteToHexString:byte[i]]];
    }
    
    [self.dataMutableString appendString:@"\r\n"];
    
    //解析数据
    if([revData length]==20){
        
        if(1)
        {
            if(byte[0]%16 == 1)  //每条睡眠数据的第一段（前20字节）包含开始和结束时间单独做处理
            {
                int begintimeinterval = byte[5]*256*256*256 + byte[4]*256*256 + byte[3]*256 + byte[2];
                int endtimeinterval = byte[9]*256*256*256 + byte[8]*256*256 + byte[7]*256 + byte[6];
                NSDate *begindate = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:begintimeinterval];
                NSDate *enddate = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:endtimeinterval];
                [self.onedataMutableDictionary setValue:(NSObject *)begindate forKey:@"begintime"];
                [self.onedataMutableDictionary setValue:(NSObject *)enddate forKey:@"endtime"];
                
                //实例化一个NSDateFormatter对象
                NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
                //设定时间格式,这里可以设置成自己需要的格式
                [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [mydateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                
                
                NSString *beginDateStr = [mydateFormatter stringFromDate:begindate];
                NSString *endDateStr = [mydateFormatter stringFromDate:enddate];
                
                NSString *str = [[NSString alloc]initWithFormat:@"UTC_TIMEbegin:%@  end:%@", beginDateStr, endDateStr];
                [self.dataMutableString appendFormat:@"%@  \r\n",str];
                
                
                for(int k = 10;k<[revData length];k+=2)
                {
                    int hourint = byte[k];
                    int minint = byte[k+1]%64;
                    int statueint = byte[k+1]>>6;
                    if(statueint != 0){
                        NSData *hour = [NSData dataWithBytes: &hourint length: sizeof(hourint)];
                        NSData *min = [NSData dataWithBytes: &minint length: sizeof(minint)];
                        NSData *statue = [NSData dataWithBytes: &statueint length: sizeof(statueint)];
                        
                        NSMutableDictionary *pieceSleepData = [[NSMutableDictionary alloc]init];
                        [pieceSleepData setValue:(NSObject *)hour forKey:@"hour"];
                        [pieceSleepData setValue:(NSObject *)min forKey:@"min"];
                        [pieceSleepData setValue:(NSObject *)statue forKey:@"statue"];
                        
                        [self.dataMutableString appendFormat:@"%d|%d|%d  ",statueint,hourint,minint];
                        
                        [self.oneSleepMonitorDataMutableArray addObject:pieceSleepData];
                    }
                    else
                    {
                        [self.dataMutableString appendString:@"N  "];
                    }
                }
                
                [self.dataMutableString appendString:@"\r\n"];
            }
            else{
                
                for(int k = 2;k<[revData length];k+=2)
                {
                    int hourint = byte[k];
                    int minint = byte[k+1]%64;
                    int statueint = byte[k+1]>>6;
                    if(statueint != 0){
                        NSData *hour = [NSData dataWithBytes: &hourint length: sizeof(hourint)];
                        NSData *min = [NSData dataWithBytes: &minint length: sizeof(minint)];
                        NSData *statue = [NSData dataWithBytes: &statueint length: sizeof(statueint)];
                        
                        NSMutableDictionary *pieceSleepData = [[NSMutableDictionary alloc]init];
                        [pieceSleepData setValue:(NSObject *)hour forKey:@"hour"];
                        [pieceSleepData setValue:(NSObject *)min forKey:@"min"];
                        [pieceSleepData setValue:(NSObject *)statue forKey:@"statue"];
                        
                        [self.dataMutableString appendFormat:@"%d|%d|%d  ",statueint,hourint,minint];
                        
                        [self.oneSleepMonitorDataMutableArray addObject:pieceSleepData];
                    }
                    else
                    {
                        [self.dataMutableString appendString:@"N  "];
                    }

                }
                
                [self.dataMutableString appendString:@"\r\n"];
            }
            
            if(byte[0]%16 == 5)  //收到最后一段
            {
                [self.onedataMutableDictionary setValue:self.oneSleepMonitorDataMutableArray forKey:@"sleepmonitordata"];
                self.oneSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
                
                [self.totalSleepMonitorDataMutableArray addObject:self.onedataMutableDictionary];
            }
        }
    }
    
    dataSleepMonitorLabel.text = self.dataMutableString;
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


@end
