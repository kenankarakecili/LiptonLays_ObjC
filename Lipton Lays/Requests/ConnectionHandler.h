//
//  ConnectionHandler.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "AddTeamRequest.h"
#import "AddVisitRequest.h"
#import "GetRequest.h"

typedef void(^CompletionResult)(NSData *resultData);

@interface ConnectionHandler : NSObject

+ (void)addTeamConnectionWithTeam:(Team *)team completion:(CompletionResult)resultData;

+ (void)getRequestConnectionWithUrlString:(NSString *)urlString completion:(CompletionResult)resultData;

+ (void)addVisitConnectionWithVisit:(Visit *)visit completion:(CompletionResult)resultData;

@end
