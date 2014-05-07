//
//  AlarmRemindViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmRemindViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UILabel *alarmLabel1;
    IBOutlet UISwitch *alarmSwitch1;
    IBOutlet UILabel *remindTimeLabel1;
    IBOutlet UITextField *remindTimeTextField1;
    IBOutlet UIButton *everydayButton1;
    IBOutlet UIButton *sudayButton1;
    IBOutlet UIButton *modayButton1;
    IBOutlet UIButton *tudayButton1;
    IBOutlet UIButton *wedayButton1;
    IBOutlet UIButton *thdayButton1;
    IBOutlet UIButton *frdayButton1;
    IBOutlet UIButton *sadayButton1;
    
    
    IBOutlet UILabel *alarmLabel2;
    IBOutlet UISwitch *alarmSwitch2;
    IBOutlet UILabel *remindTimeLabel2;
    IBOutlet UITextField *remindTimeTextField2;
    IBOutlet UIButton *everydayButton2;
    IBOutlet UIButton *sudayButton2;
    IBOutlet UIButton *modayButton2;
    IBOutlet UIButton *tudayButton2;
    IBOutlet UIButton *wedayButton2;
    IBOutlet UIButton *thdayButton2;
    IBOutlet UIButton *frdayButton2;
    IBOutlet UIButton *sadayButton2;
}

@property(nonatomic,retain)UILabel *alarmLabel1;
@property(nonatomic,retain)UISwitch *alarmSwitch1;
@property(nonatomic,retain)UILabel *remindTimeLabel1;
@property(nonatomic,retain)UITextField *remindTimeTextField1;
@property(nonatomic,retain)UIButton *everydayButton1;
@property(nonatomic,retain)UIButton *sudayButton1;
@property(nonatomic,retain)UIButton *modayButton1;
@property(nonatomic,retain)UIButton *tudayButton1;
@property(nonatomic,retain)UIButton *wedayButton1;
@property(nonatomic,retain)UIButton *thdayButton1;
@property(nonatomic,retain)UIButton *frdayButton1;
@property(nonatomic,retain)UIButton *sadayButton1;

@property(nonatomic,retain)UILabel *alarmLabel2;
@property(nonatomic,retain)UISwitch *alarmSwitch2;
@property(nonatomic,retain)UILabel *remindTimeLabel2;
@property(nonatomic,retain)UITextField *remindTimeTextField2;
@property(nonatomic,retain)UIButton *everydayButton2;
@property(nonatomic,retain)UIButton *sudayButton2;
@property(nonatomic,retain)UIButton *modayButton2;
@property(nonatomic,retain)UIButton *tudayButton2;
@property(nonatomic,retain)UIButton *wedayButton2;
@property(nonatomic,retain)UIButton *thdayButton2;
@property(nonatomic,retain)UIButton *frdayButton2;
@property(nonatomic,retain)UIButton *sadayButton2;

@property(nonatomic,retain)UIPickerView *timePickerView;

@property(nonatomic)int pickerhour;
@property(nonatomic)int pickermin;
@end
