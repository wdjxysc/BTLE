//
//  CloudDataViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "CloudDataViewController.h"
#import "database.h"
#import "MySingleton.h"

@interface CloudDataViewController ()

@end

@implementation CloudDataViewController
@synthesize usernameLabel;
@synthesize usernameTextField;
@synthesize passwordLabel;
@synthesize passwordTextField;
@synthesize loginBtn;
@synthesize forgetBtn;
@synthesize registerBtn;
@synthesize loginView;
@synthesize logoutBtn;
@synthesize nowUserLabel;
@synthesize logoutView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)initMyView
{
    self.loginView.hidden = YES;
    if([[MySingleton sharedSingleton].isOnNet isEqualToString:@"Y"]){
        
        self.loginView.hidden = YES;
        //
    }
    else
    {
        
    }
}

-(void)login
{
    
}

-(IBAction)loginBtnPressed:(id)sender
{
    self.loginView.hidden = YES;
    self.logoutView.hidden = NO;
}

-(IBAction)logoutBtnPressed:(id)sender
{
    self.logoutView.hidden = YES;
    self.loginView.hidden = NO;
}


@end
