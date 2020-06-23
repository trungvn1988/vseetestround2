//
//  MasterViewController.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchService.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, FetchServiceDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

