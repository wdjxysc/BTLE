//
//  SleepChartView.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-22.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepChartView : UIView
{
    
}
-(id)initWithFrame:(CGRect)frame data:(NSArray *)dataArray begintime:(NSDate *)begintime endtime:(NSDate *)endtime;
@property(retain,nonatomic)NSArray *mySleepDataArray;
@property(retain,nonatomic)NSDate *beginTime;
@property(retain,nonatomic)NSDate *endTime;
@property CGRect myFrame;
@end
