//
//  GroupsVC.h
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsVC : UIViewController{
    NSMutableArray *myGroupNames;
}
- (IBAction)addNewGroupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myPickleGroupsTable;

@end
