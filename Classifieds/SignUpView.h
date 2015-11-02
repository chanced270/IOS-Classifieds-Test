//
//  SignUpView.h
//  Classifieds
//
//  Created by Zackary Divine on 10/28/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SignUpView : UIViewController{
    CLGeocoder *_geocoder;
}
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *zip;
@property (weak, nonatomic) IBOutlet UIButton *SignBtn;
#pragma mark - Geolocation
@property (nonatomic, strong) CLGeocoder *geocoder;
@property NSString *Cord;
@property float latitude;
@property float longitude;
@property NSString *Localization;


@end
