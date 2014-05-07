//
//  SleepDataView.h
//  BTLE
//
//  Created by 夏 伟 on 14-3-6.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepDataView : UIView
{
    
}
@property(nonatomic,retain)UIImageView *lightSleepImageView;
@property(nonatomic,retain)UIImageView *deepSleepImageView;
@property(nonatomic,retain)UIImageView *fallSleepImageView;
@property(nonatomic,retain)UIImageView *inBedImageView;
@property(nonatomic,retain)UIImageView *awakeImageView;
@property(nonatomic,retain)UIImageView *wokeupImageView;

@property(nonatomic,retain)UILabel *sleepTimeLabel;
@property(nonatomic,retain)UILabel *sleepTimeDataLabel;
@property(nonatomic,retain)UILabel *lightSleepTimeLabel;
@property(nonatomic,retain)UILabel *lightSleepTimeDataLabel;
@property(nonatomic,retain)UILabel *deepSleepTimeLabel;
@property(nonatomic,retain)UILabel *deepSleepTimeDataLabel;
@property(nonatomic,retain)UILabel *fallSleepTimeLabel;
@property(nonatomic,retain)UILabel *fallSleepTimeDataLabel;
@property(nonatomic,retain)UILabel *inBedTimeLabel;
@property(nonatomic,retain)UILabel *inBedTimeDataLabel;
@property(nonatomic,retain)UILabel *awakeTimeLabel;
@property(nonatomic,retain)UILabel *awakeTimeDataLabel;
@property(nonatomic,retain)UILabel *wokeupTimesLabel;
@property(nonatomic,retain)UILabel *wokeupTimesDataLabel;

@end
