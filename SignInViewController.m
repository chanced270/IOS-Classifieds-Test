//
//  SignInViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpView.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
@synthesize userField,Password,Login,SignUpAlert;

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
    [_SUserTXT resignFirstResponder];
    [_SPassTXT resignFirstResponder];
    [_SEmailTXT resignFirstResponder];
    [_SZipTXT resignFirstResponder];
   // [SignUpAlert resignFirstResponder];
    return NO;
}

#pragma mark - SignUp Alert
- (IBAction)SignUp:(id)sender {
    SignUpAlert = [[SCLAlertView alloc] init];
    //SignUpView *SUV = [[SignUpView alloc]init];
    _SUserTXT = [SignUpAlert addTextField:@"Username"];
    _SPassTXT = [SignUpAlert addTextField:@"Password"];
    _SEmailTXT = [SignUpAlert addTextField:@"Email"];
    _SZipTXT = [SignUpAlert addTextField:@"Zipcode"];
    _SUserTXT.delegate = self;
    _SPassTXT.delegate =self;
    _SEmailTXT.delegate = self;
    _SZipTXT.delegate = self;
[SignUpAlert addButton:@"Create Account" actionBlock:^{
#pragma mark - Create New user Alert
    _SUserName = _SUserTXT.text;
    _SPass = _SPassTXT.text;
    _SEmail = _SEmailTXT.text;
    _SZip = _SZipTXT.text;
    
}];
    [SignUpAlert showNotice:self title:@"Create Account" subTitle:NULL closeButtonTitle:@"Close" duration:0.0f];
    
}
-(void)SignUpUser{
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
