//
//  ViewController.m
//  系统时钟
//
//  Created by 万艳勇 on 2017/10/16.
//  Copyright © 2017年 SKOrganization. All rights reserved.
//

#import "ViewController.h"
// 每一秒旋转的角度
#define perSec 6
#define perMIn 6
#define perHour 30

// 每一分旋转时针旋转的角度
#define perMInHour 0.5 // 30度 / 60分


#define angleToRad(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) CALayer *secL; // 秒针
@property (weak, nonatomic) CALayer *minL; // 分针
@property (weak, nonatomic) CALayer *hourL; // 分针
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加时针
    [self setHour];
    // 添加分针
    [self setMin];
    // 添加秒针
    [self setSec];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:true];
    [self timeChange];
}

- (void)timeChange{
    // 获取当前多少秒
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger curSec = cmp.second + 1;
    
    // 秒针开始旋转
    // 计算秒针当前旋转的角度
    // angle = 当前多少秒 + 每一秒旋转多少度
    CGFloat secA = (curSec * perSec);
    self.secL.transform = CATransform3DMakeRotation(angleToRad(secA), 0, 0, 1);
    
    // 分针开始旋转
    // 计算分针当前旋转的角度
    // angle = 当前多少分 + 每一分钟旋转多少度
    NSInteger curMIn = cmp.minute;
    CGFloat secB = (curMIn * perMIn);
    self.minL.transform = CATransform3DMakeRotation(angleToRad(secB), 0, 0, 1);
    
    
    // 时针开始旋转
    // 计算时针当前旋转的角度
    // angle = 当前多少时 + 每一小时旋转多少度
    
    NSInteger curHour = cmp.hour;
    CGFloat secC = (curHour * perHour + curMIn * perMInHour);
    self.hourL.transform = CATransform3DMakeRotation(angleToRad(secC), 0, 0, 1);
}

// 设置秒针
- (void)setSec{
    CALayer *secL = [CALayer layer];
    secL.bounds = CGRectMake(0, 0, 1, 40);
    secL.backgroundColor = [UIColor redColor].CGColor;
    secL.anchorPoint = CGPointMake(0.5, 1);// 设置锚点
    secL.position = CGPointMake(self.bgImageView.bounds.size.width * 0.5 + 0.5, self.bgImageView.bounds.size.height * 0.5 + 0.5);
    self.secL = secL;
    [self.bgImageView.layer addSublayer:secL];
}

// 设置分针
- (void)setMin{
    CALayer *minL = [CALayer layer];
    minL.bounds = CGRectMake(0, 0, 1.5, 37);
    minL.backgroundColor = [UIColor blackColor].CGColor;
    minL.anchorPoint = CGPointMake(0.5, 1);// 设置锚点
    minL.position = CGPointMake(self.bgImageView.bounds.size.width * 0.5 + 0.5, self.bgImageView.bounds.size.height * 0.5 + 0.5);
    self.minL = minL;
    [self.bgImageView.layer addSublayer:minL];
}
// 设置时针
- (void)setHour{
    CALayer *hourL = [CALayer layer];
    hourL.bounds = CGRectMake(0, 0, 1.5,30);
    hourL.backgroundColor = [UIColor blackColor].CGColor;
    hourL.anchorPoint = CGPointMake(0.5, 1);// 设置锚点
    hourL.position = CGPointMake(self.bgImageView.bounds.size.width * 0.5 + 0.5, self.bgImageView.bounds.size.height * 0.5 + 0.5);
    self.hourL = hourL;
    [self.bgImageView.layer addSublayer:hourL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
