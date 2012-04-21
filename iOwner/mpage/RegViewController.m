//
//  RegViewController.m
//  iOwner
//
//  Created by ldb on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegViewController.h"
#import "WeiboConnection.h"
#import "constants.h"

@interface RegViewController ()

@end

@implementation RegViewController

@synthesize currentTextField = _currentTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *done =    [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitRegInfo)] autorelease];    
    
    self.navigationItem.rightBarButtonItem = done;     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_currentTextField release];
    [_email release];
    [_username release];
    [_password release];
    [super dealloc];
}

- (NSString *)rndid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [NSString stringWithString:(NSString *)
                      uuidStringRef];
    CFRelease(uuidStringRef);
    return uuid;
}

-(void)submitRegInfo
{
    NSString * email = _email;//@"debin.test@gmail.com";
    NSString * password = _password;//@"123456";
//    int value = arc4random() % 1000;
    NSString * name = _username;//[NSString stringWithFormat:@"owner%d",value];
    NSString * regapiurl = [NSString stringWithFormat:REST_API_REGISTER,email,password,name];    
    WeiboConnection *webconn = [[WeiboConnection alloc] initWithTarget:self
                                                                action:@selector(processData:obj:)];
    //    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];;    
    [webconn syncGet:regapiurl params:nil];

}

- (void)processData:(WeiboConnection*)sender obj:(NSObject*)obj
{
    if (sender.hasError) {
        //       [sender alert]; 
        return;
    }
    
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch ([indexPath indexAtPosition:0]) {
        case 0:
            switch ([indexPath indexAtPosition:1]) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"email", nil);
                    break;
                case 1:
                    cell.textLabel.text = NSLocalizedString(@"uname", nil);
                    break;
                case 2:
                    cell.textLabel.text = NSLocalizedString(@"pwd", nil);
                    break;
//                case 3:
//                    cell.textLabel.text = NSLocalizedString(@"pwd", nil);
//                    break;
//                case 4:
//                    cell.textLabel.text = NSLocalizedString(@"pwd", nil);
//                    break;    
                default:
                    cell.textLabel.text = CellIdentifier;
                    break;
            }
            break;
        default:
            cell.textLabel.text = CellIdentifier;
            break;
    }
    
    NSInteger row = [indexPath row];
    CGRect textFieldRect = CGRectMake(0.0, 0.0f, 200.0f, 32.0f);
    UITextField *theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    theTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    theTextField.returnKeyType = UIReturnKeyDone;
    if (row == 2) {
        theTextField.secureTextEntry = YES;
    }
    theTextField.clearButtonMode = YES;
    theTextField.tag = row;
    theTextField.delegate = self;
    
    [theTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    [theTextField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit]; 
//    [theTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin]; 
    switch (row) {
        case 0:
            theTextField.placeholder = @"example@example.com";
            break;
        default:
            break;
    }
    
    cell.accessoryView = theTextField; 
    [theTextField release];
    
    // Configure the cell...
    
    return cell;
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            _email = [textField text];
            break;
        case 1:
            _username = [textField text];
            break;
        case 2:
            _password = [textField text];
            break;
            
        default:
            break;
    }
}

-(void)textFieldDoneEditing:(id)sender
{
    self.currentTextField = (UITextField *)sender;
    [self.currentTextField resignFirstResponder];
    [sender resignFirstResponder];
    [self.tableView scrollRectToVisible:self.currentTextField.frame animated:YES];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    self.currentTextField = textField;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) [self.tableView viewWithTag:self.currentTextField.tag]];
//    //这里要看textField 是直接加到cell 上的还是加的 cell.contentView上的
//    //直接加到cell 上
//    UITableViewCell *cell = (UITableViewCell *) [textField superview];
//    indexPath = [self.tableView indexPathForCell:cell];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
