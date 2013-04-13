//
//  LoginViewController.m
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view endEditing:YES];
    }
    return self;
}

- (IBAction)facebookLogIn:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the person is authenticated, log out when the button is clicked.
    // If the person is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The person has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not user intitiated, do not show the login UX.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self.facebookButton setTitle:@"Logout" forState:UIControlStateNormal];
    } else {
        [self.facebookButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}

-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

-(NSString*) returnID
{
    FBRequestConnection *connection = [[FBRequestConnection alloc] init];
    
    // First request uploads the photo.
    FBRequest *request1 = [FBRequest requestForMe];
    __block NSString * returnString = [[NSString alloc]init];
    
    if (FBSession.activeSession.isOpen) {
        
        [connection addRequest:request1
             completionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 
                 NSLog(@"fb user name = %@",user.name);
                 NSLog(@"fb user name = %@",user.id);
                 returnString = user.id;
             }
             
             NSLog(@"fb2 user name = %@",user.name);
             NSLog(@"fb2 user name = %@",user.id);
             returnString = user.id;
         }
         //batchEntryName:@"photopost"
         ];
        [connection start];
    }
    return returnString;
}

-(NSString*) returnName
{
    FBRequestConnection *connection = [[FBRequestConnection alloc] init];
    
    // First request uploads the photo.
    FBRequest *request1 = [FBRequest requestForMe];
    __block NSString * returnString = [[NSString alloc]init];
    
    if (FBSession.activeSession.isOpen) {
        
        [connection addRequest:request1
             completionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 
                 NSLog(@"fb user name = %@",user.name);
                 NSLog(@"fb user name = %@",user.id);
                 returnString = user.id;
             }
             
             NSLog(@"fb2 user name = %@",user.name);
             NSLog(@"fb2 user name = %@",user.id);
             returnString = user.id;
         }
         //batchEntryName:@"photopost"
         ];
        [connection start];
    }
    return returnString;
}

@end