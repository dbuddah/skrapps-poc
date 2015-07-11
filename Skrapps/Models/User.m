//
//  User.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithUsername:(NSString*)username
                 profilePicture:(NSString*)profilePicture
                             ID:(NSString*)ID
                       fullName:(NSString*)fullName
{
    self = [super init];
    if (self) {
        _username       = username.copy;
        _profilePicture = profilePicture.copy;
        _ID             = ID.copy;
        _fullName       = fullName.copy;
    }
    return self;
}


@end


@implementation UserBuilder

+(User*)buildUserFromJSON:(NSDictionary*)JSON
{
    // TODO: parse real json
    return [[User alloc] initWithUsername:JSON[@"username"]
                           profilePicture:JSON[@"profile_picture"]
                                       ID:JSON[@"id"]
                                 fullName:JSON[@"full_name"]];
}
@end