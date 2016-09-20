//
//  Top10TableViewCell.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/4/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Top10TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellVisitsLabel;
@end
