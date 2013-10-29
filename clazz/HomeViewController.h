//
//  HomeViewController.h
//  clazz
//
//  Created by João Victor Chencci on 25/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSIndexPath *index;

@end
