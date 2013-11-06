//
//  Task.h
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *name;           //form
@property (strong, nonatomic) NSString *description;    //form
@property (strong, nonatomic) NSString *discipline;     //form
@property (strong, nonatomic) NSString *test;           //form

@property (strong, nonatomic) NSString *initialDate;      //form
@property (strong, nonatomic) NSString *finishDate;       //form

@property (nonatomic) NSInteger important;                   //form
@property (nonatomic) NSInteger conclude;

@end
