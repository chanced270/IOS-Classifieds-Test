//
//  MyAccount.h
//  Classifieds
//
//  Created by Zackary Divine on 11/1/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface MyAccount : UIView
@property (weak, nonatomic) IBOutlet UILabel *userField;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UIButton *EditZip;
@property (weak, nonatomic) IBOutlet UILabel *userSubType;
@property (weak, nonatomic) IBOutlet UILabel *userZip;

@end
