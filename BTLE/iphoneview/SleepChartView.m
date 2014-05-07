//
//  SleepChartView.m
//  BTLE
//
//  Created by 夏 伟 on 14-1-22.
//  Copyright (c) 2014年 夏 伟. All rights reserved.
//

#import "SleepChartView.h"

@implementation SleepChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myFrame = frame;
        [self initWithData:self.mySleepDataArray];
        [self setBackgroundColor:[UIColor greenColor]];
//        [self addSubview:btn];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSArray *)dataArray begintime:(NSDate *)begintime endtime:(NSDate *)endtime
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myFrame = frame;
        self.mySleepDataArray = dataArray;
        self.beginTime = begintime;
        self.endTime = endtime;
        if(self.mySleepDataArray.count != 0){
            [self initWithData:self.mySleepDataArray];
        }
        [self setBackgroundColor:[UIColor colorWithRed:118/250.0f green:93/256.0f blue:205/256.0f alpha:1.0]];
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
//        btn.backgroundColor = [UIColor redColor];
//        [btn addTarget:self action:@selector(qusi:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
    }
    return self;
}

-(void)qusi:(NSDictionary *)id
{
    NSLog(@"qusi");
}

-(void)initWithData :(NSArray *)dataArray
{
//    if(dataArray.count == 0||dataArray == nil)
//    {
//        return;
//    }
    
//    dataArray = @[@"2:360",@"1:256",@"3:846"];
    
    NSTimeInterval time = [self.endTime timeIntervalSinceDate:self.beginTime];
    int totaltime = (int)(time/60);//单位分
    int didtime = 0;
    
    for (int i = 0; i<dataArray.count; i++) {
        
        if([dataArray[i] isEqualToString:@""])
        {
            continue;
        }
        
        NSArray *onedata = [dataArray[i] componentsSeparatedByString:@":"];
        int status = [onedata[0] intValue];
        int min = [onedata[1] intValue];
        
        int width = (int)((double)min/totaltime*(self.myFrame.size.width-20));
        int x = 10 + (int)((double)didtime/totaltime*(self.myFrame.size.width-20));
        didtime += min;
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        CGRect btnframe;
        UIColor *backgroundColor;
        if(status == 1){//清醒
            btnframe = CGRectMake(x,
                                   20,
                                   width,
                                   self.myFrame.size.height-40 );
            backgroundColor = [UIColor colorWithRed:254/250.0f green:145/256.0f blue:29/256.0f alpha:1.0];
        }
        else if(status == 2)//浅睡
        {
            btnframe = CGRectMake(x,
                                   20 + (self.myFrame.size.height-40)*1/3,
                                   width,
                                   (self.myFrame.size.height-40)*2/3);
            backgroundColor = [UIColor colorWithRed:25/250.0f green:211/256.0f blue:252/256.0f alpha:1.0];
        }
        else if(status == 3)//熟睡
        {
            btnframe = CGRectMake(x,
                                   20 + (self.myFrame.size.height-40)*2/3,
                                   width,
                                   (self.myFrame.size.height-40)*1/3);
            backgroundColor = [UIColor colorWithRed:28/250.0f green:146/256.0f blue:237/256.0f alpha:1.0];
            
        }
        else
        {
            
        }

        UIButton *btn = [[UIButton alloc]initWithFrame:btnframe];
        btn.backgroundColor = backgroundColor;
        [btn addTarget:self action:@selector(qusi:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
