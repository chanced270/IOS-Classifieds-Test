//
//  CreatePostController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/21/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "CreatePostController.h"
#import <Parse/Parse.h>
//#import <AVFoundation/AVFoundation.h>

@interface CreatePostController ()

@end

@implementation CreatePostController
@synthesize Title,Price,PriceInt,Category, geocoder= _geocoder,longitude,latitude,ImageView,PickerView1,AddImage,Localization;

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
                Localization = placemark.locality;
                float lat = coordinate.latitude;
                float lon = coordinate.longitude;
                longitude = lon;
                latitude = lat;
                _Cord = cord;
            }
            
        }];
        
    }
    //ImageView.contentMode = UIViewContentModeScaleAspectFit;
            ImageView.image = _ObjectImage;
    if (ImageView.image) {
        AddImage.hidden = true;
    }
}
- (IBAction)TakePhoto:(id)sender {
UIImagePickerController *PickerView = [[UIImagePickerController alloc] init];
    PickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    PickerView.delegate = self;
    PickerView.editing = YES;
    [self presentViewController:PickerView animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize sizes = CGSizeMake(240, 128);
    UIImage *Resized = [self scaleImage:image toSize:sizes];
    _ObjectImage = Resized;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIImage *) scaleImage:(UIImage*)image toSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
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
    CreatePost[@"Location"] = Localization;
    CreatePost[@"postedBy"] = [PFUser currentUser];
    NSData *ImageData = UIImagePNGRepresentation(ImageView.image);
        PFFile *ImageFile = [PFFile fileWithData:ImageData]; // Original
      //  ImageDataPublic = ImageFile;
    CreatePost[@"Image"] = ImageFile;
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
