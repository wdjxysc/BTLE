//
//  CloudDataViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudDataViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UILabel *usernameLabel;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UITextField *passwordTextField;
    
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *forgetBtn;
    IBOutlet UIButton *registerBtn;
    
    IBOutlet UIView *loginView;
    
    IBOutlet UILabel *nowUserLabel;
    IBOutlet UIButton *logoutBtn;
    IBOutlet UIView *logoutView;
}

@property(retain,nonatomic) UILabel *usernameLabel;
@property(retain,nonatomic) UITextField *usernameTextField;
@property(retain,nonatomic) UILabel *passwordLabel;
@property(retain,nonatomic) UITextField *passwordTextField;
@property(retain,nonatomic) UIButton *loginBtn;
@property(retain,nonatomic) UIButton *forgetBtn;
@property(retain,nonatomic) UIButton *registerBtn;
@property(retain,nonatomic) UIView *loginView;


@property(retain,nonatomic) UILabel *nowUserLabel;
@property(retain,nonatomic) UIButton *logoutBtn;
@property(retain,nonatomic) UIView *logoutView;

-(IBAction)loginBtnPressed:(id)sender;

-(IBAction)logoutBtnPressed:(id)sender;
@end
