//
//  TestRootViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestRootViewController : UIViewController
{
    IBOutlet UIButton *sleepMonitorBtn;
    IBOutlet UIButton *historyStepBtn;
    IBOutlet UIButton *reminderBtn;
}


-(IBAction)showSleepMonitorView:(id)sender;
-(IBAction)showHistoryStepView:(id)sender;
-(IBAction)showRemindView:(id)sender;
@end
