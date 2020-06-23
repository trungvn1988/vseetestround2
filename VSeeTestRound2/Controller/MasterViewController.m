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

@interface MasterViewController ()

@property NSMutableArray *arrArticles;

@end

@implementation MasterViewController

@synthesize refreshControl, progressHud;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrArticles = [NSMutableArray new];
    [self fetchContent:TRUE];
    
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


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        Articles* article = [self.arrArticles objectAtIndex:((NSIndexPath*)sender).row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.article = article;
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
    
    cell.imgNews.layer.borderWidth = 1;
    cell.imgNews.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    Articles* article = [self.arrArticles objectAtIndex:indexPath.row];
    cell.lblTitle.text = article.title;
    cell.lblDescription.text = article.lblDescription;
    cell.lblTimestamp.text = article.publishedAt;
    
    [cell.imgNews sd_setImageWithURL:[NSURL URLWithString:article.urlToImage]];
    
    return cell;
}

/**
 ignored cache data will force the application to refresh the news even it has cached files.
 */
-(void) fetchContent:(BOOL) checkCache{
    if(checkCache){
        // load cache first.
        NSError* unarchiveError;
        NSData* cachedData = [self loadCache];
        NSArray* cachedArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[Articles class] fromData:cachedData error:&unarchiveError];
        
        if(!unarchiveError){
            self.arrArticles = [cachedArray mutableCopy];
            if(self.arrArticles && self.arrArticles.count > 0){
                [self.tableView reloadData];
                return;
            }
        }
    }
    
    self.progressHud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    [self.progressHud showInView:self.view];
    
    // call fixed api.
    NSString* fixedAPI = @"https://newsapi.org/v2/top-headlines?country=us&apiKey=383e8a167a4a46c1883e64516ddde9eb";
    
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
            [self fetchContentFailed];
            return;
        }
        
        NSString* status = results[@"status"];
        if ([status isEqualToString:@"ok"]){
            [self.arrArticles removeAllObjects];
            [self removeCache]; // remove old cache.
            
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
                
                [self.arrArticles addObject:singleArticles];
            }

            NSError* errorWhenCache;
            [self saveCache:[NSKeyedArchiver archivedDataWithRootObject:self.arrArticles requiringSecureCoding:NO error:&errorWhenCache]];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.progressHud dismissAnimated:YES];
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            }];

        }else{
            [self fetchContentFailed];
        }
    }];

    // Fire the request
    [dataTask resume];
}

-(void) fetchContentFailed{
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

-(void) refreshContent{
    // user pull down to force refresh content,do not check cache;
    [self fetchContent:FALSE];
}

-(void) removeCache{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cached"];
}

-(void) saveCache:(NSData*) dataNews{
    [[NSUserDefaults standardUserDefaults] setObject:dataNews forKey:@"cached"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSData*) loadCache{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cached"];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}

@end
