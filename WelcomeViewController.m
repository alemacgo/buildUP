//
//  BuildingViewController.m
//  buildUP
//
//  Created by Alejandro Machado on 14/5/5.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import "WelcomeViewController.h"
#import <Parse/Parse.h>
#import "GravatarUrlBuilder.h"

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

    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    
    //self.buddy = [self.currentUser objectForKey:@"buddyUsername"];
    
    self.selfDisplayName.text = [[PFUser currentUser] objectForKey:@"displayName"];
    
    NSString* buddyDisplayName = [[[PFUser currentUser] objectForKey:@"buddyUsername"] stringByReplacingOccurrencesOfString:@"@gmail.com" withString:@""];
    
    self.buddyDisplayName.text = buddyDisplayName;
    
    // 1. Get email address
    NSString *email = [PFUser currentUser].username;
    // 2. Create the md5 hash
    NSURL *gravatarUrl = [GravatarUrlBuilder getGravatarUrl:email];
    
    // 3. Request the image from Gravatar
    NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];
    
    if (imageData) {
        self.selfImage.image = [UIImage imageWithData:imageData];
    }
    else {
        self.selfImage.image = [UIImage imageNamed:@"user"];
    }
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

@end
