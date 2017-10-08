<a target='_blank' rel='nofollow' href='https://app.codesponsor.io/link/iNjcrsi5nMUaWnoY98rBLzLn/jgrana/IconActionSheet'>
  <img alt='Sponsor' width='888' height='68' src='https://app.codesponsor.io/embed/iNjcrsi5nMUaWnoY98rBLzLn/jgrana/IconActionSheet.svg' />
</a>

Icon Action Sheet Demo
=========

# Version History

10/8/2012 - Initial Commit

# Introduction

This project contains a reusable classes for presenting a view that imitates the uiactivityviewcontroller in iOS. In iOS 6 the button based action sheet has been replaced in several Apple apps with a controller that contains friendlier space saving icons. This class allows people to easily reproduce this same control using blocks and allows for easier customizations than the uiactivityviewcontroller.

![][1]

# Using the class

By default a cancel button is added to the view. A title can be specified for the action sheet. Icons with labels and blocks can be added as well. Please see below for an example.

    IconActionSheet *sheet = [IconActionSheet sheetWithTitle:@"Icon Action Sheet Demo"];
        
    [sheet addIconWithTitle:@"Camera" image:[UIImage imageNamed:@"Facebook.png"] block:^{
        //Do things
    } atIndex:-1];    
    [sheet showInView:self.view];

 [1]: http://i.imgur.com/SPDXc.png "IconActionSheetDemo Screenshot"
