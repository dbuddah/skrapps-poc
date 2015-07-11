//
//  InstagramServiceManager.m
//  Skrapps
//
//  Created by Doug McCoy on 7/9/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "InstagramServiceManager.h"
#import <AFNetworking/AFNetworking.h>
#import "AppDelegate.h"

#import "Media.h"


static const NSString *clientID = @"6962ac9915e44af78e50aa9ead5766d6";
static const NSString *redirectURI = @"http://fliptalkapp.com";

@interface InstagramServiceManager () <UIWebViewDelegate>

@property (strong) NSString *accessToken;
@property (strong) void (^authHandler)(NSError *);
@end

@implementation InstagramServiceManager

+(instancetype)sharedManager
{
    static InstagramServiceManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = InstagramServiceManager.new;
    });
    return manager;
}

-(void)authenticate:(void (^)(NSError *))handler
{
    NSError *error = nil;
    self.authHandler = handler;

    NSURL *URL = [NSURL URLWithString:@"https://instagram.com/oauth/authorize/"];

    NSDictionary *parameters = @{@"client_id": clientID,
                                 @"redirect_uri": redirectURI,
                                 @"response_type": @"token"
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:[URL absoluteString] parameters:parameters error:nil];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.loginSuperView.bounds];
    [self.loginSuperView addSubview:webView];
    webView.delegate = self;
    [webView loadRequest:request];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //    [indicator startAnimating];
    if ([[[request URL] host] isEqualToString:@"fliptalkapp.com"]) {
        
        // Extract oauth_verifier from URL query
        NSArray* urlParams = [[[request URL] fragment] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"access_token"]) {
                self.accessToken = [keyValue objectAtIndex:1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.authHandler) {
                        self.authHandler(nil);
                        self.authHandler = nil;
                    }
                });
                break;
            }
        }
        [webView removeFromSuperview];
        return NO;
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.authHandler) {
            self.authHandler(error);
            self.authHandler = nil;
        }
    });

}


-(void)getFeed:(void (^)(NSError *error, NSArray *mediaItems))feedHandler
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"access_token": self.accessToken};
    [manager GET:@"https://api.instagram.com/v1/users/self/feed" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *mediaJSON = responseObject[@"data"];
        
        NSMutableArray *mediaItems = [[NSMutableArray alloc] initWithCapacity:mediaJSON.count];
        
        for (NSDictionary *mediaItemJSON in mediaJSON) {
            Media *mediaItem = [MediaBuilder buildMediaFromJSON:mediaItemJSON];
            [mediaItems addObject:mediaItem];
        }
        if (feedHandler) {
            feedHandler(nil, mediaItems);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (feedHandler) {
            feedHandler(error, nil);
        }
    }];
}

-(void)getProfile:(void (^)(NSError *, id))profileHandler
{
    NSError *error = nil;
    NSDictionary *JSON = nil;
    
    
    if (profileHandler) {
        profileHandler(error, JSON);
    }
    
}

@end
