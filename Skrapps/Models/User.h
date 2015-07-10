//
//  User.h
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (readonly) NSString *username;
@property (readonly) NSString *profilePicture;
@property (readonly) NSString *ID;
@property (readonly) NSString *fullName;

-(instancetype)initWithUsername:(NSString*)username
                 profilePicture:(NSString*)profilePicture
                             ID:(NSString*)ID
                       fullName:(NSString*)fullName;


@end


@interface UserBuilder : NSObject

+(User*)buildUserFromJSON:(NSDictionary*)JSON;

@end
