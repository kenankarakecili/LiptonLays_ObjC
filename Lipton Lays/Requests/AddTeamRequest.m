//
//  AddTeamRequest.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "AddTeamRequest.h"

@implementation AddTeamRequest

- (instancetype)initWithTeam:(Team *)team {
    self = [super initWithMethodType:@"POST"];
    if (self) {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", LIBaseRequest, LIAddTeamRequest];
        self.URL = [NSURL URLWithString:urlString];
        NSDictionary *dictionary = @{
                                     @"TeamName" : [NSString stringWithFormat:@"%@", team.name],
                                     @"FirstMemberName" : [NSString stringWithFormat:@"%@", team.firstMemberName],
                                     @"FirstMemberSurname" : [NSString stringWithFormat:@"%@", team.firstMemberSurname],
                                     @"SecondMemberName" : [NSString stringWithFormat:@"%@", team.secondMemberName],
                                     @"SecondMemberSurname" : [NSString stringWithFormat:@"%@", team.secondMemberSurname],
                                     @"ThirdMemberName" : [NSString stringWithFormat:@"%@", team.thirdMemberName],
                                     @"ThirdMemberSurname" : [NSString stringWithFormat:@"%@", team.thirdMemberSurname]
                                     };
        self.HTTPBody = [self dataFromObject:dictionary];
    }
    return self;
}

@end
