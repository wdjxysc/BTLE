//
//  TestSleepMonitorViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSleepMonitorViewController : UIViewController
{
    IBOutlet UILabel *dataSleepMonitorLabel;
}

@property(nonatomic,retain)NSMutableString *dataMutableString;
@property(nonatomic,retain)NSMutableDictionary *onedataMutableDictionary;     //一条睡眠数据字典 包括 begintime endtime 及sleepmonitordata
@property(nonatomic,retain)NSMutableArray *oneSleepMonitorDataMutableArray;   //一条睡眠数据队列 包含 piece Dictionary
@property(nonatomic,retain)NSMutableArray *totalSleepMonitorDataMutableArray; //所有上传睡眠数据队列 包含若干 onedataMutableDictionary


-(IBAction)backBtnPressed:(id)sender;

@end
