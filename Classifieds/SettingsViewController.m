//
//  SettingsViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "SettingsViewController.h"
#import "SignInViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize StatusTxt, LogInBTN;

- (void)viewDidLoad {
    [super viewDidLoad];
     [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    /*
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSString *user = [currentUser username];
        NSString *statusInfo = [NSString stringWithFormat:@"Welcome, %@", user];
        StatusTxt.text = statusInfo;
        LogInBTN.enabled = false;
        LogInBTN.hidden = true;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
        //self.navigationItem.rightBarButtonItem.title = @"Log Out";
        //self.navigationItem.rightBarButtonItem.action = @selector(Logout);
    }
    else{
        //@selector(performSegueWithIdentifier:);
        StatusTxt.text = @"Sorry you are not signed in.";
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:self action:@selector(LogIn)];
        //self.navigationItem.rightBarButtonItem.title = @"Log In";
        //self.navigationItem.rightBarButtonItem.action = @selector(LogIn);
    }
     */
    //self.navigationItem.backBarButtonItem.title = @"Back";
}
#pragma mark - UIBarButton Methods
- (void) Logout{
    NSLog(@"LogOut");
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
}
-(void) LogIn{
    NSLog(@"LogIN");
    [self performSegueWithIdentifier:@"LogIN" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime:(NSTimer *)timer{
#pragma mark - Update Label
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSString *user = [currentUser username];
        NSString *statusInfo = [NSString stringWithFormat:@"Welcome, %@", user];
        StatusTxt.text = statusInfo;
        LogInBTN.enabled = false;
        LogInBTN.hidden = true;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(Logout)];
        //self.navigationItem.rightBarButtonItem.title = @"Log Out";
        //self.navigationItem.rightBarButtonItem.action = @selector(Logout);
    }
    else{
        //@selector(performSegueWithIdentifier:);
        StatusTxt.text = @"Sorry you are not signed in.";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:self action:@selector(LogIn)];
        //self.navigationItem.rightBarButtonItem.title = @"Log In";
        //self.navigationItem.rightBarButtonItem.action = @selector(LogIn);
    }}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
