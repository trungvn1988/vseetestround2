//
//  CustomNewsCell.m
//  VSeeTestRound2
//
//  Created by Mac mini on 6/23/20.
//  Copyright © 2020 Mac mini. All rights reserved.
//

#import "CustomNewsCell.h"
#import <SDWebImage/SDWebImage.h>

@implementation CustomNewsCell

@synthesize titleLabel, timestampLabel, descriptionLabel, newsImage, article;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) fetchLayout{
    self.newsImage.layer.borderWidth = 1;
    self.newsImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.titleLabel.text = article.title;
    self.descriptionLabel.text = article.lblDescription;
    self.timestampLabel.text = article.publishedAt;
    
    [self.newsImage sd_setImageWithURL:[NSURL URLWithString:article.urlToImage]];
}

@end
