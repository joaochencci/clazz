//
//  TestListViewController.m
//  clazz
//
//  Created by João Victor Chencci on 29/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "TestListViewController.h"
#import "User.h"
#import "Test.h"

@interface TestListViewController ()

@end

@implementation TestListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Provas";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", (int)[[User sharedUser] numberOfTests]);
    return [[User sharedUser] numberOfTests];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    
    // set custom title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, (headerView.frame.size.height - 10)/2, 80, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:24]];
//    [label setText:@"Provas"];
    
    // add button for story creation
    //    UIButton *newStoryButton = [[UIButton alloc] initWithFrame:CGRectMake((headerView.frame.size.width - 150 - 10), (headerView.frame.size.height - 20)/2, 150, 20)];
    //    [newStoryButton setTitle:@"Nova Tarefa" forState:UIControlStateNormal];
    //    [newStoryButton addTarget:self action:@selector(goToStoryDataManagement) forControlEvents:UIControlEventTouchUpInside];
    
    // add element to view
    [headerView addSubview:label];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1]];
    //    [headerView addSubview:newStoryButton];
    
    // [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"testIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // get element from store
    Test *currentTest = [[User sharedUser] testAtIndex:[indexPath row] ];
    
    
	// Set up the cell
	cell.textLabel.text = currentTest.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Somente uma prova"];
    if (indexPath.row == 0) [cell setBackgroundColor:[UIColor whiteColor]];
    else [cell setBackgroundColor:[UIColor colorWithRed:0.6 green:0.8 blue:1 alpha:1]];
    
	return cell;
}


#pragma mark Selector Methods
- (void) goToStoryDataManagement
{
    [self performSegueWithIdentifier:@"GoToStoryDataManagementSegue" sender:self];
}


@end
