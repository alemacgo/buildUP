//
//  ProgressViewController.m
//  buildUP
//
//  Created by Alejandro Machado on 14/5/18.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import "ProgressViewController.h"
#define START_X 102
#define START_Y 329

@interface ProgressViewController ()

@end

@implementation ProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    else {
        [self retrieveInfo];
        if (![self.buddyUsername length]) {
            //TODO: how to send to the middle screen?
            [self performSegueWithIdentifier:@"showLogin" sender:self];
        }
        else {
            [self.navigationController.navigationBar setHidden:NO];
            
            [self setImageView:self.selfImage forUser:self.user.username];
            [self setImageView:self.buddyImage forUser:self.buddyUsername];
            
            self.selfDisplayName.text = [self.user objectForKey:@"displayName"];
            
            NSString* buddyDisplayName = [self.buddyUsername stringByReplacingOccurrencesOfString:@"@gmail.com" withString:@""];
            self.buddyDisplayName.text = buddyDisplayName;
            
            [self displayScores];
        }
    }
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

#pragma mark - Helpers
- (void)retrieveInfo {
    //self.buddy = [self.currentUser objectForKey:@"buddyUsername"];
    self.user = [PFUser currentUser];
    
    // How to pull all data from the user?
    self.buddyUsername = [self.user objectForKey:@"buddyUsername"];
}

- (void)setImageView:(UIImageView*)imageView forUser:(NSString*)username {
    // 2. Create the md5 hash
    // Assume the username is the email
    NSURL *gravatarUrl = [GravatarUrlBuilder getGravatarUrl:username];

    // 3. Request the image from Gravatar
    NSData *imageData = [NSData dataWithContentsOfURL:gravatarUrl];

    if (imageData) {
        imageView.image = [UIImage imageWithData:imageData];
    }
}

- (void)displayScores {
    //NSNumber *score = @0;
    [self addBlockInX:START_X AndY:START_Y];
}

- (void)addBlockInX:(float)x AndY:(float)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(x, y, 50, 50);
    [button setTitle:@"Build" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:button];

}

@end
