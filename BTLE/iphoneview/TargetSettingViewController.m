//
//  TargetSettingViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "TargetSettingViewController.h"
#import "MySingleton.h"
#import "database.h"

@interface TargetSettingViewController ()

@end

@implementation TargetSettingViewController
@synthesize stepLabel;
@synthesize stepDataTextField;
@synthesize distanceLabel;
@synthesize distanceDataTextField;
@synthesize timeLabel;
@synthesize timeDataTextField;
@synthesize kcalLabel;
@synthesize kcalDataTextField;
@synthesize myStepNavigationBar;
@synthesize myStepNavigationItem;
@synthesize myStepPickerView;
@synthesize myDistanceNavigationBar;
@synthesize myDistanceNavigationItem;
@synthesize myDistancePickerView;
@synthesize myTimeNavigationBar;
@synthesize myTimeNavigationItem;
@synthesize myTimePickerView;
@synthesize myKcalNavigationBar;
@synthesize myKcalNavigationItem;
@synthesize myKcalPickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"目标值设定";
        UIBarButtonItem *saveBarBtnItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"SAVE", Nil) style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnPressed:)];
        [self.navigationItem setRightBarButtonItem:saveBarBtnItem];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMyView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveTarget
{
    int step = 0;
    int time = 0;
    double distance = 0;
    double kcal = 0;
    
    step = [stepDataTextField.text intValue];
    time = [timeDataTextField.text intValue];
    distance = [distanceDataTextField.text doubleValue];
    kcal = [kcalDataTextField.text doubleValue];
    
    
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSString *sqlupdateusertarget = [NSString stringWithFormat:@"UPDATE 'TARGET' SET STEPNUM = %d, KCAL = %f, DISTANCE = %f,SPORTTIME = %d WHERE USERNAME = '%@'", step, kcal, distance, time,username];
    bool b = [database insert:sqlupdateusertarget];
    if(b)
    {
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%d",step] forKey:@"TargetStepNumber"];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOTICE", nil)
                                                            message:NSLocalizedString(@"SAVED_SUCCESS", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alertView show];
    }
}

-(IBAction)saveBtnPressed:(id)sender
{
    [self saveTarget];
}

-(void)initMyView
{
    stepLabel.text = NSLocalizedString(@"STEP", nil);
    distanceLabel.text = NSLocalizedString(@"DISTANCE", nil);
    timeLabel.text = NSLocalizedString(@"TIME", nil);
    kcalLabel.text = NSLocalizedString(@"CALORIE", nil);
    
    stepDataTextField.inputAccessoryView = myStepNavigationBar;
    stepDataTextField.inputView = myStepPickerView;
    [stepDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    kcalDataTextField.inputAccessoryView = myKcalNavigationBar;
    kcalDataTextField.inputView = myKcalPickerView;
    [kcalDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    distanceDataTextField.inputAccessoryView = myDistanceNavigationBar;
    distanceDataTextField.inputView = myDistancePickerView;
    [distanceDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    timeDataTextField.inputAccessoryView = myTimeNavigationBar;
    timeDataTextField.inputView = myTimePickerView;
    [timeDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

-(void)endEdit:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(IBAction)canceledit:(id)sender
{
    [stepDataTextField resignFirstResponder];
    [kcalDataTextField resignFirstResponder];
    [distanceDataTextField resignFirstResponder];
    [timeDataTextField resignFirstResponder];
}

//设置heightPickerView pickerView属性，几行几列及要显示什么
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger result = 0;
    if ([stepDataTextField isFirstResponder])
    {
        myStepNavigationItem.title = NSLocalizedString(@"STEP", nil);
        result = 6;
    }
    else if ([kcalDataTextField isFirstResponder])
    {
        myKcalNavigationItem.title = NSLocalizedString(@"KCAL", nil);
        result = 6;
    }
    else if([distanceDataTextField isFirstResponder])
    {
        myDistanceNavigationItem.title = NSLocalizedString(@"DISTANCE", nil);
        result = 6;
    }
    else if([timeDataTextField isFirstResponder])
    {
        myTimeNavigationItem.title = NSLocalizedString(@"TIME", nil);
        result = 3;
    }
    return result;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    
    if ([stepDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 10;
                break;
            case 1:
                result = 10;
                break;
            case 2:
                result = 10;
                break;
            case 3:
                result = 10;
                break;
            case 4:
                result = 10;
                break;
            case 5:
                result = 10;
                break;
            default:
                break;
        }
    }
    else if([kcalDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 10;
                break;
            case 1:
                result = 10;
                break;
            case 2:
                result = 10;
                break;
            case 3:
                result = 1;
                break;
            case 4:
                result = 10;
                break;
            case 5:
                result = 10;
                break;
            default:
                break;
        }
    }
    else if([distanceDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 10;
                break;
            case 1:
                result = 10;
                break;
            case 2:
                result = 10;
                break;
            case 3:
                result = 1;
                break;
            case 4:
                result = 10;
                break;
            case 5:
                result = 10;
                break;
            default:
                break;
        }
    }
    else if([timeDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 10;
                break;
            case 1:
                result = 10;
                break;
            case 2:
                result = 10;
                break;
            default:
                break;
        }
    }
    
    return result;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *result = nil;
    if ([stepDataTextField isFirstResponder])
    {
        /* Row is zero-based and we want the first row (with index 0) to be rendered as Row 1 so we have to +1 every row index */
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 1:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 2:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 3:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 4:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 5:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            default:
                break;
        }
    }
    else if ([kcalDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 1:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 2:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 3:
                result = @".";
                break;
            case 4:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 5:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            default:
                break;
        }
    }
    else if ([distanceDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 1:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 2:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 3:
                result = @".";
                break;
            case 4:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 5:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            default:
                break;
        }
    }
    else if ([timeDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 1:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            case 2:
                result = [NSString stringWithFormat:@"%ld", (long)row];
                break;
            default:
                break;
        }
    }
    //设置初始值
    //    [pickerView selectRow:169 inComponent:0 animated:NO];
    return result;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    int result = 50;
    //    if ([timeDataTextField isFirstResponder])
    //    {
    //        switch (component) {
    //            case 0:
    //                result = 80;
    //                break;
    //            case 1:
    //                result = 40;
    //                break;
    //            case 2:
    //                result = 80;
    //                break;
    //            default:
    //                break;
    //        }
    //    }
    
    
    return result;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([stepDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerStepShiWan = (long)row;
                break;
            case 1:
                self.pickerStepWan = (long)row;
                break;
            case 2:
                self.pickerStepQian = (long)row;
                break;
            case 3:
                self.pickerStepBai = (long)row;
                break;
            case 4:
                self.pickerStepShi = (long)row;
                break;
            case 5:
                self.pickerStepGe = (long)row;
                break;
            default:
                break;
        }
        stepDataTextField.text = [[NSString alloc]initWithFormat:@"%d",self.pickerStepShiWan*100000 + self.pickerStepWan*10000 + self.pickerStepQian*1000 +self.pickerStepBai*100+self.pickerStepShi*10 +self.pickerStepGe ];
    }
    else if ([kcalDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerKcalBai = (long)row;
                break;
            case 1:
                self.pickerKcalShi = (long)row;
                break;
            case 2:
                self.pickerKcalGe = (long)row;
                break;
            case 3:
                break;
            case 4:
                self.pickerKcalXiao1 = (long)row;
                break;
            case 5:
                self.pickerKcalXiao2 = (long)row;
                break;
            default:
                break;
        }
        
        kcalDataTextField.text = [[NSString alloc]initWithFormat:@"%.2f",self.pickerKcalBai*100.f + self.pickerKcalShi *10.f + self.pickerKcalGe + self.pickerKcalXiao1*0.1f + self.pickerKcalXiao2*0.01f];
    }
    else if ([distanceDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerDistanceBai = (long)row;
                break;
            case 1:
                self.pickerDistanceShi = (long)row;
                break;
            case 2:
                self.pickerDistanceGe = (long)row;
                break;
            case 3:
                break;
            case 4:
                self.pickerDistanceXiao1 = (long)row;
                break;
            case 5:
                self.pickerDistanceXiao2 = (long)row;
                break;
            default:
                break;
        }
        
        distanceDataTextField.text = [[NSString alloc]initWithFormat:@"%.2f",self.pickerDistanceBai*100.f + self.pickerDistanceShi *10.f + self.pickerDistanceGe + self.pickerDistanceXiao1*0.1f + self.pickerDistanceXiao2*0.01f];
    }
    else if ([timeDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerTimeBai = (long)row;
                break;
            case 1:
                self.pickerTimeShi = (long)row;
                break;
            case 2:
                self.pickerTimeGe = (long)row;
                break;
        }
        timeDataTextField.text = [[NSString alloc]initWithFormat:@"%d",self.pickerTimeBai*100+self.pickerTimeShi*10 +self.pickerTimeGe ];
    }
}

@end
