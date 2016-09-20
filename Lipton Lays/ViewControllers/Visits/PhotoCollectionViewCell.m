//
//  PhotoCollectionViewCell.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Constants.h"

@implementation PhotoCollectionViewCell

//- (void)prepareForReuse {
//    
//}

- (void)awakeFromNib {
    self.contentView.layer.cornerRadius = 2.f;
    self.contentView.layer.borderWidth = 1.f;
    self.contentView.layer.borderColor = liptonYellowColour().CGColor;
    self.contentView.layer.masksToBounds = YES;
}

@end
