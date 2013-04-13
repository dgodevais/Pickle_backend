//
//  GroupsVC.m
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "GroupsVC.h"

#import "GroupDetailsVC.h"

@interface GroupsVC ()

@end

@implementation GroupsVC

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
    [super viewDidLoad];
    [[self myPickleGroupsTable]setDelegate:self];
    [[self myPickleGroupsTable]setDataSource:self];
    
    myGroupNames = [[NSMutableArray alloc]init];
    [myGroupNames addObject:@"Soccer Friends"];
    [myGroupNames addObject:@"SpoGro"];
    [myGroupNames addObject:@"SVP Beta"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewGroupButton:(id)sender {
}

//#pragma tableview datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // #2
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // #3
    return [myGroupNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // #4
    cell.textLabel.text = [myGroupNames objectAtIndex:indexPath.row];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GroupDetailsVC *groupController = [[GroupDetailsVC alloc] initWithGroupName:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [[self navigationController] pushViewController:groupController animated:YES];
}

@end
