//
//  Picklee.h
//  Pickle_alpha
//
//  Created by Salman Akhtar on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picklee : NSObject {
    
}



+(NSMutableArray*) getPickleMessages;

+(NSString*) getPickleIDForMessage:(NSString*)message;

+(NSMutableArray*) getGroupsForUser;

+(NSMutableArray*) getPickleesForGroupName:(NSString*)name;

+(NSMutableString*) getUsernameForCurrentUser;

+(NSMutableArray*) getFriendsNamesForCurrentUser;

+(NSMutableArray*) getFriendsIDForFriend:(NSString*)friendName;
@end
