//
//  iOwnerAppDelegate.h
//  iOwner
//
//  Created by ldb on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPageViewController;
@interface iOwnerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
}

+(iOwnerAppDelegate*)getAppDelegate;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (retain, nonatomic) IBOutlet UINavigationController *mpController;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
- (void)checkGPSconfig;
//the function to process the login/logout logic
//the parameter indicate in or out
//LOGIN : b = TRUE 
//LOGOUT : b = FALSE
- (void)login:(BOOL)b;
@end
