//
//  CustomField.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "CustomField.h"
#import "Constants.h"

@implementation CustomField

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    layer.borderWidth = 1.f;
    layer.borderColor = liptonBlueColour().CGColor;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
