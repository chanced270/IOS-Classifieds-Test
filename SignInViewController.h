//
//  SignInViewController.h
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SettingsViewController.h"
#import "SignUpAlertView.h"
#import "SCLAlertView.h"

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIButton *Login;
@property (retain) NSString *SUserName;
@property (retain) NSString *SPass;
@property (retain) NSString *SEmail;
@property (retain) NSString *SZip;
@property UITextField *SUserTXT;
@property UITextField *SPassTXT;
@property UITextField *SEmailTXT;
@property UITextField *SZipTXT;
@property SCLAlertView *SignUpAlert;


@end
