//
//  MainViewController.m
//  iOwner
//
//  Created by ldb on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "RegViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)RegisterClick:(id)sender {
    
    RegViewController *newViewController = [[RegViewController alloc] initWithNibName:@"RegViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.  
    [self.navigationController pushViewController:newViewController animated:YES];
    [newViewController release];      
    
}

- (IBAction)LoginClick:(id)sender {
}
@end
