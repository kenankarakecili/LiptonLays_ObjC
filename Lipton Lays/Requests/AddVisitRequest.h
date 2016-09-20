//
//  AddVisitRequest.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/3/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseRequest.h"
#import "Visit.h"

@interface AddVisitRequest : BaseRequest

- (instancetype)initWithVisit:(Visit *)visit;

@end
