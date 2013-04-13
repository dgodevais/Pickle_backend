//
//  AppDelegate.m
//  Pickle_alpha
//
//  Created by jarthur on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

NSString *const FBSessionStateChangedNotification =
@"com.hack2013.Pickle-alpha:FBSessionStateChangedNotification";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"pWN9YEakrvR1vHxXHOKOsoT4K74BRKaQ8EVCenQb"
                  clientKey:@"MHjwyydWzHDCuaSZklI5z6VgLnTMKUVhLYyFfeXL"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    // Override point for customization after application launch.
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

- (void) closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
}
-(void)callOnLogin {
    currentUser = [PFUser currentUser];
}

-(NSMutableArray*) getPickleMessages {
    NSMutableArray* pickleMessages= [[NSMutableArray alloc]init];
    NSMutableArray* pickleMessagesIDs = [[NSMutableArray alloc]init];
    PFRelation *myPickles = [currentUser relationforKey:@"myPickles"];
    [[myPickles query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
        }
        else {
            [pickleMessagesIDs addObjectsFromArray:objects];
        }
    }];
    PFRelation *otherPickles = [currentUser relationforKey:@"otherPickles"];
    [[otherPickles query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            return;
        }
        else {
            [pickleMessagesIDs addObjectsFromArray:objects];
        }
    }];
    for (PFObject* pickle in pickleMessagesIDs) {
        [pickleMessages addObject:[pickle objectForKey:@"message"]];
    }
    return pickleMessages;
    
}

-(NSString*) getPickleIDForMessage:(NSString*)message {
    NSMutableArray* pickleMessagesIDs = [[NSMutableArray alloc]init];
    PFRelation *myPickles = [currentUser relationforKey:@"myPickles"];
    PFQuery* query = [myPickles query];
    [query whereKey:@"message" equalTo:message];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
        }
        else {
            [pickleMessagesIDs addObjectsFromArray:objects];
        }
    }];
    for (PFObject* pickleMessage in pickleMessagesIDs) {
        return pickleMessage.objectId;
    }
}

-(NSMutableArray*) getGroupsForUser {
    NSMutableArray* groups = [[NSMutableArray alloc]init];
    PFRelation* myGroups = [currentUser relationforKey:@"groups"];
    [[myGroups query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
        }
        else {
            [groups addObjectsFromArray:objects];
        }
    }];
    return groups;
}

-(NSMutableArray*) getPickleesForGroupName:(NSString*)name {
    
}

//-(NSMutableString*) getUsernameForCurrentUser;

//-(NSMutableArray*) getFriendsNamesForCurrentUser;

//-(NSMutableArray*) getFriendsIDForFriend:(NSString*)friendName;

-(void)createGroup:(NSString*)groupName {
    PFObject* group = [PFObject objectWithClassName:@"Group"];
    PFRelation* groupMembers = [group relationforKey:@"members"];
    [groupMembers addObject:currentUser];
    [group saveInBackground];
    PFRelation* userGroups = [currentUser relationforKey:@"groups"];
    [userGroups addObject:group];
    [currentUser saveInBackground];
}

-(void)createPickleWithQuestion:(NSString*)message andBeginTime:(NSDate*)startTime andEndTime:(NSDate*)endTime {
    PFObject* pickle = [PFObject objectWithClassName:@"Pickle"];
    [pickle addObject:currentUser forKey:@"pickler"];
    [pickle addObject:message forKey:@"message"];
    [pickle addObject:startTime forKey:@"startTime"];
    [pickle addObject:endTime forKey:@"endTime"];
    [pickle saveInBackground];
    PFRelation *myPickles = [currentUser relationforKey:@"myPickles"];
    [myPickles addObject:pickle];
    [currentUser saveInBackground];
}

-(void)addSuggestedPlace:(NSString*)place forPickle:(NSString*)pickleID {
    PFQuery *query = [PFQuery queryWithClassName:@"Pickle"];
    PFObject *pickle = [query getObjectWithId:pickleID];
    PFRelation *picklePlaces = [pickle relationforKey:@"suggestedPlaces"];
    // if errors occur, make place an object. For right now, leaving as an NSString.
    [picklePlaces addObject:place];
}
@end
