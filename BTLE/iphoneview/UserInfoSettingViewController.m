//
//  UserInfoSettingViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "UserInfoSettingViewController.h"
#import "MySingleton.h"
#import "database.h"

@interface UserInfoSettingViewController ()

@end

@implementation UserInfoSettingViewController
@synthesize sexLabel;
@synthesize sexDataTextField;
@synthesize sexImageView;
@synthesize ageLabel;
@synthesize ageDataTextField;
@synthesize heightLabel;
@synthesize heightDataTextField;
@synthesize weightLabel;
@synthesize weightDataTextField;
@synthesize steplengthLabel;
@synthesize steplengthDataTextField;
@synthesize myNavigationBar;
@synthesize myPickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"用户信息设置";
        UIBarButtonItem *saveBarBtnItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"SAVE", Nil) style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnPressed:)];
        [self.navigationItem setRightBarButtonItem:saveBarBtnItem];
    }
    return self;
}

-(void)saveUserInfo
{
    int height = 0;
    int age = 0;
    double weight = 0;
    int sex = 0;
    int steplength = 0;
    
    height = [heightDataTextField.text intValue];
    age = [ageDataTextField.text intValue];
    weight = [weightDataTextField.text doubleValue];
    
    if([sexDataTextField.text isEqualToString:NSLocalizedString(@"GENDER_MALE", nil)])
    {
        sex = 0;
    }
    else if([sexDataTextField.text isEqualToString:NSLocalizedString(@"GENDER_FEMALE",nil)])
    {
        sex = 1;
    }
    steplength = [steplengthDataTextField.text intValue];
    
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSString *sqlupdateuserinfo = [NSString stringWithFormat:@"UPDATE 'USER' SET AGE = %d, SEX = %d, SPORTLVL = %d, HEIGHT = %d,WEIGHT = %.1f,STEPLENGTH = %d,PASSWORD = '' WHERE USERNAME = '%@'", age, sex, 1, height, weight, steplength, username];
    bool b = [database insert:sqlupdateuserinfo];
    if(b)
    {
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%d",age] forKey:@"Age"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%d",sex] forKey:@"Sex"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%d",height] forKey:@"Height"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%f",weight] forKey:@"Weight"];
        [[MySingleton sharedSingleton].nowuserinfo setValue:[[NSString alloc] initWithFormat:@"%d",steplength] forKey:@"StepSize"];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOTICE", nil)
//                                                            message:NSLocalizedString(@"SAVED", nil)
//                                                           delegate:nil
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
//        [alertView show];
    }
    
    
    
    Byte bt1 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"] intValue];
    Byte bt2 = ((int)(weight*10))%256;
    Byte bt3 = ((int)(weight*10))/256;
    Byte bt4 = [[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"] intValue];
    Byte sendbyte1[] = {bt1, bt2, bt3, bt4};
    NSData *data1 = [[NSData alloc]initWithBytes:sendbyte1 length:sizeof(sendbyte1)];
    [[MySingleton sharedSingleton].myblecontroller setUserInfo:data1];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送", nil)
                                                        message:[[NSString alloc] initWithFormat:@"0x%x 0x%x 0x%x 0x%x",sendbyte1[0],sendbyte1[1],sendbyte1[2],sendbyte1[3]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMyView];
    [self showUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMyView
{
    ageDataTextField.text = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Age"];
    if([[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Sex"] isEqualToString:@"0"])
    {
        sexDataTextField.text = NSLocalizedString(@"GENDER_MALE", nil);
    }
    else
    {
        sexDataTextField.text = NSLocalizedString(@"GENDER_FEMALE", nil);
    }
    heightDataTextField.text = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Height"];
    weightDataTextField.text = [[NSString alloc] initWithFormat:@"%.1f",[[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"Weight"] doubleValue]];
    steplengthDataTextField.text = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"StepSize"];
    
    myNavigationItem.leftBarButtonItem.title = NSLocalizedString(@"CANCEL", nil);
    myNavigationItem.rightBarButtonItem.title = NSLocalizedString(@"DONE", nil);
    myNavigationItem.title = NSLocalizedString(@"USER_AGE", nil);
    ageDataTextField.inputAccessoryView = myNavigationBar;
    ageDataTextField.inputView = myPickerView;
    [ageDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    mySexNavigationItem.leftBarButtonItem.title = NSLocalizedString(@"CANCEL", nil);
    mySexNavigationItem.rightBarButtonItem.title = NSLocalizedString(@"DONE", nil);
    mySexNavigationItem.title = NSLocalizedString(@"USER_GENDER", nil);
    sexDataTextField.inputAccessoryView = mySexNavigationBar;
    sexDataTextField.inputView = mySexPickerView;
    [sexDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    myHeightNavigationItem.leftBarButtonItem.title = NSLocalizedString(@"CANCEL", nil);
    myHeightNavigationItem.rightBarButtonItem.title = NSLocalizedString(@"DONE", nil);
    myHeightNavigationItem.title = NSLocalizedString(@"USER_HEIGHT", nil);
    heightDataTextField.inputAccessoryView = myHeightNavigationBar;
    heightDataTextField.inputView = myHeightPickerView;
    [heightDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    myWeightNavigationItem.leftBarButtonItem.title = NSLocalizedString(@"CANCEL", nil);
    myWeightNavigationItem.rightBarButtonItem.title = NSLocalizedString(@"DONE", nil);
    myWeightNavigationItem.title = NSLocalizedString(@"USER_WEIGHT", nil);
    weightDataTextField.inputAccessoryView = myWeightNavigationBar;
    weightDataTextField.inputView = myWeightPickerView;
    [weightDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    mySteplengthNavigationItem.leftBarButtonItem.title = NSLocalizedString(@"CANCEL", nil);
    mySteplengthNavigationItem.rightBarButtonItem.title = NSLocalizedString(@"DONE", nil);
    mySteplengthNavigationItem.title = NSLocalizedString(@"USER_STEPLENGTH", nil);
    steplengthDataTextField.inputAccessoryView = mySteplengthNavigationBar;
    steplengthDataTextField.inputView = mySteplengthPickerView;
    [steplengthDataTextField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

-(void)showUserInfo
{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

//设置heightPickerView pickerView属性，几行几列及要显示什么
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger result = 0;
    if ([ageDataTextField isFirstResponder])
    {
//        myNavigationItem.title = NSLocalizedString(@"USER_AGE", nil);
        result = 1;
    }
    else if ([heightDataTextField isFirstResponder])
    {
//        myHeightNavigationItem.title = NSLocalizedString(@"USER_HEIGHT", nil);
        result = 1;
    }
    else if([weightDataTextField isFirstResponder])
    {
//        myNavigationItem.title = NSLocalizedString(@"USER_WEIGHT", nil);
        result = 3;
    }
    else if([steplengthDataTextField isFirstResponder])
    {
//        myNavigationItem.title = NSLocalizedString(@"USER_STEPLENGTH", nil);
        result = 1;
    }
    else if([sexDataTextField isFirstResponder])
    {
//        myNavigationItem.title = NSLocalizedString(@"USER_GERDER", nil);
        result = 1;
    }
    return result;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    
    if ([ageDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 150;
                break;
            default:
                break;
        }
    }
    else if([sexDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 2;
                break;
            default:
                break;
        }
    }
    else if([heightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 250;
                break;
            default:
                break;
        }
    }
    else if([weightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 150;
                break;
            case 1:
                result = 1;
                break;
            case 2:
                result = 10;
                break;
            default:
                break;
        }
    }
    else if([steplengthDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 150;
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
    if ([ageDataTextField isFirstResponder])
    {
        /* Row is zero-based and we want the first row (with index 0) to be rendered as Row 1 so we have to +1 every row index */
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld", (long)row + 1];
                break;
            case 1:
                result = @"cm";
                break;
            default:
                break;
        }
    }
    else if ([sexDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                switch (row) {
                    case 0:
                        result = NSLocalizedString(@"GENDER_MALE", nil);
                        break;
                    case 1:
                        result = NSLocalizedString(@"GENDER_FEMALE", nil);
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
    else if ([heightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld",(long)row + 1];
                break;
            default:
                break;
        }
    }
    else if ([weightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld",(long)row + 1];
                break;
            case 1:
                result = @".";
                break;
            case 2:
                result = [NSString stringWithFormat:@"%ld",(long)row];
                break;
            default:
                break;
        }
    }
    else if ([steplengthDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = [NSString stringWithFormat:@"%ld",(long)row + 1];
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
    
    int result = 320;
    if ([weightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                result = 80;
                break;
            case 1:
                result = 40;
                break;
            case 2:
                result = 80;
                break;
            default:
                break;
        }
    }
    
    
    return result;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([ageDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                ageDataTextField.text = [NSString stringWithFormat:@"%ld", (long)row + 1];
                break;
            default:
                break;
        }
    }
    else if ([sexDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                switch (row) {
                    case 0:
                        sexDataTextField.text = NSLocalizedString(@"GENDER_MALE", nil);
                        break;
                    case 1:
                        sexDataTextField.text = NSLocalizedString(@"GENDER_FEMALE", nil);
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
    else if ([heightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                heightDataTextField.text = [NSString stringWithFormat:@"%ld",(long)row + 1];
                break;
            default:
                break;
        }
    }
    else if ([weightDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerWeihgtInt = (long)row + 1;
                break;
            case 1:
                break;
            case 2:
                self.pickerWeihgtFloat = (long)row;
                break;
            default:
                break;
        }
        weightDataTextField.text = [[NSString alloc]initWithFormat:@"%d.%d",self.pickerWeihgtInt,self.pickerWeihgtFloat];
    }
    else if ([steplengthDataTextField isFirstResponder])
    {
        switch (component) {
            case 0:
                steplengthDataTextField.text = [NSString stringWithFormat:@"%ld",(long)row + 1];
                break;
            default:
                break;
        }
    }
}

-(void)endEdit:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(IBAction)canceledit:(id)sender
{
    [sexDataTextField resignFirstResponder];
    [weightDataTextField resignFirstResponder];
    [heightDataTextField resignFirstResponder];
    [ageDataTextField resignFirstResponder];
    [steplengthDataTextField resignFirstResponder];
}

-(IBAction)saveBtnPressed:(id)sender
{
    [self saveUserInfo];
}
@end
