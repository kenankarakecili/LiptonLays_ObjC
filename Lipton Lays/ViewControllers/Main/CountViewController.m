//
//  CountViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/5/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "CountViewController.h"

@interface CountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@property (strong, nonatomic) NSTimer *timer;
@end

@implementation CountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self startTimer];
}

#pragma mark - Timer
- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countDown)
                                                    userInfo:nil
                                                     repeats:YES];
    self.timer = timer;
}

- (void)countDown {
    NSInteger countDownNumber = self.countDownLabel.text.integerValue;
    countDownNumber--;
    self.countDownLabel.text = [NSString stringWithFormat:@"%d", (int)countDownNumber];
    if (countDownNumber == 0) {
        [self.timer invalidate];
        [self performSegueWithIdentifier:@"CountVC_to_CreateTeamVC" sender:nil];
        [self.navigationController setNavigationBarHidden:NO];
    }
}

@end
