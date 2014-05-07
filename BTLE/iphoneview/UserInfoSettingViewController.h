//
//  UserInfoSettingViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoSettingViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    IBOutlet UILabel *sexLabel;
    IBOutlet UITextField *sexDataTextField;
    IBOutlet UIImageView *sexImageView;
    IBOutlet UILabel *ageLabel;
    IBOutlet UITextField *ageDataTextField;
    IBOutlet UILabel *heightLabel;
    IBOutlet UITextField *heightDataTextField;
    IBOutlet UILabel *weightLabel;
    IBOutlet UITextField *weightDataTextField;
    IBOutlet UILabel *steplengthLabel;
    IBOutlet UITextField *steplengthDataTextField;
    
    IBOutlet UINavigationBar *myNavigationBar;
    IBOutlet UINavigationItem *myNavigationItem;
    IBOutlet UIPickerView *myPickerView;
    
    IBOutlet UINavigationBar *myHeightNavigationBar;
    IBOutlet UINavigationItem *myHeightNavigationItem;
    IBOutlet UIPickerView *myHeightPickerView;
    
    IBOutlet UINavigationBar *myWeightNavigationBar;
    IBOutlet UINavigationItem *myWeightNavigationItem;
    IBOutlet UIPickerView *myWeightPickerView;
    
    IBOutlet UINavigationBar *mySteplengthNavigationBar;
    IBOutlet UINavigationItem *mySteplengthNavigationItem;
    IBOutlet UIPickerView *mySteplengthPickerView;
    
    IBOutlet UINavigationBar *mySexNavigationBar;
    IBOutlet UINavigationItem *mySexNavigationItem;
    IBOutlet UIPickerView *mySexPickerView;
}

@property(nonatomic,retain) UILabel *sexLabel;
@property(nonatomic,retain) UITextField *sexDataTextField;
@property(nonatomic,retain) UIImageView *sexImageView;
@property(nonatomic,retain) UILabel *ageLabel;
@property(nonatomic,retain) UITextField *ageDataTextField;
@property(nonatomic,retain) UILabel *heightLabel;
@property(nonatomic,retain) UITextField *heightDataTextField;
@property(nonatomic,retain) UILabel *weightLabel;
@property(nonatomic,retain) UITextField *weightDataTextField;
@property(nonatomic,retain) UILabel *steplengthLabel;
@property(nonatomic,retain) UITextField *steplengthDataTextField;

@property(nonatomic,retain) UINavigationBar *myNavigationBar;
@property(nonatomic,retain) UIPickerView *myPickerView;

@property(nonatomic) int pickerWeihgtInt;
@property(nonatomic) int pickerWeihgtFloat;


@end
