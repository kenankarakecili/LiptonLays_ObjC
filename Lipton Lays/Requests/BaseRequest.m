//
//  BaseRequest.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (instancetype)initWithMethodType:(NSString *)methodType {
    self = [super init];
    if (self) {
        [self addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        self.HTTPMethod = methodType;
    }
    return self;
}

- (NSData *)dataFromObject:(id)object {
    return [NSJSONSerialization dataWithJSONObject:object
                                           options:NSJSONWritingPrettyPrinted
                                             error:nil];
}

@end
