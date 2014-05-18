//
//  ProgressViewController.m
//  buildUP
//
//  Created by Alejandro Machado on 14/5/18.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import "ProgressViewController.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // stay here
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

@end
