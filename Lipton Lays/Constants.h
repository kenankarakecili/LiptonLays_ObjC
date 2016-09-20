//
//  Constants.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/1/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

@import UIKit;
#import "CustomField.h"
#import "Reachability.h"
#import "UIImage+FixOrientation.h"

#pragma mark - URLs
static NSString *const LIBaseRequest = @"http://api.yediginizictiginizayrigitmesin.com/";
static NSString *const LIAddTeamRequest = @"Register/AddTeam";
static NSString *const LIGetLocationRequest = @"Content/GetLocation?token=";
static NSString *const LIAddVisitRequest = @"Register/AddLocation";
static NSString *const LIGetVisitDetailRequest = @"Content/GetLocationDetail/";
static NSString *const LIGetTop10Request = @"Content/Top10";

#pragma mark - Messages
static NSString *const LIServiceErrorMessage = @"Sistemsel bir hatadan dolayı işleminizi yerine getiremiyoruz, lütfen daha sonra tekrar deneyiniz.";
static NSString *const LINetworkErrorMessage = @"Lütfen internet bağlantınızı kontrol ediniz";

#pragma mark - Keys
static NSString *const LIStoredTokenItemKey = @"LIStoredTokenItemKey";
static NSString *const LIShowLoadingNotificationKey = @"LIShowLoadingNotificationKey";

#pragma mark - Functions
static inline NSString *getDeleteVisitRequest(NSString *visitId, NSString *token) {
    return [NSString stringWithFormat:@"Content/LocationDelete/%@?token=%@", visitId, token];
}

static inline UIColor *liptonBlueColour() {
    return [UIColor colorWithRed:0.f green:174.f/255.f blue:239.f/255.f alpha:1.f];
}


static inline UIColor *liptonRedColour() {
    return [UIColor colorWithRed:237.f/255.f green:28.f/255.f blue:36.f/255.f alpha:1.f];
}

static inline UIColor *liptonYellowColour() {
    return [UIColor colorWithRed:1.f green:242.f/255.f blue:0.f alpha:1.f];
}

static inline void showMessageOnly(NSString *message) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Tamam"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

static inline BOOL networkReachable() {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    }
    return YES;
}

static inline void showLoading(BOOL show) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:LIShowLoadingNotificationKey
                                                            object:nil
                                                          userInfo:@{@"show" : @(show)}];
    });
}