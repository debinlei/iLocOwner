//
//  LoginViewController.h
//  iOwner
//
//  Created by ldb on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController<UITextFieldDelegate>{
    NSString * _email;
    NSString * _username;
    NSString * _password;
}
@property (nonatomic, retain) UITextField *currentTextField;

@end
