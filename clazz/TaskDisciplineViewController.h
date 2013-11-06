//
//  TaskDisciplineViewController.h
//  clazz
//
//  Created by João Victor Chencci on 01/11/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TaskDisciplineViewController : UIViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *clazzDB;

@end
