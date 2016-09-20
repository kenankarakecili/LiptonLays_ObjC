//
//  Team.m
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "Team.h"

@implementation Team

- (instancetype)initWithName:(NSString *)name firstMemberName:(NSString *)firstMemberName firstMemberSurname:(NSString *)firstMemberSurname secondMemberName:(NSString *)secondMemberName secondMemberSurname:(NSString *)secondMemberSurname thirdMemberName:(NSString *)thirdMemberName thirdMemberSurname:(NSString *)thirdMemberSurname {
    self = [super init];
    if (self) {
        _name = name;
        _firstMemberName = firstMemberName;
        _firstMemberSurname = firstMemberSurname;
        _secondMemberName = secondMemberName;
        _secondMemberSurname = secondMemberSurname;
        _thirdMemberName = thirdMemberName;
        _thirdMemberSurname = thirdMemberSurname;
    }
    return self;
}

@end
