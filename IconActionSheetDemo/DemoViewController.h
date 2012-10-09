//
//  DemoViewController.h
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconActionSheet.h"

@interface DemoViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UILabel *label;

- (IBAction)showActionSheet:(id)sender;

@end
