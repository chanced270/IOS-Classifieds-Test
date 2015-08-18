//
//  CreatePostController.h
//  Classifieds
//
//  Created by Zackary Divine on 7/21/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CreatePostController : UIViewController {
    CLGeocoder *_geocoder;
}
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextField *Price;
@property (weak, nonatomic) IBOutlet UITextField *Category;
@property int PriceInt;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property NSString *Cord;
@property float latitude;
@property float longitude;

@end
