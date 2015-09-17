//
//  SignInViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize userField,Password,Login;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginAction:(id)sender {
    [PFUser logInWithUsernameInBackground:userField.text password:Password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                           // [self performSegueWithIdentifier:@"LogInSuccessful" sender:self];
                                            NSLog(@"Logging in");
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                            
                                        } else {
                                           NSString *errorString = [error userInfo][@"error"];
                                            UIAlertView *Error = [[UIAlertView alloc] initWithTitle:@"Error Sigining in" message:errorString delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                                            [Error show];
                                        }
                                    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [userField resignFirstResponder];
    [Password resignFirstResponder];
    return NO;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
