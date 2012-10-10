//
//  DemoViewController.m
//  IconActionSheetDemo
//
//  Created by Jonathan Grana on 10/7/12.
//  Copyright (c) 2012 Jonathan Grana. All rights reserved.
//

#import "DemoViewController.h"

@implementation DemoViewController

@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (IBAction)showActionSheet:(id)sender
{
    __weak IconActionSheet *sheet = [IconActionSheet sheetWithTitle:@"Icon Action Sheet Demo"];
    
    [sheet addIconWithTitle:@"Facebook" image:[UIImage imageNamed:@"Facebook.png"] block:^{
        label.text = @"You selected the facebook icon!";
        [sheet dismissView];
    } atIndex:-1];
    [sheet addIconWithTitle:@"Contacts" image:[UIImage imageNamed:@"Contacts.png"] block:^{
        label.text = @"You selected the contacts icon!";
        [sheet dismissView];
    } atIndex:-1];
    [sheet addIconWithTitle:@"Mail" image:[UIImage imageNamed:@"Mail.png"] block:^{
        label.text = @"You selected the mail icon!";
        [sheet dismissView];
    } atIndex:-1];
    [sheet addIconWithTitle:@"Settings" image:[UIImage imageNamed:@"Settings.png"] block:^{
        label.text = @"You selected the settings icon!";
        [sheet dismissView];
    } atIndex:-1];
    [sheet addIconWithTitle:@"Contacts" image:[UIImage imageNamed:@"iMessage.png"] block:^{
        label.text = @"You selected the message icon!";
        [sheet dismissView];
    } atIndex:-1];
    [sheet addIconWithTitle:@"Camera" image:[UIImage imageNamed:@"Camera.png"] block:^{
        label.text = @"You selected the camera icon!";
        [sheet dismissView];
    } atIndex:-1];
    
    [sheet showInView:self.view];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
