//
//  GroupDetailsVC.m
//  Pickle_alpha
//
//  Created by Dustin Godevais on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "GroupDetailsVC.h"

@interface GroupDetailsVC ()

@end

@implementation GroupDetailsVC

-(id)initWithGroupName:(NSString *) groupName
{
    self = [super init];
    if (self) {
        _groupName = groupName;
        
        CGRect myFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.height/3, self.view.frame.size.width/8);
        myFrame.origin = CGPointMake(self.view.frame.origin.x/2, self.view.frame.origin.y/2);
        
        UILabel* groupLabel = [[UILabel alloc] initWithFrame:myFrame];
        groupLabel.text = _groupName;
        [[self view] addSubview:groupLabel];
        
        
    }
    return self;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
