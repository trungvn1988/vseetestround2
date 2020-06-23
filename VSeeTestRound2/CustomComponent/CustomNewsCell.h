//
//  CustomNewsCell.h
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Articles.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomNewsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* titleLabel;
@property (strong, nonatomic) IBOutlet UILabel* descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView* newsImage;
@property (strong, nonatomic) IBOutlet UILabel* timestampLabel;
@property (strong, nonatomic) Articles* article;

-(void) fetchLayout;

@end

NS_ASSUME_NONNULL_END
