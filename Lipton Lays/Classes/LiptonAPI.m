//
//  LiptonAPI.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "LiptonAPI.h"

typedef void(^Response)(id response);

@implementation LiptonAPI

+ (LiptonAPI *)sharedAPI {
    static LiptonAPI *liptonAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        liptonAPI = [[LiptonAPI alloc] init];
    });
    return liptonAPI;
}

- (void)startParsingWithData:(NSData *)data completion:(Response)response {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        id JsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            response(JsonObject);
        });
    });
}

- (void)addTeam:(Team *)team completion:(ResponseDictionary)responseDictionary {
    [ConnectionHandler addTeamConnectionWithTeam:team completion:^(NSData *resultData) {
        [self startParsingWithData:resultData completion:^(id response) {
            responseDictionary(response);
        }];
    }];
}

- (void)addVisit:(Visit *)visit completion:(ResponseDictionary)responseDictionary {
    [ConnectionHandler addVisitConnectionWithVisit:visit completion:^(NSData *resultData) {
        [self startParsingWithData:resultData completion:^(id response) {
            responseDictionary(response);
        }];
    }];
}

- (void)getRequestWithUrlString:(NSString *)urlString completion:(ResponseObject)responseObject {
    [ConnectionHandler getRequestConnectionWithUrlString:urlString completion:^(NSData *resultData) {
        [self startParsingWithData:resultData completion:^(id response) {
            responseObject(response);
        }];
    }];
}

@end
