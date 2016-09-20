//
//  PhotoDetailViewController.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/5/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PhotoDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.photoUrlString];
    [self.imageView sd_setImageWithURL:url];
}

@end
