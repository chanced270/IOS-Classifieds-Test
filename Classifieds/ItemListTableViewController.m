//
//  ItemListTableViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/3/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "ItemListTableViewController.h"
#import "ItemTableViewCell.h"

@interface ItemListTableViewController ()

@end

@implementation ItemListTableViewController
@synthesize FromValue,ToValue,ItemArray,ItemList,Query,FromNumValue,ToNumValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Home";
    [self performSelector:@selector(ParseItemListSearch)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //loads NSStrings from FilterTableVC
    self.ToValue = _ToVal;
    self.FromValue = _FromVal;
    NSString *test = [NSString stringWithFormat:@"From: %d To: %d",FromValue,ToValue];
    NSLog(test);
    FromNumValue = [NSNumber numberWithInt:FromValue];
    ToNumValue = [NSNumber numberWithInt:ToValue];
   }
#pragma mark -Search Post Data Base
-(void)ParseItemListSearch{
    PFUser *currentUser = [PFUser currentUser];
    //PFGeoPoint *UserLocation = [currentUser objectForKey:@"LocationGeoPoint"];
    Query = [PFQuery queryWithClassName:@"Posts"];
   [Query whereKey:@"LocationGeopoint" nearGeoPoint:[currentUser objectForKey:@"LocationGeoPoint"]withinMiles:30];
#pragma mark -Search for objects
    [Query findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if (!error) {
            ItemArray = objects;
        }
        [self.ItemList reloadData];
    }];
    
}
/*
#pragma mark - filter Search
if (ToNumValue > 0) {
    NSLog(@"Set To Value");
    [Query whereKey:@"Price" lessThanOrEqualTo:ToNumValue];
}
if (FromNumValue > 0) {
    NSLog(@"Set From Value");
    [Query whereKey:@"Price" greaterThanOrEqualTo:FromNumValue];
}
 */


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [ItemArray count];
}
#pragma mark - Toolbar Functions
- (IBAction)Category:(id)sender {
    NSLog(@"Category Clicked");
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemListTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell with the textContent of the Post as the cell's text label
    NSDictionary *TempDict = [ItemArray objectAtIndex:indexPath.row];
    //PFObject *referal = [_ViewRefArray objectAtIndex:indexPath.row];
    cell.DatePublished.text = [TempDict objectForKey:@"CreatedAt"];
    cell.Title.text = [TempDict objectForKey:@"Title"];
    cell.Location.text = [TempDict objectForKey:@"Location"];
    PFObject *ItemObject = [ItemArray objectAtIndex:indexPath.row];
    PFFile *ItemImageFile = [ItemObject objectForKey:@"Image"];
    [ItemImageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (!error) {
            cell.ItemImage.image = [UIImage imageWithData:data];
        }
    }];
    NSString *PriceString = [NSString stringWithFormat:@"$%@",[TempDict objectForKey:@"Price"]];
    cell.Price.text = PriceString;
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
