//
//  BaseViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/1/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:nil
                                                                  action:nil];
    self.navigationController.navigationBar.tintColor = liptonRedColour();
    self.navigationItem.backBarButtonItem = backButton;
}

@end
