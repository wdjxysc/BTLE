//
//  TestHistoryStepViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestHistoryStepViewController : UIViewController
{
    IBOutlet UILabel *dataHistoryStepLabel;
}

@property(nonatomic,retain)NSMutableString *dataString;

-(IBAction)backBtnPressed:(id)sender;
-(IBAction)updateTimeBtnPressed:(id)sender;
-(IBAction)setUserInfo:(id)sender;

@end
