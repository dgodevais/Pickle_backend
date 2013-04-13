//
//  NewPickleViewController.m
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "NewPickleViewController.h"

@interface NewPickleViewController ()

@end

@implementation NewPickleViewController

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
    
    [super viewDidLoad];
    [[self currentPicklesTable]setDelegate:self];
    [[self currentPicklesTable]setDataSource:self];
    
    listOfCurrentPickles = [[NSMutableArray alloc]init];
    [listOfCurrentPickles addObject:@"Dinner tonight?"];
    [listOfCurrentPickles addObject:@"Who wants to play soccer?"];
    [listOfCurrentPickles addObject:@"Conference room meeting?"];
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
    [_pickleDescription resignFirstResponder];
    [_whereDescription resignFirstResponder];
}

- (IBAction)makeANewPickle:(id)sender {
}

//#pragma tableview datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // #2
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #3
    return [listOfCurrentPickles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // #4
    cell.textLabel.text = [listOfCurrentPickles objectAtIndex:indexPath.row];
    return cell;
}
@end
