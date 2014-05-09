//
//  AlarmRemindViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "AlarmRemindViewController.h"
#import "MySingleton.h"
#import "database.h"

@interface AlarmRemindViewController ()

@end

@implementation AlarmRemindViewController
@synthesize alarmLabel1;
@synthesize alarmSwitch1;
@synthesize remindTimeLabel1;
@synthesize remindTimeTextField1;
@synthesize everydayButton1;
@synthesize sudayButton1;
@synthesize modayButton1;
@synthesize tudayButton1;
@synthesize wedayButton1;
@synthesize thdayButton1;
@synthesize frdayButton1;
@synthesize sadayButton1;

@synthesize alarmLabel2;
@synthesize alarmSwitch2;
@synthesize remindTimeLabel2;
@synthesize remindTimeTextField2;
@synthesize everydayButton2;
@synthesize sudayButton2;
@synthesize modayButton2;
@synthesize tudayButton2;
@synthesize wedayButton2;
@synthesize thdayButton2;
@synthesize frdayButton2;
@synthesize sadayButton2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"闹铃设置";
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
    
    //添加单击手势，隐藏软键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(View_TouchDown:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed:(id)sender
{
    if((UIButton *)sender == self.everydayButton1)
    {
        if(self.everydayButton1.tintColor == [UIColor blueColor])
        {
            self.everydayButton1.tintColor = [UIColor grayColor];
            self.sudayButton1.tintColor = [UIColor grayColor];
            self.modayButton1.tintColor = [UIColor grayColor];
            self.tudayButton1.tintColor = [UIColor grayColor];
            self.wedayButton1.tintColor = [UIColor grayColor];
            self.thdayButton1.tintColor = [UIColor grayColor];
            self.frdayButton1.tintColor = [UIColor grayColor];
            self.sadayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.everydayButton1.tintColor = [UIColor blueColor];
            self.sudayButton1.tintColor = [UIColor blueColor];
            self.modayButton1.tintColor = [UIColor blueColor];
            self.tudayButton1.tintColor = [UIColor blueColor];
            self.wedayButton1.tintColor = [UIColor blueColor];
            self.thdayButton1.tintColor = [UIColor blueColor];
            self.frdayButton1.tintColor = [UIColor blueColor];
            self.sadayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.sudayButton1)
    {
        if(self.sudayButton1.tintColor == [UIColor blueColor])
        {
            self.sudayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.sudayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.modayButton1)
    {
        if(self.modayButton1.tintColor == [UIColor blueColor])
        {
            self.modayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.modayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.tudayButton1)
    {
        
        
        
        if(self.tudayButton1.tintColor == [UIColor blueColor])
        {
            self.tudayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.tudayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.wedayButton1)
    {
        if(self.wedayButton1.tintColor == [UIColor blueColor])
        {
            self.wedayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.wedayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.thdayButton1)
    {
        if(self.thdayButton1.tintColor == [UIColor blueColor])
        {
            self.thdayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.thdayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.frdayButton1)
    {
        if(self.frdayButton1.tintColor == [UIColor blueColor])
        {
            self.frdayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.frdayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.sadayButton1)
    {
        if(self.sadayButton1.tintColor == [UIColor blueColor])
        {
            self.sadayButton1.tintColor = [UIColor grayColor];
            self.everydayButton1.tintColor = [UIColor grayColor];
        }
        else
        {
            self.sadayButton1.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.everydayButton2)
    {
        if(self.everydayButton2.tintColor == [UIColor blueColor])
        {
            self.everydayButton2.tintColor = [UIColor grayColor];
            self.sudayButton2.tintColor = [UIColor grayColor];
            self.modayButton2.tintColor = [UIColor grayColor];
            self.tudayButton2.tintColor = [UIColor grayColor];
            self.wedayButton2.tintColor = [UIColor grayColor];
            self.thdayButton2.tintColor = [UIColor grayColor];
            self.frdayButton2.tintColor = [UIColor grayColor];
            self.sadayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.everydayButton2.tintColor = [UIColor blueColor];
            self.sudayButton2.tintColor = [UIColor blueColor];
            self.modayButton2.tintColor = [UIColor blueColor];
            self.tudayButton2.tintColor = [UIColor blueColor];
            self.wedayButton2.tintColor = [UIColor blueColor];
            self.thdayButton2.tintColor = [UIColor blueColor];
            self.frdayButton2.tintColor = [UIColor blueColor];
            self.sadayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.sudayButton2)
    {
        if(self.sudayButton2.tintColor == [UIColor blueColor])
        {
            self.sudayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.sudayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.modayButton2)
    {
        if(self.modayButton2.tintColor == [UIColor blueColor])
        {
            self.modayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.modayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.tudayButton2)
    {
        if(self.tudayButton2.tintColor == [UIColor blueColor])
        {
            self.tudayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.tudayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.wedayButton2)
    {
        if(self.wedayButton2.tintColor == [UIColor blueColor])
        {
            self.wedayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.wedayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.thdayButton2)
    {
        if(self.thdayButton2.tintColor == [UIColor blueColor])
        {
            self.thdayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.thdayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.frdayButton2)
    {
        if(self.frdayButton2.tintColor == [UIColor blueColor])
        {
            self.frdayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.frdayButton2.tintColor = [UIColor blueColor];
        }
    }
    else if((UIButton *)sender == self.sadayButton2)
    {
        if(self.sadayButton2.tintColor == [UIColor blueColor])
        {
            self.sadayButton2.tintColor = [UIColor grayColor];
            self.everydayButton2.tintColor = [UIColor grayColor];
        }
        else
        {
            self.sadayButton2.tintColor = [UIColor blueColor];
        }
    }

}

-(IBAction)switchValueChanged:(id)sender
{
    if((UISwitch *)sender == self.alarmSwitch1)
    {
        if(self.alarmSwitch1.isOn == true)
        {
            self.everydayButton1.enabled = true;
            self.sudayButton1.enabled = true;
            self.modayButton1.enabled = true;
            self.tudayButton1.enabled = true;
            self.wedayButton1.enabled = true;
            self.thdayButton1.enabled = true;
            self.frdayButton1.enabled = true;
            self.sadayButton1.enabled = true;
            self.remindTimeTextField1.enabled = true;
        }
        else
        {
            self.everydayButton1.enabled = false;
            self.sudayButton1.enabled = false;
            self.modayButton1.enabled = false;
            self.tudayButton1.enabled = false;
            self.wedayButton1.enabled = false;
            self.thdayButton1.enabled = false;
            self.frdayButton1.enabled = false;
            self.sadayButton1.enabled = false;
            self.remindTimeTextField1.enabled = false;
        }
    }
    else if((UISwitch *)sender == self.alarmSwitch2)
    {
        if(self.alarmSwitch2.isOn == true)
        {
            self.everydayButton2.enabled = true;
            self.sudayButton2.enabled = true;
            self.modayButton2.enabled = true;
            self.tudayButton2.enabled = true;
            self.wedayButton2.enabled = true;
            self.thdayButton2.enabled = true;
            self.frdayButton2.enabled = true;
            self.sadayButton2.enabled = true;
            self.remindTimeTextField2.enabled = true;
        }
        else
        {
            self.everydayButton2.enabled = false;
            self.sudayButton2.enabled = false;
            self.modayButton2.enabled = false;
            self.tudayButton2.enabled = false;
            self.wedayButton2.enabled = false;
            self.thdayButton2.enabled = false;
            self.frdayButton2.enabled = false;
            self.sadayButton2.enabled = false;
            self.remindTimeTextField2.enabled = false;
        }
    }
}

-(void)initMyView
{
    self.everydayButton1.tintColor = [UIColor blueColor];
    self.sudayButton1.tintColor = [UIColor blueColor];
    self.modayButton1.tintColor = [UIColor blueColor];
    self.tudayButton1.tintColor = [UIColor blueColor];
    self.wedayButton1.tintColor = [UIColor blueColor];
    self.thdayButton1.tintColor = [UIColor blueColor];
    self.frdayButton1.tintColor = [UIColor blueColor];
    self.sadayButton1.tintColor = [UIColor blueColor];
    
    self.everydayButton2.tintColor = [UIColor blueColor];
    self.sudayButton2.tintColor = [UIColor blueColor];
    self.modayButton2.tintColor = [UIColor blueColor];
    self.tudayButton2.tintColor = [UIColor blueColor];
    self.wedayButton2.tintColor = [UIColor blueColor];
    self.thdayButton2.tintColor = [UIColor blueColor];
    self.frdayButton2.tintColor = [UIColor blueColor];
    self.sadayButton2.tintColor = [UIColor blueColor];
    
    
    //根据数据库的记录设置按钮状态
    NSDictionary *dic1 = [database selectUserAlarmRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] alarmcode:@"1"];
    NSDictionary *dic2 = [database selectUserAlarmRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] alarmcode:@"2"];
    
    if([[dic1 valueForKey:@"IsRemind"] isEqualToString:@"Y"])
    {
        alarmSwitch1.on = YES;
        self.everydayButton1.enabled = true;
        self.sudayButton1.enabled = true;
        self.modayButton1.enabled = true;
        self.tudayButton1.enabled = true;
        self.wedayButton1.enabled = true;
        self.thdayButton1.enabled = true;
        self.frdayButton1.enabled = true;
        self.sadayButton1.enabled = true;
        
        Byte b = 128;
        b = (Byte)[[dic1 valueForKey:@"RemindRule"] intValue];
        if(b>>7 == 1)
        {
            self.everydayButton1.tintColor = [UIColor blueColor];
            self.sudayButton1.tintColor = [UIColor blueColor];
            self.modayButton1.tintColor = [UIColor blueColor];
            self.tudayButton1.tintColor = [UIColor blueColor];
            self.wedayButton1.tintColor = [UIColor blueColor];
            self.thdayButton1.tintColor = [UIColor blueColor];
            self.frdayButton1.tintColor = [UIColor blueColor];
            self.sadayButton1.tintColor = [UIColor blueColor];
        }
        else if (b>>7 < 1)
        {
            self.everydayButton1.tintColor = [UIColor grayColor];
            if(b%128>>6 == 1)
            {
                self.sudayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.sudayButton1.tintColor = [UIColor grayColor];
            }
            if(b%64>>5 == 1)
            {
                self.modayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.modayButton1.tintColor = [UIColor grayColor];
            }
            if(b%32>>4 == 1)
            {
                self.tudayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.tudayButton1.tintColor = [UIColor grayColor];
            }
            if(b%16>>3 == 1)
            {
                self.wedayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.wedayButton1.tintColor = [UIColor grayColor];
            }
            if(b%8>>2 == 1)
            {
                self.thdayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.thdayButton1.tintColor = [UIColor grayColor];
            }
            if(b%4>>1 == 1)
            {
                self.frdayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.frdayButton1.tintColor = [UIColor grayColor];
            }
            if(b%2 == 1)
            {
                self.sadayButton1.tintColor = [UIColor blueColor];
            }
            else
            {
                self.sadayButton1.tintColor = [UIColor grayColor];
            }
        }
    }
    else
    {
        alarmSwitch1.on = NO;
        self.everydayButton1.enabled = false;
        self.sudayButton1.enabled = false;
        self.modayButton1.enabled = false;
        self.tudayButton1.enabled = false;
        self.wedayButton1.enabled = false;
        self.thdayButton1.enabled = false;
        self.frdayButton1.enabled = false;
        self.sadayButton1.enabled = false;
    }
    
    if([[dic2 valueForKey:@"IsRemind"] isEqualToString:@"Y"])
    {
        alarmSwitch2.on = YES;
        self.everydayButton2.enabled = true;
        self.sudayButton2.enabled = true;
        self.modayButton2.enabled = true;
        self.tudayButton2.enabled = true;
        self.wedayButton2.enabled = true;
        self.thdayButton2.enabled = true;
        self.frdayButton2.enabled = true;
        self.sadayButton2.enabled = true;
        
        Byte b = (Byte)[[dic2 valueForKey:@"RemindRule"] intValue];
        if(b>>7 == 1)
        {
            self.everydayButton2.tintColor = [UIColor blueColor];
            self.sudayButton2.tintColor = [UIColor blueColor];
            self.modayButton2.tintColor = [UIColor blueColor];
            self.tudayButton2.tintColor = [UIColor blueColor];
            self.wedayButton2.tintColor = [UIColor blueColor];
            self.thdayButton2.tintColor = [UIColor blueColor];
            self.frdayButton2.tintColor = [UIColor blueColor];
            self.sadayButton2.tintColor = [UIColor blueColor];
        }
        else if (b>>7 < 1)
        {
            self.everydayButton2.tintColor = [UIColor grayColor];
            if(b%128>>6 == 1)
            {
                self.sudayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.sudayButton2.tintColor = [UIColor grayColor];
            }
            if(b%64>>5 == 1)
            {
                self.modayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.modayButton2.tintColor = [UIColor grayColor];
            }
            if(b%32>>4 == 1)
            {
                self.tudayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.tudayButton2.tintColor = [UIColor grayColor];
            }
            if(b%16>>3 == 1)
            {
                self.wedayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.wedayButton2.tintColor = [UIColor grayColor];
            }
            if(b%8>>2 == 1)
            {
                self.thdayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.thdayButton2.tintColor = [UIColor grayColor];
            }
            if(b%4>>1 == 1)
            {
                self.frdayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.frdayButton2.tintColor = [UIColor grayColor];
            }
            if(b%2 == 1)
            {
                self.sadayButton2.tintColor = [UIColor blueColor];
            }
            else
            {
                self.sadayButton2.tintColor = [UIColor grayColor];
            }
        }
    }
    else
    {
        alarmSwitch2.on = NO;
        self.everydayButton2.enabled = false;
        self.sudayButton2.enabled = false;
        self.modayButton2.enabled = false;
        self.tudayButton2.enabled = false;
        self.wedayButton2.enabled = false;
        self.thdayButton2.enabled = false;
        self.frdayButton2.enabled = false;
        self.sadayButton2.enabled = false;
    }
    
    
    //设置界面闹铃时间的值
    self.remindTimeTextField1.text = [[NSString alloc]initWithFormat:@"%d:%d",[[dic1 valueForKey:@"RemindTime"] intValue]/60,[[dic1 valueForKey:@"RemindTime"] intValue]%60];
    self.remindTimeTextField2.text = [[NSString alloc]initWithFormat:@"%d:%d",[[dic2 valueForKey:@"RemindTime"] intValue]/60,[[dic2 valueForKey:@"RemindTime"] intValue]%60];
    //设置pickerview
    self.timePickerView = [[UIPickerView alloc]init];
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    self.remindTimeTextField1.inputView = self.timePickerView;
    self.remindTimeTextField2.inputView = self.timePickerView;
}

-(IBAction)saveBtnPressed:(id)sender
{
    int remindrule1 = 0;
    int remindtime1 = 0;
    NSString *isremind1 = @"N";
    if(alarmSwitch1.isOn == true)
    {
        isremind1 = @"Y";
    }
    NSString* timestr1 = remindTimeTextField1.text;
    NSArray *strlist1 = [timestr1 componentsSeparatedByString:@":"];
    int hour1 = [strlist1[0] intValue];
    int min1 = [strlist1[1] intValue];
    remindtime1 = hour1*60 + min1;
    
    if(self.everydayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 128;
    }
    if(self.sudayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 64;
    }
    if(self.modayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 32;
    }
    if(self.tudayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 16;
    }
    if(self.wedayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 8;
    }
    if(self.thdayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 4;
    }
    if(self.frdayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 2;
    }
    if(self.sadayButton1.tintColor == [UIColor blueColor])
    {
        remindrule1 += 1;
    }
    
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDictionary *dic1 = [database selectUserAlarmRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] alarmcode:@"1"];
    
    NSString *sql = @"";
    if(dic1 != nil){
        sql = [NSString stringWithFormat:@"UPDATE 'ALARMREMIND' SET ISREMIND = '%@',REMINDRULE = %d,REMINDTIME = %d WHERE USERNAME = '%@' AND ALARMCODE = '%@'", isremind1, remindrule1, remindtime1, username,@"1"];
    }
    else
    {
        sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'ALARMREMIND' ('USERNAME','ISREMIND','REMINDRULE', 'REMINDTIME', 'ALARMCODE') VALUES ('%@','%@','%d','%d','%@')", username, isremind1, remindrule1, remindtime1, @"1"];
    }
    
    bool b = [database insert:sql];
    if(b)
    {
        //do something
    }

    
    
    int remindrule2 = 0;
    int remindtime2 = 0;
    NSString *isremind2 = @"N";
    if(alarmSwitch2.isOn == true)
    {
        isremind2 = @"Y";
    }
    NSString* timestr2 = remindTimeTextField2.text;
    NSArray *strlist2 = [timestr2 componentsSeparatedByString:@":"];
    int hour2 = [strlist2[0] intValue];
    int min2 = [strlist2[1] intValue];
    remindtime2 = hour2*60 + min2;
    
    if(self.everydayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 128;
    }
    if(self.sudayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 64;
    }
    if(self.modayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 32;
    }
    if(self.tudayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 16;
    }
    if(self.wedayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 8;
    }
    if(self.thdayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 4;
    }
    if(self.frdayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 2;
    }
    if(self.sadayButton2.tintColor == [UIColor blueColor])
    {
        remindrule2 += 1;
    }
    
    NSString *username2 = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDictionary *dic2 = [database selectUserAlarmRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"] alarmcode:@"2"];
    
    NSString *sql2 = @"";
    if(dic2 != nil){
        sql2 = [NSString stringWithFormat:@"UPDATE 'ALARMREMIND' SET ISREMIND = '%@',REMINDRULE = %d,REMINDTIME = %d WHERE USERNAME = '%@' AND ALARMCODE = '%@'", isremind2, remindrule2, remindtime2, username2,@"2"];
    }
    else
    {
        sql2 = [[NSString alloc]initWithFormat:@"INSERT INTO 'ALARMREMIND' ('USERNAME','ISREMIND','REMINDRULE', 'REMINDTIME', 'ALARMCODE') VALUES ('%@','%@','%d','%d','%@')", username2, isremind2, remindrule2, remindtime2, @"2"];
    }
    
    bool b2 = [database insert:sql2];
    if(b2)
    {
        //do something
    }
    
    
    //命令发送
    Byte byte1 = 0;
    Byte byte2 = 0;
    Byte byte3 = 0;
    Byte byte4 = 0;
    Byte byte5 = 0;
    Byte byte6 = 0;
    if(alarmSwitch1.isOn == true)
    {
        byte1 += 128;
    }
    byte1 += hour1;
    byte2 = min1;
    byte3 = remindrule1;
    
    if(alarmSwitch2.isOn == true)
    {
        byte4 += 128;
    }
    
    byte4 += hour2;
    byte5 = min2;
    byte6 = remindrule2;
    
    Byte sendbyte1[] = {byte2,byte1,byte3,byte5,byte4,byte6};
    NSData *data1 = [[NSData alloc]initWithBytes:sendbyte1 length:sizeof(sendbyte1)];
    [[MySingleton sharedSingleton].myblecontroller setAlarmRemind:data1];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送", nil)
                                                        message:[[NSString alloc] initWithFormat:@"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x",sendbyte1[0],sendbyte1[1],sendbyte1[2],sendbyte1[3],sendbyte1[4],sendbyte1[5]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
}


-(void)endEdit:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(IBAction)canceledit:(id)sender
{
    [remindTimeTextField1 resignFirstResponder];
    [remindTimeTextField2 resignFirstResponder];
}

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([remindTimeTextField1 isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerhour = (int)row;
                break;
            case 2:
                self.pickermin = (int)row;
                break;
                
            default:
                break;
        }
        
        if(self.pickermin>=10)
        {
            remindTimeTextField1.text = [[NSString alloc]initWithFormat:@"%d:%d",self.pickerhour,self.pickermin];
        }
        else
        {
            remindTimeTextField1.text = [[NSString alloc]initWithFormat:@"%d:0%d",self.pickerhour,self.pickermin];
        }
    }
    else if ([remindTimeTextField2 isFirstResponder])
    {
        switch (component) {
            case 0:
                self.pickerhour = (int)row;
                break;
            case 2:
                self.pickermin = (int)row;
                break;
                
            default:
                break;
        }
        
        if(self.pickermin>=10)
        {
            remindTimeTextField2.text = [[NSString alloc]initWithFormat:@"%d:%d",self.pickerhour,self.pickermin];
        }
        else
        {
            remindTimeTextField2.text = [[NSString alloc]initWithFormat:@"%d:0%d",self.pickerhour,self.pickermin];
        }
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    if(pickerView == self.timePickerView)
    {
        switch (component) {
            case 0:
                result = 24;
                break;
            case 1:
                result = 1;
                break;
            case 2:
                result = 60;
                break;
            default:
                break;
        }
    }
    return result;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger result = 0;
    if(pickerView == self.timePickerView)
    {
        result = 3;
    }
    return result;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    if(pickerView == self.timePickerView)
    {
        switch (component) {
            case 0:
                title = [[NSString alloc]initWithFormat:@"%d",(int)row];
                break;
            case 1:
                title = @":";
                break;
            case 2:
                if(row>=10)
                {
                    title = [[NSString alloc]initWithFormat:@"%d",(int)row];
                }
                else
                {
                    title = [[NSString alloc]initWithFormat:@"0%d",(int)row];
                }
                break;
            default:
                break;
        }
    }
    return title;
}
@end
