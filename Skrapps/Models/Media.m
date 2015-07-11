//
//  Media.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "Media.h"
#import "Comment.h"
#import "User.h"

@implementation Media


-(instancetype)initWithID: (NSString*)  ID
                mediaType:(MediaType)  mediaType
                   images:(NSDictionary*)images
                     tags:(NSArray*)tags
                 comments:(NSArray*)comments
                    likes:(NSArray*)likes
                  caption:(NSString*)caption
                     user:(User*)user
              createdTime:(NSDate*)createdTime
{
    
    self = [super init];
    if (self) {
        _ID = ID.copy;
        _mediaType = mediaType;
        _images = images;
        _tags = tags;
        _comments = comments;
        _likes = likes;
        _caption = caption;
        _user = user;
        _createdTime = createdTime;
    }
    return self;
}

@end




@implementation MediaBuilder

+(Media*)buildMediaFromJSON:(NSDictionary*)JSON
{
    // TODO: parse real json
    
    NSString *timestamp = JSON[@"created_time"];
    NSDictionary *captionObj = JSON[@"caption"];
    NSString *caption;
    if ((NSNull*)captionObj != [NSNull null]) {
        caption = captionObj[@"text"];
    }
    
    return [[Media alloc] initWithID:JSON[@"id"]
                           mediaType:MediaTypeImage
                              images:JSON[@"images"]
                                tags:JSON[@"tags"]
                            comments:[CommentBuilder buildCommentsFromJSON:JSON[@"comments"]]
                               likes:@[]
                             caption:caption
                                user:[UserBuilder buildUserFromJSON:JSON[@"user"]]
                         createdTime:[NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue]];
}
@end