//
//  GetRequest.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseRequest.h"

@interface GetRequest : BaseRequest

- (instancetype)initWithUrlString:(NSString *)urlString;

@end
