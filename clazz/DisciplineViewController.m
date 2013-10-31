//
//  DisciplineViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 30/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "DisciplineViewController.h"

@interface DisciplineViewController ()

@property (weak, nonatomic) IBOutlet UILabel *disciplineName;
@property (weak, nonatomic) IBOutlet UITextView *disciplineDescription;
@property (weak, nonatomic) IBOutlet UITableView *disciplineTaskList;
@property (weak, nonatomic) IBOutlet UITableView *disciplineTestList;

@end

@implementation DisciplineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.disciplineName.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:1 alpha:1];
    self.disciplineTaskList.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    self.disciplineTestList.backgroundColor = [UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
