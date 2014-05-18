//
//  BuildingViewController.h
//  buildUP
//
//  Created by Alejandro Machado on 14/5/5.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITextField *minutesTextField;

- (IBAction)logout:(id)sender;

- (IBAction)selectFriend:(id)sender;

@end
