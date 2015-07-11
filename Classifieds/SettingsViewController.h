//
//  SettingsViewController.h
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface SettingsViewController : UIViewController {
    CLGeocoder *_geocoder;
}
@property (weak, nonatomic) IBOutlet UILabel *StatusTxt;
@property (weak, nonatomic) IBOutlet UIButton *LogInBTN;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end
