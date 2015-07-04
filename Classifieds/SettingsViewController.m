//
//  SettingsViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize StatusTxt, LogInBTN;

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSString *user = [currentUser username];
        NSString *statusInfo = [NSString stringWithFormat:@"Welcome, %@", user];
        StatusTxt.text = statusInfo;
        LogInBTN.enabled = false;
        LogInBTN.hidden = true;

    }
    else{
        //@selector(performSegueWithIdentifier:);
        StatusTxt.text = @"Sorry you are not signed in.";
    }
    //self.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
