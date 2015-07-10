//
//  ViewController.m
//  Skrapps
//
//  Created by Doug McCoy on 7/9/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "ViewController.h"
#import "InstagramServiceManager.h"


@interface ViewController () <UIWebViewDelegate>
{
    
}
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    InstagramServiceManager *serviceManager = [InstagramServiceManager sharedManager];
    serviceManager.loginSuperView = self.view;
    [serviceManager authenticate:^(NSError *error) {
        if (!error) {
            [serviceManager getFeed:^(NSError *error, id JSON) {
                if (!error) {
                    NSLog(@"%@", JSON);
                }
                else
                    NSLog(@"%@", error);
            }];
        }

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
