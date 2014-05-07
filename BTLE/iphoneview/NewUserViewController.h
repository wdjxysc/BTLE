//
//  NewUserViewController.h
//  BTLE
//
//  Created by 夏 伟 on 14-1-20.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UILabel *usernameLabel;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UILabel *repasswordLabel;
    IBOutlet UITextField *repasswordTextField;
    IBOutlet UILabel *emailLabel;
    IBOutlet UITextField *emailTextField;
    IBOutlet UILabel *deviceidLabel;
    IBOutlet UITextField *deviceidTextField;
    IBOutlet UILabel *checkcodeLabel;
    IBOutlet UITextField *checkcodeTextField;
    
    IBOutlet UIButton *getCheckCodeBtn;
    IBOutlet UIButton *registerBtn;
}

-(IBAction)registBtnPressed:(id)sender;
@end
