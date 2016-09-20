//
//  AddTeamRequest.h
//  Lipton Lays
//
//  Created by Kenan Karakecili on 8/2/15.
//  Copyright (c) 2015 Kenan Karakecili. All rights reserved.
//

#import "BaseRequest.h"
#import "Team.h"

@interface AddTeamRequest : BaseRequest

- (instancetype)initWithTeam:(Team *)team;

@end
