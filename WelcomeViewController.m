//
//  BuildingViewController.m
//  buildUP
//
//  Created by Alejandro Machado on 14/5/5.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectFriend:(id)sender {
    [self saveData];
    
    [self performSegueWithIdentifier:@"showPickBuddy" sender:self];
}

- (void)saveData {
    PFUser *user = [PFUser currentUser];
    NSString* task = self.taskTextField.text;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *minutes = [f numberFromString:self.minutesTextField.text];
    [user setObject:task forKey:@"task"];
    [user setObject:minutes forKey:@"minutes"];
    [user setObject:@0 forKey:@"score"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
}

@end
