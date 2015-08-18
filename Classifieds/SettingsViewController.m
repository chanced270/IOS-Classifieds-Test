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
@synthesize StatusTxt, LogInBTN, geocoder = _geocoder, stoptimer;

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
    NSLog(zipCode);
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
                NSLog(citytext);
                NSString *userLocation = [NSString stringWithFormat:@"User Location: %@",citytext];
                self.navigationItem.prompt = userLocation;
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                NSString *cord= [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
                PFGeoPoint *UserGeopoint = [PFGeoPoint geoPointWithLatitude:lat longitude:lon];
                user[@"LocationGeoPoint"] = UserGeopoint;
                [user saveInBackground];
                NSLog(cord);
            }

        }];
    } //added
    else{
        NSLog(@"Zip Code Null");
    }
}
#pragma mark - UIBarButton Methods
- (void) Logout{
    NSLog(@"LogOut");
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
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
