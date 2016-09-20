//
//  ConnectionHandler.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "ConnectionHandler.h"

@implementation ConnectionHandler

+ (void)startConnectionWithRequest:(NSURLRequest *)request completion:(CompletionResult)resultData {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                               if (connectionError) {
                                   resultData(nil);
                               } else if (!data) {
                                   resultData(nil);
                               } else {
                                   resultData(data);
                               }
                           }];
}

+ (void)addTeamConnectionWithTeam:(Team *)team completion:(CompletionResult)resultData {
    AddTeamRequest *addTeamRequest = [[AddTeamRequest alloc] initWithTeam:team];
    [self startConnectionWithRequest:addTeamRequest completion:resultData];
}

+ (void)addVisitConnectionWithVisit:(Visit *)visit completion:(CompletionResult)resultData {
    AddVisitRequest *addVisitRequest = [[AddVisitRequest alloc] initWithVisit:visit];
    [self startConnectionWithRequest:addVisitRequest completion:resultData];
}

+ (void)getRequestConnectionWithUrlString:(NSString *)urlString completion:(CompletionResult)resultData {
    GetRequest *getRequest = [[GetRequest alloc] initWithUrlString:urlString];
    [self startConnectionWithRequest:getRequest completion:resultData];
}

@end
