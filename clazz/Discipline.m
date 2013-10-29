//
//  Discipline.m
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "Discipline.h"
#import "User.h"
#import "Test.h"

@implementation Discipline

- (BOOL) createTestWithName:(NSString *)name andPonder:(NSInteger *)ponder {
    Test *newTest = [[Test alloc] init];
    [newTest setName:name];
    [newTest setPonder:ponder];
    [newTest setScore:0];
    
    int prevCount = [[self tests] count];
    [[self tests] addObject:newTest];
    
    if([[self tests]count] > prevCount){
        return YES;
    } else {
        return NO;
    }
}

@end
