//
//  CallRemindViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "CallRemindViewController.h"
#import "MySingleton.h"
#import "database.h"

@interface CallRemindViewController ()

@end

@implementation CallRemindViewController
@synthesize mySwitch;
@synthesize callLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"来电提醒";
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

-(IBAction)saveBtnPressed:(id)sender
{
    NSString *isremind = @"N";
    if(mySwitch.on)
    {
        isremind = @"Y";
    }
    
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDictionary *dic = [database selectUserCallRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"]];
    NSString *sql = @"";
    if(dic != nil){
        sql = [NSString stringWithFormat:@"UPDATE 'CALLREMIND' SET ISREMIND = '%@' WHERE USERNAME = '%@'", isremind,username];
    }
    else
    {
        sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'CALLREMIND' ('USERNAME','ISREMIND') VALUES ('%@','%@')", username, isremind];
    }
    bool b = [database insert:sql];
    if(b)
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOTICE", nil)
//                                                            message:NSLocalizedString(@"SAVED_SUCCESS", nil)
//                                                           delegate:nil
//                                                  cancelButtonTitle:nil
//                                                  otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
//        [alertView show];
    }
    
    //设置设备
    [self setCallRemindToDevice];
}

-(void)setCallRemindToDevice
{
    Byte bt1 = 0;
    if(mySwitch.on)
    {
        bt1 = 1;
    }
    
    //设置来电提醒
    Byte sendbyte1[] = {bt1};
    NSData *data1 = [[NSData alloc]initWithBytes:sendbyte1 length:sizeof(sendbyte1)];
    [[MySingleton sharedSingleton].myblecontroller setCallerRemind:data1];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送", nil)
                                                        message:[[NSString alloc] initWithFormat:@"0x%x",sendbyte1[0]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
}

-(void)initMyView
{
    NSDictionary *dic = [database selectUserCallRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"]];
    
    if([[dic valueForKey:@"IsRemind"] isEqualToString:@"Y"])
    {
        mySwitch.on = YES;
    }
    else
    {
        mySwitch.on = NO;
    }
}

@end
