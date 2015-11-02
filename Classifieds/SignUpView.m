//
//  SignUpView.m
//  Classifieds
//
//  Created by Zackary Divine on 10/28/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "SignUpView.h"
#import <Parse/Parse.h>

@interface SignUpView () <UITextFieldDelegate>

@end

@implementation SignUpView
@synthesize user, pass, email, zip, SignBtn, geocoder = _geocoder, longitude, latitude, Localization;

- (void)viewDidLoad {
    [super viewDidLoad];
    user.delegate = self;
    pass.delegate = self;
    email.delegate = self;
    zip.delegate = self;
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SignUp:(id)sender {
    [self performSelector:@selector(SignUPaction)];
    /*
    NSString *username = user.text;
    NSString *password = pass.text;
    NSString *emailPhrase = email.text;
    NSString *zipst = zip.text;
    int ZipInt = [zipst intValue];
    NSNumber *zipcode = [NSNumber numberWithInt:ZipInt];
    if (zipcode > 0) { //added
        NSLog(@"Initalize fetch location method");
        if (!self.geocoder) {
            self.geocoder = [[CLGeocoder alloc] init];
        }
        NSString *address = [NSString stringWithFormat:@"%@",zipcode];
        [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                NSString *cord= [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
                NSLog(cord);
                Localization = placemark.locality;
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                longitude = lon;
                latitude = lat;
                _Cord = cord;
            }
            
        }];
    }
    if (ZipInt == 5) {
    PFUser *user =[PFUser user];
    user.username = username;
    user.password = password;
    user.email = emailPhrase;
    PFGeoPoint *userPoint = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
        user[@"LocationGeoPoint"] = userPoint;
        user[@"Locality"] = Localization;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(errorString);
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Zipcode" message:@"The zipcode you entered is not valid. The zipcode must be 5 number long." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
     */
    

    
}
-(void)SignUPaction {
    NSString *usernameval = user.text;
    NSString *passwordval = pass.text;
    NSString *emailPhraseval = email.text;
    NSString *zipst = zip.text;
    int ZipInt = [zipst intValue];
    NSLog(@"%d",ZipInt);
    NSNumber *zipcode = [NSNumber numberWithInt:ZipInt];
    if (zipcode > 0) { //added
        NSLog(@"Initalize fetch location method");
        if (!self.geocoder) {
            self.geocoder = [[CLGeocoder alloc] init];
        }
        NSString *address = [NSString stringWithFormat:@"%@",zipcode];
        [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                NSString *cord= [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
                NSLog(cord);
                Localization = placemark.locality;
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                longitude = lon;
                latitude = lat;
                _Cord = cord;
            }
            
        }];
    }
    if (zipst.length == 5) {
        PFUser *user =[PFUser user];
        user.username = usernameval;
        user.password = passwordval;
        user.email = emailPhraseval;
        PFGeoPoint *userPoint = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
        user[@"LocationGeoPoint"] = userPoint;
        user[@"Locality"] = Localization;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(errorString);
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Zipcode" message:@"The zipcode you entered is not valid. The zipcode must be 5 number long." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == user) {
        [user resignFirstResponder];
        [pass becomeFirstResponder];
    }
    if (textField == pass) {
        [pass resignFirstResponder];
        [email becomeFirstResponder];
    }
    if (textField == email) {
        [email resignFirstResponder];
        [zip becomeFirstResponder];
    }
    if (textField == zip) {
        [zip resignFirstResponder];
        //[self performSelector:@selector(SignUPaction)];
    }
    //[user resignFirstResponder];
   // [pass resignFirstResponder];
   // [email resignFirstResponder];
   // [zip resignFirstResponder];
    return YES;
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
