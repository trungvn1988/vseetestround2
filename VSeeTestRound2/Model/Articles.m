//
//  Articles.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "Articles.h"

@implementation Articles

@synthesize author,title, lblDescription, url, urlToImage, publishedAt, content;
@synthesize source;

#define kAuthor @"kAuthor"
#define kTitle @"kTitle"
#define kDesc @"kDesc"
#define kUrl @"kUrl"
#define kUrlToImage @"kUrlToImage"
#define kPublistAt @"kPublistAt"
#define kContent @"kContent"
#define kSource @"kSource"

// to stored this object into nsuserdefault, we have to implement our key-value coding manually.

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.author forKey:kAuthor];
    [coder encodeObject:self.title forKey:kTitle];
    [coder encodeObject:self.lblDescription forKey:kDesc];
    [coder encodeObject:self.url forKey:kUrl];
    [coder encodeObject:self.urlToImage forKey:kUrlToImage];
    [coder encodeObject:self.publishedAt forKey:kPublistAt];
    [coder encodeObject:self.content forKey:kContent];
    [coder encodeObject:self.source forKey:kSource];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        author = [coder decodeObjectForKey:kAuthor];
        title = [coder decodeObjectForKey:kTitle];
        lblDescription = [coder decodeObjectForKey:kDesc];
        url = [coder decodeObjectForKey:kUrl];
        urlToImage = [coder decodeObjectForKey:kUrlToImage];
        publishedAt = [coder decodeObjectForKey:kPublistAt];
        content = [coder decodeObjectForKey:kContent];
        source = [coder decodeObjectForKey:kSource];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
   return YES;
}

@end
