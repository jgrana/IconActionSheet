//
//  IconActionSheet.m
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import "IconActionSheet.h"

@implementation IconActionSheet

@synthesize blocks;
@synthesize collectionView;

static UIImage *background = nil;
static UIFont *titleFont = nil;
static UIFont *buttonFont = nil;

static NSString *cellIdentifier = @"ActionCell";

#pragma mark - init

+ (void)initialize
{
    if (self == [IconActionSheet class])
    {
        background = [UIImage imageNamed:kActionSheetBackground];
        background = [background stretchableImageWithLeftCapWidth:0 topCapHeight:kActionSheetBackgroundCapHeight];
        titleFont = kActionSheetTitleFont;
        buttonFont = kActionSheetButtonFont;
    }
}

+ (id)sheetWithTitle:(NSString *)title
{
    return [[IconActionSheet alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title
{
    CGRect frame = [[UIApplication sharedApplication] keyWindow].bounds;
    
    if ((self = [super initWithFrame:frame]))
    {
        
        self.blocks = [[NSMutableArray alloc] init];
        _height = kActionSheetTopMargin;
        
        if (title)
        {
            CGSize size = [title sizeWithFont:titleFont
                            constrainedToSize:CGSizeMake(frame.size.width-kActionSheetBorder*2, 1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kActionSheetBorder, _height, frame.size.width-kActionSheetBorder*2, size.height)];
            labelView.font = titleFont;
            labelView.numberOfLines = 0;
            labelView.lineBreakMode = NSLineBreakByWordWrapping;
            labelView.textColor = kActionSheetTitleTextColor;
            labelView.backgroundColor = [UIColor clearColor];
            labelView.textAlignment = NSTextAlignmentCenter;
            labelView.shadowColor = kActionSheetTitleShadowColor;
            labelView.shadowOffset = kActionSheetTitleShadowOffset;
            labelView.text = title;
            [self addSubview:labelView];
            
            _height += size.height + 5;
        }
    }
    
    return self;
}

- (void)addIconWithTitle:(NSString *)title image:(UIImage*)image block:(void (^)())block atIndex:(NSInteger)index
{
    if (index >= 0)
    {
        [self.blocks insertObject:[NSArray arrayWithObjects:
                               block ? [block copy] : [NSNull null],
                               title,
                               image,
                               nil]
                      atIndex:index];
    }
    else
    {
        [self.blocks addObject:[NSArray arrayWithObjects:
                            block ? [block copy] : [NSNull null],
                            title,
                            image,
                            nil]];
    }
}

- (void)dismissView
{
    CGPoint center = self.center;
    center.y += self.bounds.size.height;
    [UIView animateWithDuration:kAnimationDuration
                          delay:0.0
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         self.center = center;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)showInView:(UIView *)parentView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setItemSize:CGSizeMake(kCellWidth, kCellHeight)];
    [flowLayout setMinimumInteritemSpacing:kItemSpacing];
    //Increased icon border to be close to apple implementation
    [flowLayout setMinimumLineSpacing:kLineSpacing];
    
    double columns = floor((self.frame.size.width-kActionSheetBorder*2) / (kCellWidth+kItemSpacing));
    double rows = ceil(blocks.count / columns);
    
    //Limit maximum rows to 3
    rows = rows > 3 ? 3 : rows;
    

    int flowheight = rows * (kCellHeight+kLineSpacing);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kActionSheetBorder+8, _height, self.frame.size.width-(kActionSheetBorder+8)*2,flowheight) collectionViewLayout:flowLayout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView setBounces:NO];
    [self.collectionView registerClass:[ActionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.collectionView];
    
    _height += self.collectionView.frame.size.height + kActionSheetBorder;
    
    //Create Cancel button
    NSString *title = @"Cancel";
    
    UIImage *image = [UIImage imageNamed:@"action-black-button.png"];
    image = [image stretchableImageWithLeftCapWidth:(int)(image.size.width)>>1 topCapHeight:0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kActionSheetBorder, _height, self.bounds.size.width-kActionSheetBorder*2, kActionSheetButtonHeight);
    button.titleLabel.font = buttonFont;
    //button.titleLabel.minimumFontSize = 6;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.shadowOffset = kActionSheetButtonShadowOffset;
    button.backgroundColor = [UIColor clearColor];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitleColor:kActionSheetButtonTextColor forState:UIControlStateNormal];
    [button setTitleShadowColor:kActionSheetButtonShadowColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.accessibilityLabel = title;
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    _height += button.frame.size.height + kActionSheetBorder;    
    
    UIImageView *modalBackground = [[UIImageView alloc] initWithFrame:self.bounds];
    modalBackground.image = background;
    modalBackground.contentMode = UIViewContentModeScaleToFill;
    [self insertSubview:modalBackground atIndex:0];

    [parentView addSubview:self];
    
    CGRect frame = self.frame;
    frame.origin.y = parentView.frame.size.height;
    frame.size.height = _height + kActionSheetBounce;
    self.frame = frame;
    
    __block CGPoint center = self.center;
    center.y -= _height + kActionSheetBounce;
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         self.center = center;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              center.y += kActionSheetBounce;
                                              self.center = center;
                                          } completion:nil];
                     }];
}

#pragma mark - Action

- (void)buttonClicked:(id)sender
{
    [self dismissView];
}

#pragma mark - View Collection Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return blocks.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = [blocks objectAtIndex:indexPath.row];
    
    ActionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.label.text = [data objectAtIndex:1];
    cell.image.image = [data objectAtIndex:2];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id obj = [[self.blocks objectAtIndex:indexPath.row] objectAtIndex:0];
    if (![obj isEqual:[NSNull null]])
    {
        ((void (^)())obj)();
    }
}

@end