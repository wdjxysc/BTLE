//
//  ViewController.m
//  BTLE
//
//  Created by 夏 伟 on 13-12-27.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "ViewController.h"
#import "Blecontroller.h"
#import "MySingleton.h"
#import "database.h"
#import "MDRadialProgressLabel.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface ViewController ()

@property(retain,nonatomic)Blecontroller *myblecontroller;
@end

@implementation ViewController
@synthesize myblecontroller;
@synthesize testtimeLabel;
@synthesize stepdataLabel;
@synthesize stepo2dataLabel;
@synthesize stepdata;
@synthesize distancedata;
@synthesize kcaldata;
@synthesize stepo2data;
@synthesize distanceo2data;
@synthesize kcalo2data;
@synthesize distanceDataLabel;
@synthesize kcalDataLabel;

- (void)viewDidLoad
{
    [self initMyView];
    [super viewDidLoad];
    [database initDataBase];
    [self initApp];
    [self startStepNumNotify];
    
	// Do any additional setup after loading the view, typically from a nib.
    
//    //设定 ScrollView 的 Frame，逐页滚动时，如果横向滚动，按宽度为一个单位滚动，纵向时，按高度为一个单位滚动
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 0, 210, 100)];
//    scrollView.backgroundColor = [UIColor grayColor]; // ScrollView 背景色，即 View 间的填充色
//    
//    //向 ScrollView 中加入第一个 View，View 的宽度 200 加上两边的空隙 5 等于 ScrollView 的宽度
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(5,5,200,90)];
//    view1.backgroundColor = [UIColor redColor];
//    [scrollView addSubview:view1];
//    
//    //第二个 View，它的宽度加上两边的空隙 5 等于 ScrollView 的宽度，两个 View 间有 10 的间距
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(215,5,200,90)];
//    view2.backgroundColor = [UIColor greenColor];
//    [scrollView addSubview:view2];
//    
//    //第三个 View
//    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(425,5,200,90)];
//    view3.backgroundColor = [UIColor blueColor];
//    [scrollView addSubview:view3];
//    
//    [self.view addSubview:scrollView];
//    
//    //这个属性很重要，它可以决定是横向还是纵向滚动，一般来说也是其中的 View 的总宽度，和总的高度
//    //这里同时考虑到每个 View 间的空隙，所以宽度是 200x3＋5＋10＋10＋5＝630
//    //高度上与 ScrollView 相同，只在横向扩展，所以只要在横向上滚动
//    scrollView.contentSize = CGSizeMake(630, 100);
//    
//    //用它指定 ScrollView 中内容的当前位置，即相对于 ScrollView 的左上顶点的偏移
//    scrollView.contentOffset = CGPointMake(210, 0);
//    
//    //按页滚动，总是一次一个宽度，或一个高度单位的滚动
//    scrollView.pagingEnabled = YES;
//    
//    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    lable.text = @"test";
//    [self.view addSubview: lable];
//    lable.backgroundColor = [UIColor clearColor];
//    
//    // 设定CALayer
//    self.view.layer.backgroundColor =[UIColor orangeColor].CGColor;
//    self.view.layer.cornerRadius =20.0;
//    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startStepNumNotify
{
    Blecontroller *blecontroller = [Blecontroller shareBlecontroller];
    [blecontroller setDeviceName:@"EP60B4"];
    [blecontroller setService_UUID:@"1814"];
    [blecontroller setCharacteristec_UUID:@"ffa6"];
    
    [blecontroller setBATTERY_SERVICE_UUID:@"180f"];
    [blecontroller setBATTERY_CHARACTERISTIC_UUID:@"2a19"];
    
    [blecontroller setTIME_SERVICE_UUID:@"1805"];
    [blecontroller setTIME_CHARACTERISTIC_UUID:@"2a2b"];
    
    [blecontroller setHISTORYSTEP_SERVICE_UUID:@"ffc0"];
    [blecontroller setHISTORYSTEP_DATA_CHARACTERISTIC_UUID:@"ffc2"];
    [blecontroller setHISTORYSTEP_CLEAR_CHARACTERISTIC_UUID:@"ffc1"];
    
    [blecontroller setDEVICE_INFO_SERVICE_UUID:@"180a"];
    [blecontroller setDEVICE_INFO_CHARACTERISTIC_UUID:@"2a24"];
    
    [blecontroller setSLEEPMONITOR_SERVICE_UUID:@"ff70"];
    [blecontroller setSLEEPMONITOR_DATA_CHARACTERISTIC_UUID:@"ff72"];
    
    [blecontroller setREMIND_SERVICE_UUID:@"ffe0"];
    [blecontroller setCALLER_REMIND_CHARACTERISTIC_UUID:@"ffe1"];
    [blecontroller setSPORT_REMIND_CHARACTERISTIC_UUID:@"ffe2"];
    [blecontroller setALARM_REMIND_CHARACTERISTIC_UUID:@"ffe3"];
    
    [blecontroller setUSERINFO_SERVICE_UUID:@"ff80"];
    [blecontroller setUSERINFO_CHARACTERISTIC_UUID:@"ff81"];
    
    [blecontroller managerinit];
    
    myblecontroller = blecontroller;
    [MySingleton sharedSingleton].myblecontroller = blecontroller;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_dataReceived:) name:BleDataReceivedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_histroystepDataReceived:) name:HistoryDataNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_sleepmonitorDataReceived:) name:SleepMonitorDataNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_batterylvlDataReceived:) name:BatteryDataNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_deviceinfoDataReceived:) name:DeviceInfoNotification object:nil];
    
    self.onedataMutableDictionary = [[NSMutableDictionary alloc]init];
    self.oneSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
    self.totalSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
}

-(void)_dataReceived:(NSNotification *)notification
{
    NSData *revData = [myblecontroller data];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    int step = byte[3]*256*256*256 + byte[2]*256*256 +byte[1]*256 +byte[0];
    int stepo2 = byte[7]*256*256*256 + byte[6]*256*256 +byte[5]*256 +byte[4];
    
//    int height = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
    int steplength = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
    double weight = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"] doubleValue];
    
    //手环卡路里计算方式
    //已知体重、距离
    //跑步热量（kcal）＝体重（kg）×距离（公里）×1.036
    
    stepdata = step;
    distancedata = stepdata * steplength/100000.0f;
    kcaldata = weight * distancedata * 1.036f;
    stepo2data = stepo2;
    distanceo2data = stepo2data * steplength/100000.0f;
    kcalo2data = weight * distanceo2data * 1.036f;
    
    [self showstepdata];
    [self showdistancedata];
    [self showkcaldata];
    
    int target = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"TargetStepNumber"] intValue];
    
    [self setProgress:target havegot:step];
    
    //myblecontroller data 清零
    [[myblecontroller data] setLength:0];
}


-(void)setProgress:(double)total havegot:(double)havegot
{
    if(self.radialView2 != nil){
        [self.radialView2 removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(180, 45, 120, 120);
    
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc]init];
    theme.thickness = 15;
	theme.incompletedColor = [UIColor whiteColor];
	theme.completedColor = [UIColor colorWithRed:184.0/256 green:254.0/256 blue:69.0/256 alpha:1.0f];
    theme.sliceDividerHidden = YES;
    theme.labelShadowColor = [UIColor clearColor];
    self.radialView2 = [[MDRadialProgressView alloc]initWithFrame:frame andTheme:theme];
	self.radialView2.progressTotal = total;
    self.radialView2.progressCounter = havegot;
    
    self.radialView2.label.font = [UIFont fontWithName:@"System Italic" size:10];
    self.radialView2.label.textColor = [UIColor whiteColor];
    self.radialView2.label.text = [[NSString alloc]initWithFormat:@"已完成\n %@%%", self.radialView2.label.text];
//	radialView2.label.hidden = YES;
    
    

	[self.view addSubview:self.radialView2];
}

- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
	MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
    
	// Only required in this demo to align vertically the progress views.
	view.center = CGPointMake(self.view.center.x + 80, view.center.y);
	
	return view;
}

-(void)_histroystepDataReceived:(NSNotification *)notification
{
    NSData *revData = [myblecontroller historystepdata];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    
    //解析数据
    if([revData length] == 18){
        int timeinterval = byte[5]*256*256*256 + byte[4]*256*256 + byte[3]*256 + byte[2];
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:timeinterval];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *mydateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [mydateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [mydateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        
//        NSString *currentDateStr = [mydateFormatter stringFromDate:date];
        
//        NSString *str = [[NSString alloc]initWithFormat:@"UTC_TIME:%@  ",currentDateStr];
        
        int sporttimeinterval = byte[9]*256*256*256 + byte[8]*256*256 + byte[7]*256 + byte[6];
//        int sportmin = sporttimeinterval%60;
        
//        NSString *sporttimestr = [[NSString alloc]initWithFormat:@"sporttime(min):%d  ",sportmin];
        
        //获取用户信息
//        int height = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
        double weight = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"] doubleValue];
        int steplength = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
        
        int stepnum = byte[13]*256*256*256 + byte[12]*256*256 + byte[11]*256 + byte[10];
        int stepnumo2 = byte[17]*256*256*256 + byte[16]*256*256 + byte[15]*256 + byte[14];
        
        //跑步热量（kcal）＝体重（kg）× 距离（公里）× 1.036
        double distance = stepnum * steplength/100000.0f;
        double kcal =  weight * distance * 1.036f;
        double distanceo2 = stepnumo2 * steplength/100000.0f;
        double kcalo2 = weight * distanceo2 * 1.036f;
        
//        NSString *stepnumstr = [[NSString alloc]initWithFormat:@"step:%d  stepo2:%d  ",stepnum,stepnumo2];
        
        [self insertDBStepData:date sporttimesec:sporttimeinterval stepnum:stepnum distance:distance kcal:kcal stepnumo2:stepnumo2 distanceo2:distanceo2 kcalo2:kcalo2];
    }
}

-(void)insertDBStepData:(NSDate *)date sporttimesec:(int)sporttime stepnum:(int)stepnum distance:(double)distance kcal:(double)kcal stepnumo2:(int)stepnumo2 distanceo2:(double)distanceo2 kcalo2:(double)kcalo2
{
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSArray *array = [database getPedometerDataByUserName:username begintime:date endtime:date];
    
    if([array count]==0)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [dateFormatter stringFromDate:date];
        NSString *issendstr = @"N";
        NSString *sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'PEDOMETERDATA' ('USERNAME','SPORTTIME','STEPNUM', 'DISTANCE', 'KCAL','STEPNUMO2', 'DISTANCEO2', 'KCALO2', 'TESTTIME', 'ISSEND') VALUES ('%@','%d','%d','%f','%f','%d','%f','%f','%@','%@')", username, sporttime, stepnum, distance, kcal, stepnumo2, distanceo2, kcalo2, strDate ,issendstr];
        
        [database insert:sql];
    }
}

-(void)insertDBSleepData:(NSDate *)begindate enddate:(NSDate *)enddate sleepdata:(NSString *)sleepdata
{
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSArray *array = [database getPedometerDataByUserName:username begintime:begindate endtime:enddate];
    
    if([array count]==0)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strbeginDate = [dateFormatter stringFromDate:begindate];
        NSString *strendDate = [dateFormatter stringFromDate:enddate];
        NSString *issendstr = @"N";
        NSString *sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'SLEEPDATA' ('USERNAME','BEGINTIME','ENDTIME', 'SLEEPDATA', 'ISSEND') VALUES ('%@','%@','%@','%@','%@')",username, strbeginDate, strendDate ,sleepdata,issendstr];
        
        [database insert:sql];
    }
}


-(void)_deviceinfoDataReceived:(NSNotification *)notification
{
    NSData *revData = [myblecontroller deviceinfodata];
    NSLog(@"%@",revData);
//    Byte *byte = (Byte *)[revData bytes];
}


-(void)_sleepmonitorDataReceived:(NSNotification *)notification
{
    NSData *revData = [myblecontroller sleepmonitordata];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    
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
                
//                NSString *beginDateStr = [mydateFormatter stringFromDate:begindate];
//                NSString *endDateStr = [mydateFormatter stringFromDate:enddate];
                
//                NSString *str = [[NSString alloc]initWithFormat:@"UTC_TIMEbegin:%@  end:%@", beginDateStr, endDateStr];
//                [self.dataMutableString appendFormat:@"%@  \r\n",str];
                
                
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
                        
//                        [self.dataMutableString appendFormat:@"%d|%d|%d  ",statueint,hourint,minint];
                        
                        [self.oneSleepMonitorDataMutableArray addObject:pieceSleepData];
                    }
                    else
                    {
//                        [self.dataMutableString appendString:@"N  "];
                    }
                }
//                [self.dataMutableString appendString:@"\r\n"];
            }
            else{
                
                for(int k = 2;k<[revData length];k+=2)
                {
                    int hourint = byte[k];
                    int minint = byte[k+1]%64;
                    int statueint = byte[k+1]>>6;
                    if(statueint != 0){
//                        NSMutableDictionary *pieceSleepData = [[NSMutableDictionary alloc]init];
//                        [pieceSleepData setValue:[[NSString alloc] initWithFormat:@"%d",hourint] forKey:@"hour"];
//                        [pieceSleepData setValue:[[NSString alloc] initWithFormat:@"%d",minint] forKey:@"min"];
//                        [pieceSleepData setValue:[[NSString alloc] initWithFormat:@"%d",statueint] forKey:@"status"];
                        int totalmin = minint + hourint*60;
                        NSString *pieceSleepData = [[NSString alloc] initWithFormat:@"%d:%d",statueint,totalmin];
//                        [self.dataMutableString appendFormat:@"%d|%d|%d  ",statueint,hourint,minint];
                        
                        [self.oneSleepMonitorDataMutableArray addObject:pieceSleepData];
                    }
                    else
                    {
//                        [self.dataMutableString appendString:@"N  "];
                    }
                }
//                [self.dataMutableString appendString:@"\r\n"];
            }
            
            if(byte[0]%16 == 5)  //收到最后一段
            {
                [self.onedataMutableDictionary setValue:self.oneSleepMonitorDataMutableArray forKey:@"sleepmonitordata"];
                self.oneSleepMonitorDataMutableArray = [[NSMutableArray alloc]init];
                
                [self.totalSleepMonitorDataMutableArray addObject:self.onedataMutableDictionary];
                
                
                //存入数据库
                NSDate *begintime = [self.onedataMutableDictionary valueForKey:@"begintime"];
                NSDate *endtime = [self.onedataMutableDictionary valueForKey:@"endtime"];
                NSString *sleepData = [self.oneSleepMonitorDataMutableArray componentsJoinedByString:@" "];
                
                [self insertDBSleepData:begintime enddate:endtime sleepdata:sleepData];
            }
        }
    }
}

-(void)_batterylvlDataReceived:(NSNotification *)notification
{
    NSData *revData = [myblecontroller batterydata];
    NSLog(@"%@",revData);
    Byte *byte = (Byte *)[revData bytes];
    self.batterylvl = byte[0];
    
    //更新设备时间
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
    
    
    //设置用户信息
    double weight = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"] doubleValue];
    Byte bt1 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
    Byte bt2 = ((int)(weight*10))%256;
    Byte bt3 = ((int)(weight*10))/256;
    Byte bt4 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
    Byte sendbyte1[] = {bt1, bt2, bt3, bt4};
    NSData *data1 = [[NSData alloc]initWithBytes:sendbyte1 length:sizeof(sendbyte1)];
    [[MySingleton sharedSingleton].myblecontroller setUserInfo:data1];
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

-(void)showstepdata
{
    stepdataLabel.text = [[NSString alloc]initWithFormat:@"%d", stepdata];
    step_o_Label.hidden = YES;
    step_2_Label.hidden = YES;
}

-(void)showstepo2data
{
    stepdataLabel.text = [[NSString alloc]initWithFormat:@"%d", stepo2data];
    step_o_Label.hidden = NO;
    step_2_Label.hidden = NO;
}

-(void)showdistancedata
{
    distanceDataLabel.text = [[NSString alloc]initWithFormat:@"%.2f", distancedata];
    distance_o_Label.hidden = YES;
    distance_2_Label.hidden = YES;
}

-(void)showdistanceo2data
{
    distanceDataLabel.text = [[NSString alloc]initWithFormat:@"%.2f", distanceo2data];
    distance_o_Label.hidden = NO;
    distance_2_Label.hidden = NO;
}

-(void)showkcaldata
{
    kcalDataLabel.text = [[NSString alloc]initWithFormat:@"%.2f", kcaldata];
    kcal_o_Label.hidden = YES;
    kcal_2_Label.hidden = YES;
}

-(void)showkcalo2data
{
    kcalDataLabel.text = [[NSString alloc]initWithFormat:@"%.2f", kcalo2data];
    kcal_o_Label.hidden = NO;
    kcal_2_Label.hidden = NO;
}

-(IBAction)stepSwitchPressed:(id)sender
{
    if(stepSwitch.isOn){
        [self showstepdata];
    }
    else{
        [self showstepo2data];
    }
}

-(IBAction)distanceSwitchPressed:(id)sender
{
    if(distanceSwitch.isOn){
        [self showdistancedata];
    }
    else{
        [self showdistanceo2data];
    }
}

-(IBAction)kcalSwitchPressed:(id)sender
{
    if(kcalSwitch.isOn){
        [self showkcaldata];
    }
    else{
        [self showkcalo2data];
    }
}

-(void)initMyView
{
    stepLabel.text = NSLocalizedString(@"STEP", nil);
    distanceLabel.text = NSLocalizedString(@"DISTANCE", nil);
    kcalLabel.text = NSLocalizedString(@"CALORIE", nil);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    testtimeLabel.text = [[NSString alloc]initWithFormat:@"%@",strDate];
    
//    stepSwitch = [UISwitch switchWithLeftText:@"有氧" andRight:@"总共"];
//    UISwitch *mydistanceSwitch = [UISwitch switchWithLeftText:@"有氧" andRight:@"总共"];
//    kcalSwitch = [UISwitch switchWithLeftText:@"有氧" andRight:@"总共"];
    
//    [self.view addSubview:stepSwitch];
//    CGRect frame = CGRectMake(150, 150, 300, 50);
//    mydistanceSwitch.frame = frame;
//    [self.view addSubview:mydistanceSwitch];
    
    [self setProgress:10000 havegot:0];
}

-(IBAction)backBtnPressed:(id)sender
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}

-(void)setTimeForDevice
{
    int timeinterval = [NSDate timeIntervalSinceReferenceDate];
    NSData *data = [NSData dataWithBytes: &timeinterval length: sizeof(timeinterval)];
    [myblecontroller setCurrentTime:data];
}


-(void)initApp
{
    [MySingleton sharedSingleton].nowuserinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                 [[NSString alloc] initWithFormat:@"1"],@"Userid",
                                                 [[NSString alloc] initWithFormat:@"1"],@"UserNumber",
                                                 [[NSString alloc] initWithFormat:@"guest"],@"UserName",
                                                 [[NSString alloc] initWithFormat:@""],@"PassWord",
                                                 [[NSString alloc] initWithFormat:@"70.0"],@"Weight",
                                                 [[NSString alloc] initWithFormat:@""],@"Birthday",
                                                 [[NSString alloc] initWithFormat:@"0"],@"Gender",
                                                 [[NSString alloc] initWithFormat:@"175"],@"Height",
                                                 [[NSString alloc] initWithFormat:@"1"],@"Profesion",
                                                 [[NSString alloc] initWithFormat:@""],@"AuthKey",
                                                 [[NSString alloc] initWithFormat:@"25"],@"Age",
                                                 [[NSString alloc] initWithFormat:@"70"],@"StepSize",
                                                 [[NSString alloc] initWithFormat:@"30000"],@"TargetStepNumber",
                                                 nil];
    
//    NSString *sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'PEDOMETERDATA' ('USERNAME','SPORTTIME','STEP', 'DISTANCE', 'KCAL','STEPO2', 'DISTANCEO2', 'KCALO2', 'TESTTIME', 'ISSEND') VALUES ('%@','%d','%d','%f','%f','%d','%f','%f','%@','%@')", username, sporttime, stepnum, distance, kcal, stepnumo2, distanceo2, kcalo2, strDate ,issendstr];
    
    //创建用户表 用户id，用户名，生日，性别(0男,1女)，运动级别(1白领，2普通，3运动员),身高（cm），体重(kg)，步幅(cm)，密码，
//    NSString *sqlCreateUserTable = @"CREATE TABLE IF NOT EXISTS USER(USERID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, BRITHDAY TIMESTAMP, AGE INTEGER, SEX INTEGER, SPORTLVL INTEGER, HEIGHT INTEGER, WEIGHT FLOAT, STEPLENGTH INTEGER, PASSWORD TEXT)";
    
    //创建健康目标数据表 数据id，用户id，用户名，睡眠开始时间，睡眠结束时间，睡眠数据(min)，是否上传
//    NSString *sqlCreateTargetTable = @"CREATE TABLE IF NOT EXISTS TARGET(DATAID INTEGER PRIMARY KEY AUTOINCREMENT, USERID INTEGER, USERNAME TEXT,STEPNUM INTEGER, STEPNUMO2 INTEGER, KCAL FLOAT, KCALO2 FLOAT, DISTANCE FLOAT, DISTANCEO2 FLOAT, WEIGHT FLOAT,SPORTTIME INTEGER, ISSEND TEXT)";
    NSDictionary *dic = [database selectUserByName:@"guest"];
    if(dic == nil)
    {
        NSString *sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'USER' ('USERNAME','AGE','SEX', 'SPORTLVL', 'HEIGHT','WEIGHT', 'STEPLENGTH', 'PASSWORD') VALUES ('%@','%d','%d','%d','%d','%f','%d','%@')", @"guest", 20, 0, 1, 175, 70.0, 70, @""];
        NSString *sqltarget = [[NSString alloc]initWithFormat:@"INSERT INTO 'TARGET' ('USERNAME','STEPNUM','STEPNUMO2', 'KCAL', 'KCALO2','DISTANCE', 'DISTANCEO2', 'WEIGHT', 'SPORTTIME') VALUES ('%@','%d','%d','%f','%f','%f','%f','%f','%d')", @"guest", 10000, 5000, 65.8, 34.9, 5.9, 3.8, 63.0, 80];
        [database insert:sql];
        [database insert:sqltarget];
    }
    NSLog(@"MySingleton AuthKey = %@", [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"AuthKey"]);
}



//myjoytest
-(IBAction)buttonpressed:(id)sender
{
    [self setProgress:100 havegot:30];
    [self enumerateFonts];
}

-(IBAction)button2pressed:(id)sender
{
    [self.radialView2 removeFromSuperview];
}

- (void) enumerateFonts{
    for (NSString *familyName in [UIFont familyNames])
    {
        NSLog(@"Font Family = %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName])
        {
            NSLog(@"\t%@", fontName);
        }
    }
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    self.radialView2.label.font = helveticaBold;
    NSString *myString = @"Some String";
    [myString drawAtPoint:CGPointMake(40, 180) withFont:helveticaBold];
}
@end
