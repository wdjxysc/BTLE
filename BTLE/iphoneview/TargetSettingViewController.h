//
//  TargetSettingViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetSettingViewController : UIViewController
{
    IBOutlet UILabel *stepLabel;
    IBOutlet UITextField *stepDataTextField;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UITextField *distanceDataTextField;
    IBOutlet UILabel *timeLabel;
    IBOutlet UITextField *timeDataTextField;
    IBOutlet UILabel *kcalLabel;
    IBOutlet UITextField *kcalDataTextField;
    
    IBOutlet UINavigationBar *myStepNavigationBar;
    IBOutlet UINavigationItem *myStepNavigationItem;
    IBOutlet UIPickerView *myStepPickerView;
    
    IBOutlet UINavigationBar *myDistanceNavigationBar;
    IBOutlet UINavigationItem *myDistanceNavigationItem;
    IBOutlet UIPickerView *myDistancePickerView;
    
    IBOutlet UINavigationBar *myTimeNavigationBar;
    IBOutlet UINavigationItem *myTimeNavigationItem;
    IBOutlet UIPickerView *myTimePickerView;
    
    IBOutlet UINavigationBar *myKcalNavigationBar;
    IBOutlet UINavigationItem *myKcalNavigationItem;
    IBOutlet UIPickerView *myKcalPickerView;
}

@property(nonatomic,retain) UILabel *stepLabel;
@property(nonatomic,retain) UITextField *stepDataTextField;
@property(nonatomic,retain) UILabel *distanceLabel;
@property(nonatomic,retain) UITextField *distanceDataTextField;
@property(nonatomic,retain) UILabel *timeLabel;
@property(nonatomic,retain) UITextField *timeDataTextField;
@property(nonatomic,retain) UILabel *kcalLabel;
@property(nonatomic,retain) UITextField *kcalDataTextField;

@property(nonatomic,retain) UINavigationBar *myStepNavigationBar;
@property(nonatomic,retain) UINavigationItem *myStepNavigationItem;
@property(nonatomic,retain) UIPickerView *myStepPickerView;

@property(nonatomic,retain) UINavigationBar *myDistanceNavigationBar;
@property(nonatomic,retain) UINavigationItem *myDistanceNavigationItem;
@property(nonatomic,retain) UIPickerView *myDistancePickerView;

@property(nonatomic,retain) UINavigationBar *myTimeNavigationBar;
@property(nonatomic,retain) UINavigationItem *myTimeNavigationItem;
@property(nonatomic,retain) UIPickerView *myTimePickerView;

@property(nonatomic,retain) UINavigationBar *myKcalNavigationBar;
@property(nonatomic,retain) UINavigationItem *myKcalNavigationItem;
@property(nonatomic,retain) UIPickerView *myKcalPickerView;

@property(nonatomic) int pickerStepGe;
@property(nonatomic) int pickerStepShi;
@property(nonatomic) int pickerStepBai;
@property(nonatomic) int pickerStepQian;
@property(nonatomic) int pickerStepWan;
@property(nonatomic) int pickerStepShiWan;

@property(nonatomic) int pickerKcalGe;
@property(nonatomic) int pickerKcalShi;
@property(nonatomic) int pickerKcalBai;
@property(nonatomic) int pickerKcalXiao1;
@property(nonatomic) int pickerKcalXiao2;

@property(nonatomic) int pickerDistanceGe;
@property(nonatomic) int pickerDistanceShi;
@property(nonatomic) int pickerDistanceBai;
@property(nonatomic) int pickerDistanceXiao1;
@property(nonatomic) int pickerDistanceXiao2;

@property(nonatomic) int pickerTimeGe;
@property(nonatomic) int pickerTimeShi;
@property(nonatomic) int pickerTimeBai;

-(IBAction)saveBtnPressed:(id)sender;

@end
