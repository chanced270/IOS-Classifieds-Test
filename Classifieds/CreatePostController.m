//
//  CreatePostController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/21/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "CreatePostController.h"
#import <Parse/Parse.h>

@interface CreatePostController ()

@end

@implementation CreatePostController
@synthesize Title,Price,PriceInt,Category, geocoder= _geocoder,longitude,latitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Need fuction in place to redirect user to login to create post
  //  PFUser *currentUser = [PFUser currentUser];
}
-(void)viewWillAppear:(BOOL)animated{
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
                NSString *cord= [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
                NSLog(cord);
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                longitude = lon;
                latitude = lat;
                _Cord = cord;
            }
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PostCreate:(id)sender {
    PFObject *CreatePost = [PFObject objectWithClassName:@"Posts"];
    int PriceInteger = [Price.text intValue];
    CreatePost[@"Title"] = Title.text;
    CreatePost[@"Price"] = [NSNumber numberWithInt:PriceInteger];
    CreatePost[@"Category"] = Category.text;
    CreatePost[@"Location"] = _Cord;
    PFGeoPoint *PostPoint = [PFGeoPoint geoPointWithLatitude:latitude longitude:longitude];
    CreatePost[@"LocationGeopoint"] = PostPoint;
    [CreatePost saveInBackground];
    UIAlertView *Success = [[UIAlertView alloc] initWithTitle:@"Post Created" message:@"You have successfully created your post!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [Success show];
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
