//
//  MasterViewController.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>
#import <JGProgressHUD/JGProgressHUD.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) UIRefreshControl* refreshControl;

@property (strong, nonatomic) JGProgressHUD* progressHud;

@end
