//
//  LoginViewController.h
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController {
    UIGestureRecognizer* tapRecognizer;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;


- (IBAction)facebookLogIn:(id)sender;
- (NSString*)returnID;
- (NSString*)returnName;
@end
