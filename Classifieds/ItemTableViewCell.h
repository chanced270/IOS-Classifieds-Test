//
//  ItemTableViewCell.h
//  Classifieds
//
//  Created by Zackary Divine on 7/22/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ItemImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *DatePublished;

@end
