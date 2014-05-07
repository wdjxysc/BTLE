//
//  SettingsViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserInfoSettingViewController.h"
#import "TargetSettingViewController.h"
#import "NewUserViewController.h"
#import "CallRemindViewController.h"
#import "SportRemindViewController.h"
#import "AlarmRemindViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem.image = [UIImage imageNamed:@"Settings"];
//        self.tabBarItem.title = NSLocalizedString(@"SETTINGS", nil);
        self.navigationItem.title = NSLocalizedString(@"SETTINGS", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showUserSettingView:(id)sender
{
    UserInfoSettingViewController *settingUserInfoViewController = [[UserInfoSettingViewController alloc]initWithNibName:@"SettingUserInfoViewController" bundle:nil];
    
    [self.navigationController pushViewController:settingUserInfoViewController animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger result = 0;
    if([tableView isEqual:settingTableView])
    {
        result = 5;
    }
    return result;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if([tableView isEqual:settingTableView])
    {
        switch (section) {
            case 0:
                result = 1;
                break;
            case 1:
                result = 1;
                break;
            case 2:
                result = 1;
                break;
            case 3:
                result = 3;
                break;
            case 4:
                result = 0;
                break;
            default:
                break;
        }
    }
    return  result;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = nil;
    
    if([tableView isEqual:settingTableView])
    {
        static NSString *TableViewCellIdentifier = @"MyCells";
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        
        if(result == nil)
        {
            result = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
        }
        
        result.textLabel.text = [NSString stringWithFormat:@"Section %ld in cell %ld",(long)indexPath.section,(long)indexPath.row];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 0, 150, 25);
        [button setTitle:@"Expand" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(performExpand:) forControlEvents:UIControlEventTouchUpInside];
        
        if(indexPath.section == 0 && indexPath.row == 0){
            result.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.textLabel.text = NSLocalizedString(@"EDITUSER", nil);
            //            UITextField *textField =[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
            //            textField.borderStyle = UITextBorderStyleNone;
            //            textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
            //            textField.clearButtonMode =  UITextFieldViewModeNever;
            //            textField.textAlignment = UITextAlignmentRight;
            //            textField.textColor = [UIColor purpleColor];
            //
            //            [textField addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            //            nameTextField = textField;
            //            textField.text = [userinfo objectForKey:@"UserName"];
            //            result.accessoryView = textField;
            //            //被选中无效果
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.imageView.image = [UIImage imageNamed:@"user"];
        }
        if(indexPath.section == 0 && indexPath.row == 1){
            
        }
        if(indexPath.section == 0 && indexPath.row == 2){
            
        }
        if(indexPath.section == 0 && indexPath.row == 3){
        }
        if(indexPath.section == 0 && indexPath.row == 4){
        }
        if(indexPath.section == 0 && indexPath.row == 5){
        }
        if(indexPath.section == 1 && indexPath.row == 0)
        {
            result.textLabel.text = @"目标设置";
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.imageView.image = [UIImage imageNamed:@"target"];
        }
        if(indexPath.section == 2 && indexPath.row == 0)
        {
            result.textLabel.text = @"注册云账号";
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.imageView.image = [UIImage imageNamed:@"cloud"];
        }
        if(indexPath.section == 3 && indexPath.row == 0)
        {
            result.textLabel.text = @"来电提醒";
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.imageView.image = [UIImage imageNamed:@"phone"];
        }
        if(indexPath.section == 3 && indexPath.row == 1)
        {
            result.textLabel.text = @"运动提醒";
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.imageView.image = [UIImage imageNamed:@"sport"];
        }
        if(indexPath.section == 3 && indexPath.row == 2)
        {
            result.textLabel.text = @"闹铃";
            result.selectionStyle = UITableViewCellSelectionStyleNone;
            result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            result.imageView.image = [UIImage imageNamed:@"alarm"];
        }
        
//        result.accessoryView = button;
    }
    return result;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:self->settingTableView])
    {
        NSLog(@"%@",[NSString stringWithFormat:@"Cell %ld in section %ld is selected",(long)indexPath.row,(long)indexPath.section]);
        
        if(indexPath.section == 0 && indexPath.row == 0)
        {
            [self showUserInfoSettingsView];
        }
        else if(indexPath.section == 1 && indexPath.row == 0)
        {
            [self showTargetSettingsView];
        }
        else if(indexPath.section == 2 && indexPath.row == 0)
        {
            [self showNewUserView];
        }
        else if(indexPath.section == 3 && indexPath.row == 0)
        {
            [self showCallRemindSettingView];
        }
        else if(indexPath.section == 3 && indexPath.row == 1)
        {
            [self showSportRemindSettingView];
        }
        else if(indexPath.section == 3 && indexPath.row == 2)
        {
            [self showAlarmRemindSettingView];
        }
    }
}

//设置Header和Footer 文字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result = nil;
    if([tableView isEqual:settingTableView]&& section ==0)
    {
        result = NSLocalizedString(@"USER", nil);
        result = @" ";
    }
    else if([tableView isEqual:settingTableView]&& section ==1)
    {
        result = @"目标";
        result = @" ";
    }
    else if([tableView isEqual:settingTableView]&& section ==2)
    {
        result = @"云注册";
        result = @" ";
    }
    else if([tableView isEqual:settingTableView]&& section == 3)
    {
        result = @"提醒设置";
        result = @" ";
    }
    
    return result;
}

-(NSString  *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *result = nil;
    if([tableView isEqual:settingTableView]&& section ==0)
    {
//        result = @"set user information";
    }
    else if([tableView isEqual:settingTableView]&& section ==1)
    {
//        result = @"set optional infomation";
    }
    else if([tableView isEqual:settingTableView]&& section ==2)
    {
        //        result = @"set optional infomation";
    }
    else if([tableView isEqual:settingTableView]&& section ==3)
    {
        //        result = @"set optional infomation";
    }
    
    return result;
}


-(void)showUserInfoSettingsView
{
    UserInfoSettingViewController *settingUserInfoViewController = [[UserInfoSettingViewController alloc]initWithNibName:@"UserInfoSettingViewController" bundle:nil];
    
    [self.navigationController pushViewController:settingUserInfoViewController animated:YES];
}

-(void)showTargetSettingsView
{
    TargetSettingViewController *settingUserInfoViewController = [[TargetSettingViewController alloc]initWithNibName:@"TargetSettingViewController" bundle:nil];
    
    [self.navigationController pushViewController:settingUserInfoViewController animated:YES];
}

-(void)showNewUserView
{
    NewUserViewController *settingUserInfoViewController = [[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
    
    [self.navigationController pushViewController:settingUserInfoViewController animated:YES];
}

-(void)showCallRemindSettingView
{
    CallRemindViewController *callRemindViewController = [[CallRemindViewController alloc]initWithNibName:@"CallRemindViewController" bundle:nil];
    
    [self.navigationController pushViewController:callRemindViewController animated:YES];
}

-(void)showSportRemindSettingView
{
    SportRemindViewController *sportRemindViewController = [[SportRemindViewController alloc]initWithNibName:@"SportRemindViewController" bundle:nil];
    
    [self.navigationController pushViewController:sportRemindViewController animated:YES];
}

-(void)showAlarmRemindSettingView
{
    AlarmRemindViewController *alarmRemindViewController = [[AlarmRemindViewController alloc]initWithNibName:@"AlarmRemindViewController" bundle:nil];
    
    [self.navigationController pushViewController:alarmRemindViewController animated:YES];
}


@end
