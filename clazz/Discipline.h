//
//  Discipline.h
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Discipline : NSObject

@property (strong, nonatomic) NSString *name;           //form
@property (strong, nonatomic) NSString *description;    //form
@property (strong, nonatomic) NSMutableArray *tests;

- (BOOL) createTestWithName:(NSString *)name andPonder:(NSInteger *)ponder;

@end
