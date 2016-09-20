//
//  Team.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

@import Foundation;

@interface Team : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *firstMemberName;
@property (copy, nonatomic) NSString *firstMemberSurname;
@property (copy, nonatomic) NSString *secondMemberName;
@property (copy, nonatomic) NSString *secondMemberSurname;
@property (copy, nonatomic) NSString *thirdMemberName;
@property (copy, nonatomic) NSString *thirdMemberSurname;

- (instancetype)initWithName:(NSString *)name
             firstMemberName:(NSString *)firstMemberName
          firstMemberSurname:(NSString *)firstMemberSurname
            secondMemberName:(NSString *)secondMemberName
         secondMemberSurname:(NSString *)secondMemberSurname
             thirdMemberName:(NSString *)thirdMemberName
          thirdMemberSurname:(NSString *)thirdMemberSurname;

@end
