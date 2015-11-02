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
@synthesize StatusTxt, LogInBTN, geocoder = _geocoder, stoptimer, accountView;

- (void)viewDidLoad {
    [super viewDidLoad];
    StatusTxt.text = @"";
     [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
     //[self performSelector:@selector(fetch_location)];

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
-(void)viewWillAppear:(BOOL)animated{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [stoptimer invalidate];
}
#pragma mark - Fetch Location
-(void)fetch_location{
    PFUser *user = [PFUser currentUser];
    NSString *zipCode = [user objectForKey:@"Location"];
    if (zipCode > 0) { //added
        NSLog(@"Initalize fetch location method");
        if (!self.geocoder) {
            self.geocoder = [[CLGeocoder alloc] init];
        }
        NSString *address = [NSString stringWithFormat:@"%@",zipCode];
        [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D coordinate = location.coordinate;
                NSString *citytext = [NSString stringWithFormat:@"%@",[placemarks[0]locality]];
                NSString *userLocation = [NSString stringWithFormat:@"User Location: %@",citytext];
                self.navigationItem.prompt = userLocation;
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                //NSString *cord= [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
                PFGeoPoint *UserGeopoint = [PFGeoPoint geoPointWithLatitude:lat longitude:lon];
                user[@"LocationGeoPoint"] = UserGeopoint;
                [user saveInBackground];
            }

        }];
    } //added
    else{
    }
}
#pragma mark - UIBarButton Methods
- (void) Logout{
    NSLog(@"LogOut");
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [accountView removeFromSuperview];
    
}
-(void) LogIn{
    NSLog(@"LogIN");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log In or Sign Up" message:@"Would you like to log in or sign up?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SignUP = [UIAlertAction actionWithTitle:@"Sign Up" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"SignUP" sender:self];
    }];
    UIAlertAction *LogIn = [UIAlertAction actionWithTitle:@"Log In" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"LogIN" sender:self];
    }];
    [alert addAction:SignUP];
    [alert addAction:LogIn];
    [self presentViewController:alert animated:YES completion:nil];
    /*
    UIAlertView *SinLog = [[UIAlertView alloc]initWithTitle:@"Log In or Sign Up" message:@"Would you like to Log In or Sign Up" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [SinLog addButtonWithTitle:@"Sign Up"];
    [SinLog addButtonWithTitle:@"Login"];
    [SinLog show];
     */
    //[self performSegueWithIdentifier:@"LogIN" sender:self];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"SignUP" sender:self];
    } else if (buttonIndex == 1){
        [self performSegueWithIdentifier:@"LogIN" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime:(NSTimer *)timer{
#pragma mark - Update Label
    [self performSelector:@selector(fetch_location)];
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
        [timer invalidate];
        //timer = _stoptimer; Declaration Variable first then implent what the vaiable is for
#pragma mark - Add 2nd view here
        accountView = [[[NSBundle mainBundle] loadNibNamed:@"SettingsView" owner:self options:nil]objectAtIndex:0];
        accountView.frame = CGRectMake(0, 40, 320, 550);
        accountView.translatesAutoresizingMaskIntoConstraints = YES;
        NSString *userName = [NSString stringWithFormat:@"%@",[PFUser currentUser].username];
        NSString *userEmail = [NSString stringWithFormat:@"%@",[currentUser objectForKey:@"email"]];
        NSString *userZip = [NSString stringWithFormat:@"%@", [currentUser objectForKey:@"Location"]];
        accountView.userField.text = userName;
        accountView.userEmail.text =userEmail;
        accountView.userZip.text = userZip;
        accountView.userSubType.text = @"Standard User";
        [self.view addSubview:accountView];
        /*
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:accountView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:65.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:accountView
                                                              attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:accountView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:1.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:accountView
                                                              attribute:NSLayoutAttributeTrailing
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTrailing
                                                             multiplier:1.0
                                                               constant:0.0]];
         */

        
    }
    else{
        //@selector(performSegueWithIdentifier:);
        StatusTxt.text = @"Sorry you are not signed in.";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:self action:@selector(LogIn)];
 
        //self.navigationItem.rightBarButtonItem.title = @"Log In";
        //self.navigationItem.rightBarButtonItem.action = @selector(LogIn);
    }
    stoptimer = timer;
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
