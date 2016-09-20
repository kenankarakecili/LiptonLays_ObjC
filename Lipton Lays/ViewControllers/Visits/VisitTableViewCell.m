//
//  VisitTableViewCell.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "VisitTableViewCell.h"

@implementation VisitTableViewCell

- (void)awakeFromNib {
    self.cellTimeLabel.layer.cornerRadius = 2.f;
    self.cellTimeLabel.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
}

@end
