//
//  DetailViewController.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize article, newsWebView;

- (void) loadURL {
    NSLog(@"%@", article.url);
    [self.newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.url]]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [self loadURL];
}


#pragma mark - Managing the detail item

@end
