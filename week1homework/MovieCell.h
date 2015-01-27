//
//  MovieCell.h
//  week1homework
//
//  Created by Weiyan Lin on 1/25/15.
//  Copyright (c) 2015 Weiyan Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@property (weak, nonatomic) IBOutlet UIImageView *thumb;

@end
