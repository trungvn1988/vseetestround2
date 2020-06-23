//
//  DetailViewController.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

