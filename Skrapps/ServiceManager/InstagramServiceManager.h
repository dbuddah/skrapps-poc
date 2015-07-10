//
//  InstagramServiceManager.h
//  Skrapps
//
//  Created by Doug McCoy on 7/9/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ServiceManager.h"

@interface InstagramServiceManager : NSObject <ServiceManager>

@property (nonatomic, strong) UIView *loginSuperView;

@end
