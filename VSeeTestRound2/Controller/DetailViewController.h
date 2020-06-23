//
//  DetailViewController.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Articles.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet WKWebView* newsWebView;
@property (strong, nonatomic) Articles* article;

@end

