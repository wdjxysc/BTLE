//
//  HistoryStepViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "HistoryStepViewController.h"
#import "database.h"
#import "MySingleton.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"
#import "SleepChartView.h"
#import "SleepDataView.h"

@interface HistoryStepViewController ()

@end

@implementation HistoryStepViewController
@synthesize sleepDataView;
@synthesize sleepTimeLabel;
@synthesize sleepTimeDataHLabel;
@synthesize sleepTimeDataMLabel;
@synthesize lightSleepTimeLabel;
@synthesize lightSleepTimeDataHLabel;
@synthesize lightSleepTimeDataMLabel;
@synthesize deepSleepTimeLabel;
@synthesize deepSleepTimeDataHLabel;
@synthesize deepSleepTimeDataMLabel;
@synthesize inBedTimeLabel;
@synthesize inBedTimeDataHLabel;
@synthesize inBedTimeDataMLabel;
@synthesize awakeTimeLabel;
@synthesize awakeTimeDataHLabel;
@synthesize awakeTimeDataMLabel;

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
    [self stepBtnPressed:self];
    [self initMyView];
}

-(void)initMyView
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        self.testStepBtn = [[UIButton alloc]init];
        [self.testStepBtn setFrame:CGRectMake(0, 20, 80, 65)];
        [self.testStepBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testStepBtn setBackgroundImage:[UIImage imageNamed: @"计步_btn"] forState:UIControlStateNormal];
        [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testStepBtn addTarget:self action:@selector(stepBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testStepBtn];
        
        self.testKcalBtn = [[UIButton alloc]init];
        [self.testKcalBtn setFrame:CGRectMake(80, 20, 80, 65)];
        [self.testKcalBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testKcalBtn setBackgroundImage:[UIImage imageNamed: @"卡路里_btn"] forState:UIControlStateNormal];
        [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testKcalBtn addTarget:self action:@selector(kcalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testKcalBtn];
        
        self.testDistanceBtn = [[UIButton alloc]init];
        [self.testDistanceBtn setFrame:CGRectMake(160, 20, 80, 65)];
        [self.testDistanceBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed: @"路程_btn"] forState:UIControlStateNormal];
        [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testDistanceBtn addTarget:self action:@selector(distanceBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testDistanceBtn];
        
        self.testSleepBtn = [[UIButton alloc]init];
        [self.testSleepBtn setFrame:CGRectMake(240, 20, 80, 65)];
        [self.testSleepBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testSleepBtn setBackgroundImage:[UIImage imageNamed: @"睡眠_btn"] forState:UIControlStateNormal];
        [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testSleepBtn addTarget:self action:@selector(sleepBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testSleepBtn];
    }
    else{
        self.testStepBtn = [[UIButton alloc]init];
        [self.testStepBtn setFrame:CGRectMake(0, 0, 80, 65)];
        [self.testStepBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testStepBtn setBackgroundImage:[UIImage imageNamed: @"计步_btn"] forState:UIControlStateNormal];
        [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testStepBtn addTarget:self action:@selector(stepBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testStepBtn];
        
        self.testKcalBtn = [[UIButton alloc]init];
        [self.testKcalBtn setFrame:CGRectMake(80, 0, 80, 65)];
        [self.testKcalBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testKcalBtn setBackgroundImage:[UIImage imageNamed: @"卡路里_btn"] forState:UIControlStateNormal];
        [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testKcalBtn addTarget:self action:@selector(kcalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testKcalBtn];
        
        self.testDistanceBtn = [[UIButton alloc]init];
        [self.testDistanceBtn setFrame:CGRectMake(160, 0, 80, 65)];
        [self.testDistanceBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed: @"路程_btn"] forState:UIControlStateNormal];
        [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testDistanceBtn addTarget:self action:@selector(distanceBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testDistanceBtn];
        
        self.testSleepBtn = [[UIButton alloc]init];
        [self.testSleepBtn setFrame:CGRectMake(240, 0, 80, 65)];
        [self.testSleepBtn setTitle:@"" forState:UIControlStateNormal];
        [self.testSleepBtn setBackgroundImage:[UIImage imageNamed: @"睡眠_btn"] forState:UIControlStateNormal];
        [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
        [self.testSleepBtn addTarget:self action:@selector(sleepBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.testSleepBtn];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)stepBtnPressed:(id)sender
{
    [self showStepChart];
    
    [self.sleepDataView setHidden:YES];
    
    [self.testStepBtn setBackgroundImage:[UIImage imageNamed:@"计步选中_btn"] forState:UIControlStateNormal];
    [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:214/256.0f green:229/256.0f blue:222/256.0f alpha:1.0]];
    [self.testKcalBtn setBackgroundImage:[UIImage imageNamed:@"卡路里_btn"] forState:UIControlStateNormal];
    [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed:@"路程_btn"] forState:UIControlStateNormal];
    [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testSleepBtn setBackgroundImage:[UIImage imageNamed:@"睡眠_btn"] forState:UIControlStateNormal];
    [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
}

-(IBAction)distanceBtnPressed:(id)sender
{
    [self showDistanceChart];
    
    [self.sleepDataView setHidden:YES];
    
    [self.testStepBtn setBackgroundImage:[UIImage imageNamed:@"计步_btn"] forState:UIControlStateNormal];
    [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testKcalBtn setBackgroundImage:[UIImage imageNamed:@"卡路里_btn"] forState:UIControlStateNormal];
    [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed:@"路程选中_btn"] forState:UIControlStateNormal];
    [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:214/256.0f green:229/256.0f blue:222/256.0f alpha:1.0]];
    [self.testSleepBtn setBackgroundImage:[UIImage imageNamed:@"睡眠_btn"] forState:UIControlStateNormal];
    [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
}

-(IBAction)kcalBtnPressed:(id)sender
{
    [self showKcalChart];
    
    [self.sleepDataView setHidden:YES];
    
    [self.testStepBtn setBackgroundImage:[UIImage imageNamed:@"计步_btn"] forState:UIControlStateNormal];
    [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testKcalBtn setBackgroundImage:[UIImage imageNamed:@"卡路里选中_btn"] forState:UIControlStateNormal];
    [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:214/256.0f green:229/256.0f blue:222/256.0f alpha:1.0]];
    [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed:@"路程_btn"] forState:UIControlStateNormal];
    [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testSleepBtn setBackgroundImage:[UIImage imageNamed:@"睡眠_btn"] forState:UIControlStateNormal];
    [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
}

-(IBAction)sleepBtnPressed:(id)sender
{
    [self showSleepChart];
    
    [self.sleepDataView setHidden:NO];
    
    [self.testStepBtn setBackgroundImage:[UIImage imageNamed:@"计步_btn"] forState:UIControlStateNormal];
    [self.testStepBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testKcalBtn setBackgroundImage:[UIImage imageNamed:@"卡路里_btn"] forState:UIControlStateNormal];
    [self.testKcalBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testDistanceBtn setBackgroundImage:[UIImage imageNamed:@"路程_btn"] forState:UIControlStateNormal];
    [self.testDistanceBtn setBackgroundColor:[UIColor colorWithRed:119/256.0f green:172/256.0f blue:149/256.0f alpha:1.0]];
    [self.testSleepBtn setBackgroundImage:[UIImage imageNamed:@"睡眠选中_btn"] forState:UIControlStateNormal];
    [self.testSleepBtn setBackgroundColor:[UIColor colorWithRed:214/256.0f green:229/256.0f blue:222/256.0f alpha:1.0]];
}

-(void)showSleepChart
{
    NSDate *date1 = [[NSDate date] dateByAddingDays:(-6)];
    NSDate *date2 = [[NSDate date] dateByAddingDays:1];
    NSArray *sleepDataArray = [database getSleepDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
    
    NSDate *beginTime = [NSDate date];
    NSDate *endTime = [NSDate date];
    NSString *sleepdatastr = @"";
    
    if(sleepDataArray.count !=0){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        beginTime = [formatter dateFromString:[sleepDataArray[0] valueForKey:@"BeginTime"]];
        endTime = [formatter dateFromString:[sleepDataArray[0] valueForKey:@"EndTime"]];
        sleepdatastr = [sleepDataArray[0] valueForKey:@"SleepData"];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NOTICE", Nil) message:@"最近一周没有睡眠记录" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", Nil) otherButtonTitles:nil, nil];
        [alertView show];
    }
    NSArray *mySleepDataArray = [sleepdatastr componentsSeparatedByString:@" "];
    
//    mySleepDataArray = @[@"2:360",@"1:256",@"3:946"];
//    beginTime = [NSDate date];
//    endTime =[[NSDate date] dateByAddingDays:1];
    
    SleepChartView *sleepChartView = [[SleepChartView alloc]initWithFrame:CGRectMake(6, 90, 308, 175) data:mySleepDataArray begintime:beginTime endtime:endTime];
    [self.view addSubview:sleepChartView];
    
    [self.sleepDataView setHidden:NO];
    int sleepTime = 0,lightSleepTime = 0,deepSleepTime = 0,inBedTime = 0,awakeTime = 0;
    if(mySleepDataArray.count!=0)
    {
        for (int i = 0; i<mySleepDataArray.count; i++) {
            
            if([mySleepDataArray[i] isEqualToString:@""])
            {
                continue;
            }
            
            
            NSArray *onedata = [mySleepDataArray[i] componentsSeparatedByString:@":"];
            int status = [onedata[0] intValue];
            int min = [onedata[1] intValue];
            if(status == 1)
            {
                awakeTime += min;
            }
            else if(status == 2)
            {
                sleepTime += min;
                lightSleepTime += min;
            }
            else if(status == 3)
            {
                sleepTime += min;
                deepSleepTime += min;
            }
            
            inBedTime += min;
        }
    }
    
    self.sleepTimeDataHLabel.text = [[NSString alloc]initWithFormat:@"%d",sleepTime/60];
    self.sleepTimeDataMLabel.text = [[NSString alloc]initWithFormat:@"%d",sleepTime%60];
    self.lightSleepTimeDataHLabel.text = [[NSString alloc]initWithFormat:@"%d",lightSleepTime/60];
    self.lightSleepTimeDataMLabel.text = [[NSString alloc]initWithFormat:@"%d",lightSleepTime%60];
    self.deepSleepTimeDataHLabel.text = [[NSString alloc]initWithFormat:@"%d",deepSleepTime/60];
    self.deepSleepTimeDataMLabel.text = [[NSString alloc]initWithFormat:@"%d",deepSleepTime%60];
    self.inBedTimeDataHLabel.text = [[NSString alloc]initWithFormat:@"%d",inBedTime/60];
    self.inBedTimeDataMLabel.text = [[NSString alloc]initWithFormat:@"%d",inBedTime%60];
    self.awakeTimeDataHLabel.text = [[NSString alloc]initWithFormat:@"%d",awakeTime/60];
    self.awakeTimeDataMLabel.text = [[NSString alloc]initWithFormat:@"%d",awakeTime%60];
}


-(void)showStepChart
{
    [myChartView removeFromSuperview];
    LineChartData *stepline = [self getLine:@"Step" title:NSLocalizedString(@"USER_STEP", nil) linecolor:[UIColor greenColor]];
    LineChartData *stepo2line = [self getLine:@"Stepo2" title:NSLocalizedString(@"USER_STEPO2", nil) linecolor:[UIColor blueColor]];
    myChartView = [[LineChartView alloc] initWithFrame:CGRectMake(6, 90, 308, 175)];
    myChartView.yMin = 0;
    myChartView.yMax = 30000;
    myChartView.ySteps = @[@"0",@"5000",@"10000",@"15000",@"20000",@"25000",@"30000"];
    myChartView.data = @[stepline,stepo2line];
    [self.view addSubview:myChartView];
    
}

-(void)showDistanceChart
{
    [myChartView removeFromSuperview];
    LineChartData *distanceline = [self getLine:@"Distance" title:NSLocalizedString(@"USER_DISTANCE", nil) linecolor:[UIColor greenColor]];
    LineChartData *distanceo2line = [self getLine:@"Distanceo2" title:NSLocalizedString(@"USER_DISTANCEO2", nil) linecolor:[UIColor blueColor]];
    myChartView = [[LineChartView alloc] initWithFrame:CGRectMake(6, 90, 308, 175)];
    myChartView.yMin = 0;
    myChartView.yMax = 10;
    myChartView.ySteps = @[@"(km)0",@"2",@"4",@"6",@"8",@"10"];
    myChartView.data = @[distanceline,distanceo2line];
    [self.view addSubview:myChartView];
}

-(void)showKcalChart
{
    [myChartView removeFromSuperview];
    LineChartData *kcalline = [self getLine:@"Kcal" title:NSLocalizedString(@"USER_KCAL", nil) linecolor:[UIColor greenColor]];
    LineChartData *kcalo2line = [self getLine:@"Kcalo2" title:NSLocalizedString(@"USER_KCALO2", nil) linecolor:[UIColor blueColor]];
    myChartView = [[LineChartView alloc] initWithFrame:CGRectMake(6, 90, 308, 175)];
    myChartView.yMin = 0;
    myChartView.yMax = 1000;
    myChartView.ySteps = @[@"(kcal)0",@"200",@"400",@"600",@"800",@"1000"];
    myChartView.data = @[kcalline,kcalo2line];
    [self.view addSubview:myChartView];
}


-(LineChartData *)getLine:(NSString *)dataname title:(NSString *)title linecolor:(UIColor *)linecolor
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    LineChartData *data = [LineChartData new];
    {
        LineChartData *d1 = data;
        NSDate *date1 = [[NSDate date] dateByAddingDays:(-6)];
        NSDate *date2 = [[NSDate date] dateByAddingDays:1];
        
        NSMutableArray *dataarray = [database getPedometerDataByUserName:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] begintime:date1 endtime:date2];
        
        self.stepDatas = dataarray;
        
        d1.xMin = [date1 timeIntervalSinceReferenceDate];
        d1.xMax = [date2 timeIntervalSinceReferenceDate];
        d1.title = title;
        d1.color = linecolor;
        d1.itemCount = [dataarray count];
        NSMutableArray *arr = [NSMutableArray array];
        
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            NSDate *testtime = [formatter dateFromString:[dataarray[i] valueForKey:@"TestTime"]];
            long item = [testtime timeIntervalSinceReferenceDate];
            [arr addObject:@(item)];
            //            [arr addObject:@(d1.xMin + (rand() / (float)RAND_MAX) * (d1.xMax - d1.xMin))];
        }
        //        [arr addObject:@(d1.xMin)];
        //        [arr addObject:@(d1.xMax)];
        //        [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //            return [obj1 compare:obj2];
        //        }];
        
        NSMutableArray *arr2 = [NSMutableArray array];
        for(NSUInteger i = 0; i < d1.itemCount; ++i) {
            float y = [[dataarray[i] valueForKey:dataname] floatValue];
            [arr2 addObject:@(y)];
            //            [arr2 addObject:@((rand() / (float)RAND_MAX) * 6)];
        }
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            
            NSString *label1 = [formatter stringFromDate:[formatter dateFromString:[dataarray[item] valueForKey:@"TestTime"]]];
            NSString *label2 = [NSString stringWithFormat:@"%.0f", y];
            if([dataname isEqualToString:@"Step"]||[dataname isEqualToString:@"Stepo2"]){
                label2 = [NSString stringWithFormat:@"%.0f", y];
            }
            else if ([dataname isEqualToString:@"Distance"]||[dataname isEqualToString:@"Distanceo2"])
            {
                label2 = [NSString stringWithFormat:@"%.2f", y];
            }
            else if ([dataname isEqualToString:@"Kcal"]||[dataname isEqualToString:@"Kcalo2"])
            {
                label2 = [NSString stringWithFormat:@"%.2f", y];
            }
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
        };
        
    }
    
    return data;
}


@end
