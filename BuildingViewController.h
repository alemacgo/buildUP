//
//  BuildingViewController.h
//  buildUP
//
//  Created by Alejandro Machado on 14/5/5.
//  Copyright (c) 2014 M-ITI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingViewController : UIViewController
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *selfImage;
@property (weak, nonatomic) IBOutlet UIImageView *buddyImage;

@end
