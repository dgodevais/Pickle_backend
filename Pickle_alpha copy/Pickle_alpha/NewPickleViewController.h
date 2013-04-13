//
//  NewPickleViewController.h
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPickleViewController : UIViewController {
    UIGestureRecognizer* tapRecognizer;
    NSMutableArray *listOfCurrentPickles;
}
- (IBAction)makeANewPickle:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *currentPicklesTable;

@property (weak, nonatomic) IBOutlet UITextField *pickleDescription;
@property (weak, nonatomic) IBOutlet UITextField *whereDescription;

@end
