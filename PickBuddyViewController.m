//
//  EditFriendsTableViewController.m
//  buildUP
//
//  Created by Alejandro Machado on 14/5/6.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import "PickBuddyViewController.h"

@interface PickBuddyViewController ()

@end

@implementation PickBuddyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" notEqualTo: [[PFUser currentUser] objectForKey:    @"username"]];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.allUsers = objects;
            [self.tableView reloadData];
        }
    }];

    self.currentUser = [PFUser currentUser];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.text = [user objectForKey:@"displayName"];
    
    if ([self.buddyUsername isEqualToString:[user objectForKey:@"username"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PFUser *otherUser = [self.allUsers objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    NSString* buddyUsername = [otherUser objectForKey:@"username"];
    [self.currentUser setObject:buddyUsername forKey:@"buddyUsername"];
    self.buddyUsername = buddyUsername;
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
    
    // We are selecting only one friend, go back
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

@end
