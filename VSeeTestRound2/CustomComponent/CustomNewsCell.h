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

@property (strong, nonatomic) IBOutlet UILabel* lblTitle;
@property (strong, nonatomic) IBOutlet UILabel* lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView* imgNews;
@property (strong, nonatomic) IBOutlet UILabel* lblTimestamp;
@property (strong, nonatomic) Articles* article;

@end

NS_ASSUME_NONNULL_END
