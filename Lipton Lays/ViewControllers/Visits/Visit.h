//
//  Visit.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Visit : NSObject
@property (copy, nonatomic) NSString *locationId;
@property (copy, nonatomic) NSString *locationName;
@property (copy, nonatomic) NSString *time;
@property (strong, nonatomic) NSArray *imageArray;
@end
