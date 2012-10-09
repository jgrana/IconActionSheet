//
//  IconActionSheet.h
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>
#import "ActionCell.h"

#ifndef IconActionSheet_h
#define IconActionSheet_h

// IconActionSheet constants

#define kActionSheetBounce         10
#define kActionSheetBorder         10
#define kActionSheetButtonHeight   45
#define kActionSheetTopMargin      15

#define kActionSheetTitleFont           [UIFont systemFontOfSize:18]
#define kActionSheetTitleTextColor      [UIColor whiteColor]
#define kActionSheetTitleShadowColor    [UIColor blackColor]
#define kActionSheetTitleShadowOffset   CGSizeMake(0, -1)

#define kActionSheetButtonFont          [UIFont boldSystemFontOfSize:20]
#define kActionSheetButtonTextColor     [UIColor whiteColor]
#define kActionSheetButtonShadowColor   [UIColor blackColor]
#define kActionSheetButtonShadowOffset  CGSizeMake(0, -1)

#define kActionSheetBackground              @"action-sheet-panel.png"
#define kActionSheetBackgroundCapHeight     30

#endif

@interface IconActionSheet : UIView <UICollectionViewDelegate, UICollectionViewDataSource> {
@private
    CGFloat _height;
}

@property (nonatomic, strong) NSMutableArray *blocks;
@property (nonatomic, strong) UICollectionView *collectionView;

+ (id)sheetWithTitle:(NSString *)title;

- (id)initWithTitle:(NSString *)title;

- (void)addIconWithTitle:(NSString *)title image:(UIImage*)image block:(void (^)())block atIndex:(NSInteger)index;
- (void)showInView:(UIView *)view;
- (void)dismissView;

@end
