//
//  Articles.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Articles : NSObject <NSSecureCoding>

@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* lblDescription;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* urlToImage;
@property (nonatomic, strong) NSString* publishedAt;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSDictionary* source;

@end

NS_ASSUME_NONNULL_END
