//
//  ActionCell.h
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import <UIKit/UIKit.h>

//ActionCell Constants

#define kCellWidth      70
#define kCellHeight     80

@interface ActionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *label;

@end
