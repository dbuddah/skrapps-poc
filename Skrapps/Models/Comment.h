//
//  Comment.h
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject

@property (readonly) NSString   *text;
@property (readonly) NSString   *ID;
@property (readonly) NSDate     *createdTime;
@property (readonly) User       *fromUser;

-(instancetype)initWithText:(NSString*)text
                createdTime:(NSDate*)createdTime
                         ID:(NSString*)ID
                   fromUser:(User*)fromUser;


@end


@interface CommentBuilder : NSObject

+(Comment*)buildCommentFromJSON:(NSDictionary*)JSON;
+(NSArray*)buildCommentsFromJSON:(NSDictionary*)JSON;

@end


