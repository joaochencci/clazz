//
//  Test.h
//  Clazz
//
//  Created by João Victor Chencci on 24/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

                                                    // listar as nossas disciplinas e escolher uma
@property (strong, nonatomic) NSString *name;       // form
@property (strong, nonatomic) NSString *discipline;       // form
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger ponder;            // form

@end
