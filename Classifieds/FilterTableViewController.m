//
//  FilterTableViewController.m
//  Classifieds
//
//  Created by Zackary Divine on 7/19/15.
//  Copyright © 2015 Zackary Divine. All rights reserved.
//

#import "FilterTableViewController.h"

@interface FilterTableViewController ()

@end

@implementation FilterTableViewController
@synthesize filterArray,FilterLog,fromInt,FromValue,ToInt,ToValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [FromValue resignFirstResponder];
    [ToValue resignFirstResponder];
}
- (IBAction)ApplyFilter:(id)sender {
#pragma mark - Intiallize numbers From Price Range
    fromInt = [FromValue.text intValue];
    ToInt = [ToValue.text intValue];
    NSString *testFrom = [NSString stringWithFormat:@"From: %d To: %d",fromInt,ToInt];
    NSLog(testFrom);
    
    if (fromInt > 0) {
        //if int value from the Input Field "Price Range: From is greater than 0 then do:...."
        NSLog(@"From Value Greater than 0");
    }
    /*
    if (ToInt < fromInt) {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"To Value can not be less than From Value" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [error show];
    }
 */
#warning Close Method Not working
}
- (IBAction)CloseView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    [self.FromValue resignFirstResponder];
    [self.ToValue resignFirstResponder];
    
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
