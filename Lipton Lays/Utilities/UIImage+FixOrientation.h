//
//  UIImage+FixOrientation.h
//  FuPhoto
//
//  Created by Kenan Karakecili on 18.02.2014.
//  Copyright (c) 2014 Magis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)

- (UIImage *)normalizedImageWithRatio:(CGFloat)ratio;

- (UIImage *)resizedImageRatio:(CGFloat)ratio;

@end
