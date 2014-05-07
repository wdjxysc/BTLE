//
//  SportRemindViewController.m
//  BTLE
//
//  Created by 夏 伟 on 14-2-12.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "SportRemindViewController.h"
#import "MySingleton.h"
#import "database.h"

@interface SportRemindViewController ()

@end

@implementation SportRemindViewController
@synthesize sportRemindLabel;
@synthesize sportRemindSwitch;
@synthesize timeintervalLabel;
@synthesize timeintervalTextField;
@synthesize timeintervalUnitLabel;
@synthesize beginTimeLabel;
@synthesize beginTimeTextField;
@synthesize endTimeLabel;
@synthesize endTimeTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"运动提醒";
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

-(IBAction)saveBtnPressed:(id)sender
{
    NSString *isremind = @"N";
    int isremindint = 0;
    if([sportRemindSwitch isSelected])
    {
        isremind = @"Y";
        isremindint = 1;
    }
    NSString* begintimestr = beginTimeTextField.text;
    NSArray *beginstrlist = [begintimestr componentsSeparatedByString:@":"];
    int beginhour = [beginstrlist[0] intValue];
    int beginmin = [beginstrlist[1] intValue];
    
    NSString* endtimestr = endTimeTextField.text;
    NSArray *endstrlist = [endtimestr componentsSeparatedByString:@":"];
    int endhour = [endstrlist[0] intValue];
    int endmin = [endstrlist[1] intValue];
    
    int timeinterval = [timeintervalTextField.text intValue];
    
    NSString *username = [[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"];
    NSDictionary *dic = [database selectUserSportRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"]];
    NSString *sql = @"";
    if(dic != nil){
        sql = [NSString stringWithFormat:@"UPDATE 'SPORTREMIND' SET ISREMIND = '%@',REMINDINTERVAL = %d,BEGINTIME = %d, ENDTIME = %d WHERE USERNAME = '%@'", isremind, timeinterval*60, beginhour*60 + beginmin, endhour*60 + endmin, username];
    }
    else
    {
        sql = [[NSString alloc]initWithFormat:@"INSERT INTO 'SPORTREMIND' ('USERNAME','ISREMIND','REMINDINTERVAL', 'BEGINTIME', 'ENDTIME') VALUES ('%@','%@','%d','%d','%d')", username, isremind, timeinterval*60, beginhour*60 + beginmin, endhour*60 + endmin];
    }
    
    bool b = [database insert:sql];
    if(b)
    {
        //do something
    }
    
    Byte sendbyte1[] = {(Byte)isremind,(Byte)timeinterval,beginmin,beginhour,endmin,endhour};
    NSData *data1 = [[NSData alloc]initWithBytes:sendbyte1 length:sizeof(sendbyte1)];
    [[MySingleton sharedSingleton].myblecontroller setSportRemind:data1];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送", nil)
                                                        message:[[NSString alloc] initWithFormat:@"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x",sendbyte1[0],sendbyte1[1],sendbyte1[2],sendbyte1[3],sendbyte1[4],sendbyte1[5]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
    [alertView show];
    
}

-(void)initMyView
{
    NSDictionary *dic = [database selectUserSportRemind:[[MySingleton sharedSingleton].nowuserinfo valueForKey:@"UserName"]];
    if([dic valueForKey:@"IsRemind"])
    {
        sportRemindSwitch.on = YES;
    }
    else
    {
        sportRemindSwitch.on = NO;
    }
    
    timeintervalTextField.text = [[NSString alloc]initWithFormat:@"%d", [[dic valueForKey:@"RemindInterval"] intValue]/60];
    beginTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:%d",[[dic valueForKey:@"BeginTime"] intValue]/60,[[dic valueForKey:@"BeginTime"] intValue]%60];
    endTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:%d",[[dic valueForKey:@"EndTime"] intValue]/60,[[dic valueForKey:@"EndTime"] intValue]%60];
    
    
    //设置pickerview
    self.intervaltimePickerView = [[UIPickerView alloc] init];
    self.intervaltimePickerView.dataSource = self;
    self.intervaltimePickerView.delegate = self;
    self.timeintervalTextField.inputView = self.intervaltimePickerView;
    self.timePickerView = [[UIPickerView alloc]init];
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    self.endTimeTextField.inputView = self.timePickerView;
    self.beginTimeTextField.inputView = self.timePickerView;
}

-(void)endEdit:(UITextField *)textField
{
    [textField resignFirstResponder];
}

-(IBAction)canceledit:(id)sender
{
    [self.timeintervalTextField resignFirstResponder];
    [self.endTimeTextField resignFirstResponder];
    [self.beginTimeTextField resignFirstResponder];
}

- (IBAction)View_TouchDown:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == self.timePickerView){
        if([self.beginTimeTextField isFirstResponder])
        {
            switch (component) {
                case 0:
                    self.pickerhour = row;
                    break;
                case 2:
                    self.pickermin = row;
                    break;
                    
                default:
                    break;
            }
            
            if(self.pickermin>10)
            {
                self.beginTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:%d",self.pickerhour,self.pickermin];
            }
            else
            {
                self.beginTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:0%d",self.pickerhour,self.pickermin];
            }
        }
        else if ([self.endTimeTextField isFirstResponder])
        {
            switch (component) {
                case 0:
                    self.pickerhour = row;
                    break;
                case 2:
                    self.pickermin = row;
                    break;
                    
                default:
                    break;
            }
            
            if(self.pickermin>10)
            {
                self.endTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:%d",self.pickerhour,self.pickermin];
            }
            else
            {
                self.endTimeTextField.text = [[NSString alloc]initWithFormat:@"%d:0%d",self.pickerhour,self.pickermin];
            }
        }
    }
    else if(pickerView == self.intervaltimePickerView)
    {
        if([self.timeintervalTextField isFirstResponder])
        {
            switch (component) {
                case 0:
                    self.timeintervalTextField.text = [[NSString alloc]initWithFormat:@"%d", row + 1];
                    break;
                    
                default:
                    break;
            }
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
    else if(pickerView == self.intervaltimePickerView)
    {
        switch (component) {
            case 0:
                result = 12;
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
    else if(pickerView == self.intervaltimePickerView)
    {
        result = 1;
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
                title = [[NSString alloc]initWithFormat:@"%d",row];
                break;
            case 1:
                title = @":";
                break;
            case 2:
                if(row>=10)
                {
                    title = [[NSString alloc]initWithFormat:@"%d",row];
                }
                else
                {
                    title = [[NSString alloc]initWithFormat:@"0%d",row];
                }
                break;
            default:
                break;
        }
    }
    else if(pickerView == self.intervaltimePickerView)
    {
        switch (component) {
            case 0:
                title = [[NSString alloc] initWithFormat:@"%d",row + 1];
                break;
                
            default:
                break;
        }
    }
    return title;
}

@end
