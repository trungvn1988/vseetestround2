//
//  CachingService.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CachingService : NSObject

-(void) removeCache;

-(void) saveCache:(NSArray*) arrArticles;

-(NSData*) loadCache;

@end

NS_ASSUME_NONNULL_END
