//
//  GetRequest.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "GetRequest.h"

@implementation GetRequest

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super initWithMethodType:@"GET"];
    if (self) {
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.URL = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
