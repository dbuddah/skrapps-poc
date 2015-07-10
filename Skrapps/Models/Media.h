//
//  Media.h
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


typedef enum MediaType
{
    MediaTypeImage,
    MediaTypeVideo,
    MediaTypeAudio,
} MediaType;

@interface Media : NSObject

@property (readonly) NSString*  ID;
@property (readonly) MediaType  mediaType;
@property (readonly) NSArray    *tags; // NSString
@property (readonly) NSArray    *comments; // Comment
@property (readonly) NSArray    *likes; // TBD
@property (readonly) NSString   *caption;
@property (readonly) User       *user;
@property (readonly) NSDate     *createdTime;


@property (readonly) NSDictionary   *images; //"low_resolution", "thumbnail", "standard_resolution"

@property (readonly) NSDictionary *videos; //"low_resolution", "standard_resolution"

@property (readonly) NSDictionary *audios; //"low_resolution", "standard_resolution"


-(instancetype)initWithID: (NSString*)  ID
                mediaType:(MediaType)  mediaType
                     tags:(NSArray*)tags
                 comments:(NSArray*)comments
                    likes:(NSArray*)likes 
                  caption:(NSString*)caption
                     user:(User*)user
              createdTime:(NSDate*)createdTime;

@end




@interface MediaBuilder : NSObject 

+(Media*)buildMediaFromJSON:(NSDictionary*)JSON;


@end
