//
//  TumblrModel.m
//  Instagram
//
//  Created by  Imtiyaz Jariwala on 1/25/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import "TumblrModel.h"

@implementation TumblrModel

- (instancetype)initWithDictionary:(NSDictionary *) dictionary {
    
    self = [super init];
    if (self) {
        self.blogName = dictionary[@"blog_name"];
        
        NSString *urlString = dictionary[@"photos"][0][@"original_size"][@"url"];
        
        self.blogImage = [NSURL URLWithString:urlString];
        
        self.authorImage = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    }
    return self;
}


@end
