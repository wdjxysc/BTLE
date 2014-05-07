//
//  CallRemindViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallRemindViewController : UIViewController
{
    IBOutlet UISwitch *mySwitch;
    IBOutlet UILabel *callLabel;
}

@property(retain,nonatomic) UISwitch *mySwitch;
@property(retain,nonatomic) UILabel *callLabel;

@end
