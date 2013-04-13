//
//  PickleTime.m
//  Pickle_alpha
//
//  Created by Dustin Godevais on 4/13/13.
//  Copyright (c) 2013 com.hack2013. All rights reserved.
//

#import "PickleTime.h"

@implementation PickleTime

-(id) initWithStart:(NSDate *) startTime end:(NSDate *) endTime
{
    self = [super init];
    if (self) {
        _originStartTime = startTime;
        _originEndTime = endTime;
        NSMutableArray * _timeSlotArray = [[NSMutableArray alloc] init];
        NSMutableArray * _peopleArray = [[NSMutableArray alloc] init];
        
        
        for( double seconds = 0; seconds < INFINITY; seconds = seconds+1800) {
            NSDate * tempDate = [[NSDate alloc] initWithTimeInterval: seconds sinceDate: startTime]; //half an hour later
            NSMutableArray * people = [[NSMutableArray alloc] init];
            if (tempDate > endTime)
                break;
            [_timeSlotArray addObject:(tempDate)];
            [_peopleArray addObject:(people)];
        }
    }
    return self;
}

-(void) addPerson:(NSString *) person withStartTime:(NSDate *)startTime endTime:(NSDate *) endTime
{
    for( int c = 0; c < INFINITY; ++c) {        
        NSDate * tempDate = [[NSDate alloc] initWithTimeInterval: (c*1800) sinceDate: _originStartTime]; //half an hour later
  
        if (tempDate > endTime)
            break;
        if (tempDate >= startTime){
            [[_peopleArray objectAtIndex:(NSUInteger) c] addObject:person];
        }

    }
}

-(NSArray *) getBestTimes{
    NSMutableArray * bestTimeArray = [[NSMutableArray alloc] init];
    int mostPeople = 0;
    for( int c = 0; c < INFINITY; ++c) {        
        NSDate * tempDate = [[NSDate alloc] initWithTimeInterval: (c*1800) sinceDate: _originStartTime]; //half an hour later
        if (tempDate > _originEndTime)
            break;

        //if there are other times with the same best number of people
        if ([[_peopleArray objectAtIndex:(NSUInteger) c] count] == mostPeople){ 
            [bestTimeArray addObject:[_timeSlotArray objectAtIndex:(NSUInteger) c]];
        }
        
        //if there's a time with a better number of people
        if ([[_peopleArray objectAtIndex:(NSUInteger) c] count] > mostPeople){
            mostPeople = [[_peopleArray objectAtIndex:(NSUInteger) c] count];
            [bestTimeArray removeAllObjects];
            [bestTimeArray addObject:[_timeSlotArray objectAtIndex:(NSUInteger) c]];
        }
        
    }
    return bestTimeArray;
}


@end
