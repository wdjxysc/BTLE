//
//  HistoryStepViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"

@interface HistoryStepViewController : UIViewController
{
    IBOutlet LineChartView *myChartView;
    
    IBOutlet UIButton *stepBtn;
    IBOutlet UIButton *kcalBtn;
    IBOutlet UIButton *distanceBtn;
    IBOutlet UIButton *sleepBtn;
    
    IBOutlet UIView *sleepDataView;
    IBOutlet UILabel *sleepTimeLabel;
    IBOutlet UILabel *sleepTimeDataHLabel;
    IBOutlet UILabel *sleepTimeDataMLabel;
    IBOutlet UILabel *lightSleepTimeLabel;
    IBOutlet UILabel *lightSleepTimeDataHLabel;
    IBOutlet UILabel *lightSleepTimeDataMLabel;
    IBOutlet UILabel *deepSleepTimeLabel;
    IBOutlet UILabel *deepSleepTimeDataHLabel;
    IBOutlet UILabel *deepSleepTimeDataMLabel;
    IBOutlet UILabel *inBedTimeLabel;
    IBOutlet UILabel *inBedTimeDataHLabel;
    IBOutlet UILabel *inBedTimeDataMLabel;
    IBOutlet UILabel *awakeTimeLabel;
    IBOutlet UILabel *awakeTimeDataHLabel;
    IBOutlet UILabel *awakeTimeDataMLabel;
}

@property(nonatomic,retain)NSMutableArray *stepDatas;
@property(nonatomic,retain)NSMutableArray *sleepDatas;
@property(nonatomic,retain)UIButton *testStepBtn;
@property(nonatomic,retain)UIButton *testKcalBtn;
@property(nonatomic,retain)UIButton *testDistanceBtn;
@property(nonatomic,retain)UIButton *testSleepBtn;

@property(nonatomic,retain)UIView *sleepDataView;

@property(nonatomic,retain) UILabel *sleepTimeLabel;
@property(nonatomic,retain) UILabel *sleepTimeDataHLabel;
@property(nonatomic,retain) UILabel *sleepTimeDataMLabel;
@property(nonatomic,retain) UILabel *lightSleepTimeLabel;
@property(nonatomic,retain) UILabel *lightSleepTimeDataHLabel;
@property(nonatomic,retain) UILabel *lightSleepTimeDataMLabel;
@property(nonatomic,retain) UILabel *deepSleepTimeLabel;
@property(nonatomic,retain) UILabel *deepSleepTimeDataHLabel;
@property(nonatomic,retain) UILabel *deepSleepTimeDataMLabel;
@property(nonatomic,retain) UILabel *inBedTimeLabel;
@property(nonatomic,retain) UILabel *inBedTimeDataHLabel;
@property(nonatomic,retain) UILabel *inBedTimeDataMLabel;
@property(nonatomic,retain) UILabel *awakeTimeLabel;
@property(nonatomic,retain) UILabel *awakeTimeDataHLabel;
@property(nonatomic,retain) UILabel *awakeTimeDataMLabel;
@end