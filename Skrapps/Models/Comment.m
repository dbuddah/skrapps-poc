//
//  Comment.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "Comment.h"

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
    return [[Comment alloc] initWithText:@"faketext"
                             createdTime:[NSDate distantPast ]
                                      ID:@"fakeID"
                                fromUser:nil];
}

+(NSArray*)buildCommentsFromJSONArray:(NSArray*)JSON
{
    NSMutableArray *comments = [NSMutableArray new];
    for (NSDictionary *comment in JSON) {
        Comment *c = [CommentBuilder buildCommentFromJSON:comment];
        [comments addObject:c];
    }
    return [comments copy];
}

@end