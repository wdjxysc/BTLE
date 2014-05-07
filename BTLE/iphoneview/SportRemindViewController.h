//
//  SportRemindViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportRemindViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UILabel *sportRemindLabel;
    IBOutlet UILabel *timeintervalLabel;
    IBOutlet UILabel *beginTimeLabel;
    IBOutlet UILabel *endTimeLabel;
    
    IBOutlet UISwitch *sportRemindSwitch;
    IBOutlet UITextField *beginTimeTextField;
    IBOutlet UITextField *endTimeTextField;
    IBOutlet UITextField *timeintervalTextField;
    
    IBOutlet UILabel *timeintervalUnitLabel;
}

@property (nonatomic,retain) UILabel *sportRemindLabel;
@property (nonatomic,retain) UILabel *timeintervalLabel;
@property (nonatomic,retain) UILabel *beginTimeLabel;
@property (nonatomic,retain) UILabel *endTimeLabel;

@property (nonatomic,retain) UISwitch *sportRemindSwitch;
@property (nonatomic,retain) UITextField *beginTimeTextField;
@property (nonatomic,retain) UITextField *endTimeTextField;
@property (nonatomic,retain) UITextField *timeintervalTextField;
@property (nonatomic,retain) UILabel *timeintervalUnitLabel;

@property(nonatomic,retain)UIPickerView *timePickerView;
@property(nonatomic,retain)UIPickerView *intervaltimePickerView;

@property(nonatomic)int pickerhour;
@property(nonatomic)int pickermin;
@end
