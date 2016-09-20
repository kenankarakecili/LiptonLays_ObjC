//
//  VisitTableViewCell.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPlaceNameLabel;
@end
