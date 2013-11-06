//
//  DatabaseViewController.h
//  clazz
//
//  Created by Joao Victor Chencci Marques on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DatabaseViewController : UIViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *clazzDB;

@end
