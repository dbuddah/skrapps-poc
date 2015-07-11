//
//  ServiceManager.h
//  Skrapps
//
//  Created by Doug McCoy on 7/9/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#ifndef Skrapps_ServiceManager_h
#define Skrapps_ServiceManager_h


@protocol ServiceManager <NSObject>

+(instancetype)sharedManager;
-(void)authenticate:(void (^)(NSError*))handler;;
-(void)getFeed:     (void (^)(NSError *error, NSArray *mediaItems))feedHandler;
-(void)getProfile:  (void (^)(NSError *error, id JSON))profileHandler;


// TBD: many more API



@end

#endif
