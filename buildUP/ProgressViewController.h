//
//  ProgressViewController.h
//  buildUP
//
//  Created by Alejandro Machado on 14/5/18.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "GravatarUrlBuilder.h"

@interface ProgressViewController : UIViewController

- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *selfImage;
@property (weak, nonatomic) IBOutlet UILabel *selfDisplayName;

@property (weak, nonatomic) IBOutlet UIImageView *buddyImage;
@property (weak, nonatomic) IBOutlet UILabel *buddyDisplayName;

@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSString *buddyUsername;

@property (strong, nonatomic) NSNumber *score;
@property (strong, nonatomic) NSNumber *buddyScore;


@end
