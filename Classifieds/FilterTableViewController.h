//
//  FilterTableViewController.h
//  Classifieds
//
//  Created by Zackary Divine on 7/19/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewController : UITableViewController
@property  int fromInt;
@property  int ToInt;
@property NSArray *filterArray;
@property (weak, nonatomic) IBOutlet UITextField *FromValue;
@property (weak, nonatomic) IBOutlet UITextField *ToValue;
@property NSString *FilterLog;

@end
