//
//  FriendsTableViewController.h
//  buildUP
//
//  Created by Alejandro Machado on 14/5/6.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FriendsTableViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;
@end
