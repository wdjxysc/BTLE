//
//  NewUserViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-13.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "NewUserViewController.h"
#import "database.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"注册云用户";
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

//点击其他位置隐藏软键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [repasswordTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [deviceidTextField resignFirstResponder];
    [checkcodeTextField resignFirstResponder];
}

-(void)saveUserInfo
{
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    
    NSDictionary *dic = [database selectUserByName:username];
    if(dic == nil)
    {
        NSString *sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'USER' ('USERNAME','AGE','SEX', 'SPORTLVL', 'HEIGHT','WEIGHT', 'STEPLENGTH', 'PASSWORD') VALUES ('%@','%d','%d','%d','%d','%f','%d','%@')", username, 20, 0, 1, 175, 65.0, 70, password];
        [database insert:sql];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"NOTICE"
                                                            message:@"User already exists!"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    
}

-(IBAction)registBtnPressed:(id)sender
{
    [self saveUserInfo];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"NOTICE"
                                                        message:@"Registration successful!"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    [alertView show];
}
@end
