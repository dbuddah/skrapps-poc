//
//  MediaCell.m
//  Skrapps
//
//  Created by Doug McCoy on 7/10/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "MediaCell.h"

@interface MediaCell ()

@end

@implementation MediaCell

-(void)prepareForReuse
{
    self.mediaImageView.image = nil;
    self.avatarImageView.image = nil;
}

@end
