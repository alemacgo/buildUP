//
//  BuildingViewController.h
//  buildUP
//
//  Created by Alejandro Machado on 14/5/5.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BuildingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *selfImage;
@property (weak, nonatomic) IBOutlet UILabel *selfDisplayName;

@property (weak, nonatomic) IBOutlet UIImageView *buddyImage;
@property (weak, nonatomic) IBOutlet UILabel *buddyDisplayName;

- (IBAction)logout:(id)sender;

@end
