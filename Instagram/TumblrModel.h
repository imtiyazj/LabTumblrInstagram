//
//  TumblrModel.h
//  Instagram
//
//  Created by  Imtiyaz Jariwala on 1/25/17.
//  Copyright © 2017 yahoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *) dictionary;

@property (nonatomic, strong) NSString *blogName;
@property (nonatomic, strong) NSURL *blogImage;
@property (nonatomic, strong) NSURL *authorImage;

@end
