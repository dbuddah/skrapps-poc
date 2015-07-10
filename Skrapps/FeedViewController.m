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


@interface FeedViewController () <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

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
    [serviceManager getFeed:^(NSError *error, id JSON) {
        if (!error) {
            NSLog(@"%@", JSON);
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
    return 300;
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
    
    mediaCell.timeStampLabel.text = [NSDate date].description;
    mediaCell.usernameLabel.text = @"fake User name";
    mediaCell.likesLabel.text = @"XX likes";
    mediaCell.commentsLabel.text = @"XX comments";
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
}

@end
