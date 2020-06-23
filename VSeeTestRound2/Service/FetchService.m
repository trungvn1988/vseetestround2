//
//  FetchService.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "FetchService.h"
#import "Articles.h"
#import "CachingService.h"

#define fixedAPI @"https://newsapi.org/v2/top-headlines?country=us&apiKey=383e8a167a4a46c1883e64516ddde9eb"

@implementation FetchService

@synthesize fetchDelegate;

/**
 ignored cache data will force the application to refresh the news even it has cached files.
 */

-(void) refreshData{
    [self loadDataCheckCache:NO];
}

-(void) fetchData{
    [self loadDataCheckCache:YES];
}

-(void) loadDataCheckCache:(BOOL) checkCache{
    if(checkCache){
        // load cache first.
        NSError* unarchiveError;
        NSData* cachedData = [[CachingService new] loadCache];
        NSArray* cachedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[Articles class], [NSMutableArray class], [NSDictionary class], [NSNull class], nil] fromData:cachedData error:&unarchiveError];

        if(!unarchiveError){
            if(cachedArray && cachedArray.count > 0){
                NSLog(@"From Cached");
                [self.fetchDelegate fetchDataSuccess:cachedArray];
                return;
            }
        }
    }
    
    // call fixed api.
    
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];

    // Setup the request with URL
    NSURL *url = [NSURL URLWithString:fixedAPI];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    // Create dataTask
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //JSON Parssing
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if(!results){
            [self.fetchDelegate fetchDataFailed];
            return;
        }
        
        NSString* status = results[@"status"];
        if ([status isEqualToString:@"ok"]){
            [[CachingService new] removeCache];
            
            NSMutableArray* arrResult = [NSMutableArray new];
            
            NSArray* arrContent = results[@"articles"];
            // mapping model.
            for (NSDictionary* content in arrContent) {
                Articles* singleArticles = [Articles new];
                singleArticles.author = content[@"author"];
                singleArticles.content = content[@"content"];
                singleArticles.lblDescription = content[@"description"];
                singleArticles.publishedAt = content[@"publishedAt"];
                singleArticles.title = content[@"title"];
                singleArticles.url = content[@"url"];
                singleArticles.urlToImage = content[@"urlToImage"];
                singleArticles.source = content[@"source"];
                
                [arrResult addObject:singleArticles];
            }
            
            [self.fetchDelegate fetchDataSuccess:arrResult];
            [[CachingService new] saveCache:arrResult];

        }else{
            [self.fetchDelegate fetchDataFailed];
        }
    }];

    // Fire the request
    [dataTask resume];
}

@end
