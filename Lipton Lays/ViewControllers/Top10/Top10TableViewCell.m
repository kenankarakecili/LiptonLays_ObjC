//
//  Top10TableViewCell.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/4/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "Top10TableViewCell.h"

@implementation Top10TableViewCell

- (void)awakeFromNib {
    self.cellNumberLabel.layer.cornerRadius = 2.f;
    self.cellNumberLabel.layer.masksToBounds = YES;
    self.cellVisitsLabel.layer.cornerRadius = 2.f;
    self.cellVisitsLabel.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

@end
