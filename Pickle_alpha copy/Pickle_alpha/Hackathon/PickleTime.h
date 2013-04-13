//
//  PickleTime.h
//  Pickle_alpha
//
//  Created by Dustin Godevais on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSDate.h"

@interface PickleTime : NSObject 
{
    NSDate* _originStartTime;
    NSDate* _originEndTime;
    
    NSMutableArray* _timeSlotArray;
    NSMutableArray* _peopleArray;

}

-(id) initWithStart:(NSDate *) startTime end:(NSDate *) endTime;

-(void) addPerson:(NSString *) person withStartTime:(NSDate *)startTime endTime:(NSDate *) endTime;

-(NSArray *) getBestTimes;

@end
