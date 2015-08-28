//
//  ViewController.m
//  widget.app
//
//  Created by Constantine Mars on 8/27/15.
//  Copyright © 2015 Constantine Mars. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stop;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    self.stop.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    self.label.hidden=NO;
    self.stop.hidden=NO;
}

- (IBAction)stop:(id)sender {
    self.label.hidden=YES;
    self.stop.hidden=YES;
}
@end
