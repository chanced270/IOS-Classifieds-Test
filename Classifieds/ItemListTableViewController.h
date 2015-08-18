//
//  ItemListTableViewController.h
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ItemListTableViewController : UITableViewController
@property  int FromVal;
@property  int ToVal;
@property  int FromValue;
@property int ToValue;
@property (nonatomic, retain) NSArray *ItemArray; //Used to be strong
@property (strong, nonatomic) IBOutlet UITableView *ItemList;
@property PFQuery *Query;
@property NSNumber *FromNumValue;
@property NSNumber *ToNumValue;

@end
