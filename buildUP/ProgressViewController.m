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
#define BLOCK_SIZE 49

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
    
    self.score = [self.user objectForKey:@"score"];
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
    else {
        imageView.image = [UIImage imageNamed:@"user"];
    }
}

- (void)addBlocksForScore:(int)score isLeft:(BOOL)left {
    int x = START_X;
    int y = START_Y;
    if (!left) {
        x += BLOCK_SIZE;
    }
    
    while (score--) {
        [self addPastBlockInX: x AndY:y];
        y -= BLOCK_SIZE;
    }
    if (left) {
        // the left side is the user, we need to add the Build button
        [self addBuildBlockInX:x AndY:y];
    }
}

- (void)addPastBlockInX:(float)x AndY:(float)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor colorWithRed:0.937 green:0.918 blue:0.390 alpha:1.000];
    button.frame = CGRectMake(x, y, 50, 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1;
    button.tag = 1;
    [self.view addSubview:button];
}

- (void)addBuildBlockInX:(float)x AndY:(float)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor colorWithRed:0.960 green:0.949 blue:0.758 alpha:1.000];
    button.frame = CGRectMake(x, y, 50, 50);
    [button setTitle:@"Build" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(beginTimer) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
}

- (void)beginTimer {
    self.score = [NSNumber numberWithInt:(self.score.intValue + 1) % 6];
    [self displayScores];
    [self.user setObject:self.score forKey:@"score"];
    
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)displayScores {
    for (UIView *view in self.view.subviews) {
        if (view.tag == 1) {
            [view removeFromSuperview];
        }
    }
    [self addBlocksForScore:self.score.intValue isLeft:YES];
    [self addBlocksForScore:0 isLeft:NO];
}

@end
