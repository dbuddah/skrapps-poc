//
//  ViewController.m
//  Skrapps
//
//  Created by Doug McCoy on 7/9/15.
//  Copyright (c) 2015 skrapps. All rights reserved.
//

#import "FeedViewController.h"
#import "InstagramServiceManager.h"
#import "MediaCell.h"
#import "Media.h"
#import "AFNetworking/UIImageView+AFNetworking.h"


@interface FeedViewController () <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *mediaItems;
@end

@implementation FeedViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    InstagramServiceManager *serviceManager = [InstagramServiceManager sharedManager];
    serviceManager.loginSuperView = self.view;
    [serviceManager authenticate:^(NSError *error) {
        if (!error) {
            [self refreshUserFeed];
        }

    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshUserFeed
{
    InstagramServiceManager *serviceManager = [InstagramServiceManager sharedManager];
    [serviceManager getFeed:^(NSError *error, NSArray *mediaItems) {
        if (!error) {
            NSLog(@"%@", mediaItems);
            self.mediaItems = mediaItems;
            [self.tableview reloadData];
            
        }
        else
            NSLog(@"%@", error);
    }];

}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.mediaItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MediaCell" forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediaCell *mediaCell = (MediaCell*)cell;
    
    Media *item = self.mediaItems[indexPath.row];
    mediaCell.timeStampLabel.text = item.createdTime.description;
    mediaCell.usernameLabel.text = item.user.username;
    mediaCell.likesLabel.text = [NSString stringWithFormat:@"%lu Likes", (unsigned long)item.likes.count];
    mediaCell.commentsLabel.text = [NSString stringWithFormat:@"%lu Comments", (unsigned long)item.comments.count];
    
    [mediaCell.avatarImageView setImageWithURL:[NSURL URLWithString:item.user.profilePicture]];
    [mediaCell.mediaImageView setImageWithURL:[NSURL URLWithString:item.images[@"standard_resolution"][@"url"]]];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
}

@end
