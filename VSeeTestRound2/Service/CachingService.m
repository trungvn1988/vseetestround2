//
//  CachingService.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "CachingService.h"

@implementation CachingService

-(void) removeCache{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cached"];
}

-(void) saveCache:(NSArray*) arrArticles{
    NSError* errorWhenCache;
    NSData* dataCache = [NSKeyedArchiver archivedDataWithRootObject:arrArticles requiringSecureCoding:NO error:&errorWhenCache];
    
    NSLog(@"errorWhenCache %@", errorWhenCache);
    
    [[NSUserDefaults standardUserDefaults] setObject:dataCache forKey:@"cached"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSData*) loadCache{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cached"];
}

@end
