//
//  GroupDetailsVC.h
//  Pickle_alpha
//
//  Created by Dustin Godevais on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailsVC : UIViewController {
    
    NSString* _groupName;
}

-(id)initWithGroupName:(NSString*) groupName;

@end
