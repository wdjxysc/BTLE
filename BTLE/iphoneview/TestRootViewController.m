//
//  TestRootViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-9.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "TestRootViewController.h"
#import "TestSleepMonitorViewController.h"
#import "TestHistoryStepViewController.h"
#import "TestRemindViewController.h"

@interface TestRootViewController ()

@end

@implementation TestRootViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showSleepMonitorView:(id)sender
{
    TestSleepMonitorViewController *sleepMonitorViewController = [[TestSleepMonitorViewController alloc]initWithNibName:@"TestSleepMonitorViewController" bundle:nil];
    [self presentViewController:sleepMonitorViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
}

-(IBAction)showHistoryStepView:(id)sender
{
    TestHistoryStepViewController *historyStepViewController = [[TestHistoryStepViewController alloc]initWithNibName:@"TestHistoryStepViewController" bundle:nil];
    [self presentViewController:historyStepViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
}

-(IBAction)showRemindView:(id)sender
{
    TestRemindViewController *remindViewController = [[TestRemindViewController alloc]initWithNibName:@"TestRemindViewController" bundle:nil];
    [self presentViewController:remindViewController animated:NO completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
}
@end
