//
//  PhotoDetailsViewController.h
//  Instagram
//
//  Created by  Imtiyaz Jariwala on 1/25/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrModel.h"

@interface PhotoDetailsViewController : UIViewController

@property (nonatomic) TumblrModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *blogDetailImage;

@end
