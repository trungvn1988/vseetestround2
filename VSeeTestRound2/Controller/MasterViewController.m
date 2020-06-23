//
//  MasterViewController.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CustomNewsCell.h"
#import "Articles.h"
#import <JGProgressHUD/JGProgressHUD.h>

@interface MasterViewController ()

@property NSArray *arrArticles;

@property (strong, nonatomic) UIRefreshControl* refreshControl;

@property (strong, nonatomic) JGProgressHUD* progressHud;

@property (nonatomic, strong) FetchService* fetchService;

@end

@implementation MasterViewController

@synthesize refreshControl, progressHud;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrArticles = [NSMutableArray new];
    self.fetchService = [FetchService new];
    self.fetchService.fetchDelegate = self;
    
    self.progressHud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    [self.progressHud showInView:self.view];
    [self.fetchService fetchData];
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshContent) forControlEvents:UIControlEventValueChanged];

    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = refreshControl;
    } else {
        [self.tableView addSubview:refreshControl];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Fetch Service

-(void) fetchDataSuccess:(NSArray *)arrContent{
    self.arrArticles = arrContent;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.progressHud dismissAnimated:YES];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

-(void) fetchDataFailed{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.progressHud dismissAnimated:YES];
        [self.refreshControl endRefreshing];
        UIAlertController *failedAlert = [UIAlertController alertControllerWithTitle:@"Demo App"
                                                                       message:@"Cannot get the news, please pull down to try again."
                                                                preferredStyle:UIAlertControllerStyleAlert]; // 1
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {NSLog(@"User confirm");}];
                                [failedAlert addAction:confirmAction];
        
                                [self presentViewController:failedAlert animated:YES completion:nil];
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        Articles* article = [self.arrArticles objectAtIndex:((NSIndexPath*)sender).row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setArticle:article];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrArticles.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellId = @"NewsCell";
    
    CustomNewsCell *cell = (CustomNewsCell*)[self.tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if(!cell){
        cell = [[CustomNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.article = [self.arrArticles objectAtIndex:indexPath.row];
    [cell fetchLayout];
    
    return cell;
}

-(void) refreshContent{
    // user pull down to force refresh content,do not check cache;
    [self.progressHud showInView:self.view];
    [self.fetchService refreshData];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

@end
