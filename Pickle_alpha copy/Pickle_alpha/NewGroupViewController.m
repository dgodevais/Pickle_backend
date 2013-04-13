//
//  NewGroupViewController.m
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "NewGroupViewController.h"

@interface NewGroupViewController ()

@end

@implementation NewGroupViewController

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
	// Do any additional setup after loading the view.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [_groupName resignFirstResponder];
}


@end
