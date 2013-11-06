//
//  TestListViewController.h
//  clazz
//
//  Created by João Victor Chencci on 29/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TestListViewController : UITableViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *clazzDB;

@end
