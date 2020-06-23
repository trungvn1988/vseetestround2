//
//  FetchService.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FetchService;

@protocol FetchServiceDelegate <NSObject>

-(void) fetchDataSuccess:(NSArray*) arrContent;
-(void) fetchDataFailed;
//    - (void) myClassDelegateMethod: (MyClass *) sender;
@end

@interface FetchService : NSObject {
}

@property (nonatomic, weak) id <FetchServiceDelegate> fetchDelegate; //define MyClassDelegate as delegate

-(void) fetchData;

-(void) refreshData;

@end

NS_ASSUME_NONNULL_END
