//
//  UIImage+FixOrientation.m
//  FuPhoto
//
//  Created by Kenan Karakecili on 18.02.2014.
//  Copyright (c) 2014 Magis. All rights reserved.
//

#import "UIImage+FixOrientation.h"

@implementation UIImage (FixOrientation)

- (UIImage *)resizedImageRatio:(CGFloat)ratio {
    CGSize originalSize = self.size;
    CGSize newSize = CGSizeMake(originalSize.width * ratio, originalSize.height * ratio);
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)normalizedImageWithRatio:(CGFloat)ratio {
    UIImage *imageToReturn = [UIImage imageWithCGImage:self.CGImage
                                                 scale:self.scale
                                           orientation:self.imageOrientation];
    imageToReturn = [imageToReturn resizedImageRatio:ratio];
    return imageToReturn;
}

- (UIImage*)rotateUIImageClockwise:(BOOL)clockwise {
    CGSize size = self.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[self CGImage]
                         scale:1.f
                   orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft]
     drawInRect:CGRectMake(0,0,size.height ,size.width)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
