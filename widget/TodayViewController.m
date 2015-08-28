//
//  TodayViewController.m
//  widget
//
//  Created by Constantine Mars on 8/27/15.
//  Copyright © 2015 Constantine Mars. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define RATE_KEY @"kUDRate"

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *barView;

@property (nonatomic, assign) double size;
@end

@implementation TodayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    [self update];
    double oldR=[self rate];
    if(self.size - oldR < 0.001){
        completionHandler(NCUpdateResultNoData);
    } else{

    [self updateUI];
    
    completionHandler(NCUpdateResultNewData);
    }
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    defaultMarginInsets.bottom=10;
    return defaultMarginInsets;
}

-(void)update {
    NSDictionary* d=[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    long long sys=[[d valueForKey:NSFileSystemSize] unsignedLongLongValue];
    long long free=[[d valueForKey:NSFileSystemFreeSize] unsignedLongLongValue];
    long long fs=[[d valueForKey:NSFileSystemSize] unsignedLongLongValue];
    self.size=((double)(sys-free))/(double)fs;
}

-(double)rate{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:RATE_KEY] doubleValue];
}

-(void)setRate:(double)r{
    NSUserDefaults* d=[NSUserDefaults standardUserDefaults];
    [d setValue:[NSNumber numberWithDouble:r] forKey:RATE_KEY];
    [d synchronize];
}

-(void) updateUI{
    double r=[self rate];
    self.percentLabel.text=[NSString stringWithFormat:@"%.1f%%", r*100];
    self.barView.progress=r;
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self update];
    [self updateUI];
}


@end
