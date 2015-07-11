//
//  Comment.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment


-(instancetype)initWithText:(NSString*)text
                createdTime:(NSDate*)createdTime
                         ID:(NSString*)ID
                   fromUser:(User*)fromUser
{
    self = [super init];
    if (self) {
        _text           = text.copy;
        _createdTime    = createdTime.copy;
        _ID             = ID.copy;
        _fromUser       = fromUser;
    }
    return self;
}

@end




@implementation CommentBuilder

+(Comment*)buildCommentFromJSON:(NSDictionary*)JSON
{
    // TODO: parse real json
    NSString *createdDate = JSON[@"created_time"];
    return [[Comment alloc] initWithText:JSON[@"text"]
                             createdTime:[NSDate dateWithTimeIntervalSince1970:createdDate.doubleValue ]
                                      ID:JSON[@"id"]
                                fromUser:[UserBuilder buildUserFromJSON:JSON[@"from"]]];
}

+(NSArray*)buildCommentsFromJSON:(NSDictionary*)JSON
{
    NSMutableArray *comments = [NSMutableArray new];
    NSLog(@"%@", JSON);
    for (NSDictionary *comment in JSON[@"data"]) {
        Comment *c = [CommentBuilder buildCommentFromJSON:comment];
        [comments addObject:c];
    }
    return [comments copy];
}

@end