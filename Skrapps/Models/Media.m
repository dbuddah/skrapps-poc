//
//  Media.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "Media.h"

@implementation Media


-(instancetype)initWithID: (NSString*)  ID
                mediaType:(MediaType)  mediaType
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
    return [[Media alloc] initWithID:@"fake ID"
                           mediaType:MediaTypeImage
                                tags:@[@"fake tag"]
                            comments:@[]
                               likes:@[]
                             caption:@"fake caption"
                                user:nil
                         createdTime:[NSDate date]];
}
@end