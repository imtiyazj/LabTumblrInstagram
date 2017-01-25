//
//  ViewController.m
//  Instagram
//
//  Created by  Imtiyaz Jariwala on 1/25/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import "PhotosViewController.h"
#import "TumblrModel.h"
#import "TumblrTableViewCell.h"
#import "PhotoDetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) NSMutableArray *tumblrPosts;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tumblrPosts = [NSMutableArray new];
    
    self.tumbleTableView.rowHeight = 320;
    self.tumbleTableView.dataSource = self;
    self.tumbleTableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tumbleTableView insertSubview:self.refreshControl atIndex:0];
    
    //https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar/?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV
    
    NSString *apiKey = @"Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV";
    NSString *urlString =
    [@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=" stringByAppendingString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    //NSLog(@"Response: %@", responseDictionary);
                                                    
                                                    NSArray *posts = responseDictionary[@"response"][@"posts"];
                                                    for (NSDictionary *post in posts) {
                                                        TumblrModel *model = [[TumblrModel alloc] initWithDictionary: post];
                                                        
                                                        [self.tumblrPosts addObject:model];
                                                    }
                                                    [self.tumbleTableView reloadData];
                                                    
                                                    NSLog(@"tumblrPosts: %@", self.tumblrPosts);
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tumblrPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"MOVIE COUNT: %li", self.tumblrPosts.count);
    TumblrTableViewCell *list = [tableView dequeueReusableCellWithIdentifier:@"tumblrCell" forIndexPath:indexPath];
    TumblrModel *model = [self.tumblrPosts objectAtIndex:indexPath.row];
    
    list.blogImage.contentMode = UIViewContentModeScaleAspectFill;
    [list.blogImage setImageWithURL:model.blogImage];
    
    return list;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"IN didSelectRowAtIndexPath ---");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoDetailsViewController *detailsController = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tumbleTableView indexPathForCell:sender];
    
    detailsController.model = [self.tumblrPosts objectAtIndex:indexPath.row];
}

- (void)onRefresh {
    
    NSString *apiKey = @"Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV";
    NSString *urlString =
    [@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=" stringByAppendingString:apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (!connectionError) {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:kNilOptions
                                              error:&jsonError];
            //NSLog(@"Response: %@", responseDictionary);
            
            [self.tumblrPosts removeAllObjects];
            
            NSArray *posts = responseDictionary[@"response"][@"posts"];
            for (NSDictionary *post in posts) {
                TumblrModel *model = [[TumblrModel alloc] initWithDictionary: post];
                
                [self.tumblrPosts addObject:model];
            }
            [self.tumbleTableView reloadData];
            
            NSLog(@"tumblrPosts: %@", self.tumblrPosts);
        } else {
            NSLog(@"An error occurred: %@", connectionError.description);
        }
        
        [self.refreshControl endRefreshing];
    }];
}

@end
