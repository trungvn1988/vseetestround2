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

@property (nonatomic, retain) NSString* author;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* lblDescription;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSString* urlToImage;
@property (nonatomic, retain) NSString* publishedAt;
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSDictionary* source;

@end

NS_ASSUME_NONNULL_END
