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
@synthesize userField,Password,Login,SignUpAlert,geocoder= _geocoder,latitude,Localization,longitude;

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
    return YES;
}

#pragma mark - SignUp Alert
- (IBAction)SignUp:(id)sender {
    
    /*
    //Sign up must be additional view not alert box
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
    */
}
-(void)SignUpUser{
    PFUser  *user = [PFUser user];
    user.username = _SUserName;
    user.password = _SPass;
    user.email = _SEmail;
    user[@"ZipCode"] = _SZip;
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc]init];
    }
    NSString *address = _SZip;
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            Localization = placemark.locality;
            float lat = coordinate.latitude;
            float lon = coordinate.longitude;
            longitude = lon;
            latitude = lat;
        }
    }];
    PFGeoPoint *UserPoint = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
    user[@"LocationGeoPoint"] = UserPoint;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
        }else{
            NSString *errorString = [error userInfo][@"error"];
            NSLog(errorString);
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
