//
//  User.m
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "User.h"
#import "Discipline.h"
#import "Task.h"

@implementation User


+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedUser];
}


+ (User *) sharedUser
{
    static User *sharedUser = nil;
    if (!sharedUser)
    {
        sharedUser = [[super allocWithZone:nil] init];
    }
    
    return sharedUser;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        tasks = [[NSMutableArray alloc] init];
        disciplines = [[NSMutableArray alloc] init];
        tests = [[NSMutableArray alloc] init];
    }
    
    return self;
}

// Task Methods
- (NSInteger) numberOfTasks
{
    return [tasks count];
}

- (Task *) taskAtIndex:(NSInteger)index
{
    return [tasks objectAtIndex:index];
}

- (void) createTask:(Task *)task
{
    [tasks addObject:task];
}


// Discipline Methods
- (NSInteger) numberOfDisciplines
{
    return [disciplines count];
}

- (Discipline *) disciplineAtIndex:(NSInteger)index
{
    return [disciplines objectAtIndex:index];
}

- (void) createDiscipline:(Discipline *)discipline
{
    [disciplines addObject:discipline];
}


// Discipline Methods
- (NSInteger) numberOfTests
{
    return [tests count];
}

- (Test *) testAtIndex:(NSInteger)index
{
    return [tests objectAtIndex:index];
}

- (void) createTest:(Test *)test
{
    [tests addObject:test];
}

@end
