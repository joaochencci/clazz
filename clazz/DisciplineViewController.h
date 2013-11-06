//
//  DisciplineViewController.h
//  clazz
//
//  Created by João Victor Chencci on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DisciplineViewController : UIViewController

@property (strong, nonatomic) NSArray *disciplineDetailModel;
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *clazzDB;

@end
