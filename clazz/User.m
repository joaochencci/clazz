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
        
        Task *tarefa1 = [[Task alloc] init];
        tarefa1.name = @"Tarefa 1";
        tarefa1.discipline = @"MC102";
        tarefa1.test = @"P1";
        tarefa1.description = @"Tarefa Descrita Aqui";
        
        Task *tarefa2 = [[Task alloc] init];
        [tarefa2 setName:@"Tarefa 2"];
        tarefa2.discipline = @"MC202";
        tarefa2.test = @"T1";
        tarefa2.description = @"Tarefa Descrita Aqui";
        
        Task *tarefa3 = [[Task alloc] init];
        [tarefa3 setName:@"Tarefa 3"];
        tarefa3.discipline = @"MC302";
        tarefa3.test = @"P2";
        tarefa3.description = @"Tarefa Descrita Aqui";
        
        [tasks addObject:tarefa1];
        [tasks addObject:tarefa2];
        [tasks addObject:tarefa3];
        
        Discipline *disc1 = [[Discipline alloc] init];
        disc1.name = @"MC102";
        disc1.description = @"Introdução à Programação";
        
        Discipline *disc2 = [[Discipline alloc] init];
        disc2.name = @"MC202";
        disc2.description = @"Estrutura de Dados";
        
        [disciplines addObject:disc1];
        [disciplines addObject:disc2];
        
        Test *test1 = [[Test alloc] init];
        test1.name = @"P1";
        
        Test *test2 = [[Test alloc] init];
        test2.name = @"P2";
        
        Test *test3 = [[Test alloc] init];
        test3.name = @"P3";
        
        Test *test4 = [[Test alloc] init];
        test4.name = @"P4";
        
        [tests addObject:test1];
        [tests addObject:test2];
        [tests addObject:test3];
        [tests addObject:test4];
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
