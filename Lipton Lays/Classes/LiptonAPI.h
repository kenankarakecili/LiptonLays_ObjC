//
//  LiptonAPI.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "ConnectionHandler.h"

typedef void(^ResponseObject)(id responseObject);
typedef void(^ResponseDictionary)(NSDictionary *responseDictionary);

@interface LiptonAPI : NSObject

+ (LiptonAPI *)sharedAPI;

- (void)addTeam:(Team *)team completion:(ResponseDictionary)responseDictionary;

- (void)addVisit:(Visit *)visit completion:(ResponseDictionary)responseDictionary;

- (void)getRequestWithUrlString:(NSString *)urlString completion:(ResponseObject)responseObject;

@end
