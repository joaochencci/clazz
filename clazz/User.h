//
//  User.h
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "Discipline.h"
#import "Test.h"

@interface User : NSObject
{
    NSMutableArray *tasks;
    NSMutableArray *disciplines;
    NSMutableArray *tests;
}
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *school;

+ (User *) sharedUser;

- (void) createTask:(Task *)task;
- (NSInteger) numberOfTasks;
- (Task *) taskAtIndex:(NSInteger)index;

- (void) createDiscipline:(Discipline *)discipline;
- (NSInteger) numberOfDisciplines;
- (Discipline *) disciplineAtIndex:(NSInteger)index;

- (void) createTest:(Test *)test;
- (NSInteger) numberOfTests;
- (Test *) testAtIndex:(NSInteger)index;

@end