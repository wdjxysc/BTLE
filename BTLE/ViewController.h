//
//  ViewController.h
//  BTLE
//
//  Created by 夏 伟 on 13-12-27.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "UISwitch+Text.h"
#import "MDRadialProgressView.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel *testtimeLabel;
    IBOutlet UILabel *stepdataLabel;
    IBOutlet UILabel *stepo2dataLabel;
    IBOutlet UILabel *distanceDataLabel;
    IBOutlet UILabel *kcalDataLabel;
    IBOutlet UISwitch *stepSwitch;
    IBOutlet UISwitch *distanceSwitch;
    IBOutlet UISwitch *kcalSwitch;
    
    IBOutlet UILabel *kcalLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *stepLabel;
    
    IBOutlet UILabel *step_o_Label;
    IBOutlet UILabel *step_2_Label;
    IBOutlet UILabel *distance_o_Label;
    IBOutlet UILabel *distance_2_Label;
    IBOutlet UILabel *kcal_o_Label;
    IBOutlet UILabel *kcal_2_Label;
}

@property(retain,nonatomic)UILabel *testtimeLabel;
@property(retain,nonatomic)UILabel *stepdataLabel;
@property(retain,nonatomic)UILabel *stepo2dataLabel;
@property(retain,nonatomic)UILabel *distanceDataLabel;
@property(retain,nonatomic)UILabel *kcalDataLabel;

@property(retain,nonatomic)MDRadialProgressView *radialView2;

//当前计步器电量
@property(nonatomic)int batterylvl;

//当前计步数据
@property(nonatomic)int stepdata;
@property(nonatomic)double distancedata;
@property(nonatomic)double kcaldata;
@property(nonatomic)int stepo2data;
@property(nonatomic)double distanceo2data;
@property(nonatomic)double kcalo2data;

//睡眠监控数据
@property(nonatomic,retain)NSMutableDictionary *onedataMutableDictionary;     //一条睡眠数据字典 包括 begintime endtime 及sleepmonitordata
@property(nonatomic,retain)NSMutableArray *oneSleepMonitorDataMutableArray;   //一条睡眠数据队列 包含 piece字典
@property(nonatomic,retain)NSMutableArray *totalSleepMonitorDataMutableArray; //所有上传睡眠数据队列 包含若干 onedataMutableDictionary

-(IBAction)backBtnPressed:(id)sender;
@end
