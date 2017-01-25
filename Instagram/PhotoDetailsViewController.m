//
//  PhotoDetailsViewController.m
//  Instagram
//
//  Created by  Imtiyaz Jariwala on 1/25/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface PhotoDetailsViewController ()

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.blogDetailImage setImageWithURL:self.model.blogImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
