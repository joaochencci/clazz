//
//  TaskListViewController.m
//  clazz
//
//  Created by João Victor Chencci on 29/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//



//@property (strong, nonatomic) NSString *name;           //form
//@property (strong, nonatomic) NSString *description;    //form
//@property (strong, nonatomic) NSString *discipline;     //form
//@property (strong, nonatomic) NSString *test;           //form
//@property (strong, nonatomic) NSNumber *conclude;
//@property (strong, nonatomic) NSDate *createDate;
//@property (strong, nonatomic) NSDate *initialDate;      //form
//@property (strong, nonatomic) NSDate *finishDate;       //form
//@property (nonatomic) BOOL important;                   //form

#import "TaskListViewController.h"
#import "TaskViewController.h"
#import "User.h"
#import "Task.h"

@interface TaskListViewController ()

@property (strong, nonatomic) NSMutableArray *tasks;

@end

@implementation TaskListViewController

int idx = 0;

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
    

    
    self.title = @"Minhas Tarefas";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
    
    _tasks = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"tasks.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS TASKS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT, DISCIPLINE TEXT, CONCLUDE INTEGER, IMPORTANT INTEGER, INITIAL TEXT, FINAL TEXT)";
            
            if (sqlite3_exec(_clazzDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_clazzDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
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

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT name, description, discipline, conclude, important, initial, final FROM tasks"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_clazzDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Task *newTask = [[Task alloc] init];
                
                newTask.name = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0) ];
                newTask.description = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1) ];
                newTask.discipline = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2) ];
                newTask.conclude = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 3) ] integerValue];
                newTask.important = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 4) ] integerValue];
                newTask.initialDate = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 5) ];
                newTask.finishDate = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 6) ];
                
                [_tasks addObject:newTask];
                
                NSLog(@"Match found");
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_clazzDB);
    }
    
    return ([_tasks count]/2);
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    
    // set custom title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, (headerView.frame.size.height - 10)/2, 80, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:24]];
    //    [label setText:@"Tarefas"];
    
    
    // add button for story creation
    UIButton *newStoryButton = [[UIButton alloc] initWithFrame:CGRectMake((headerView.frame.size.width - 310 - 20), (headerView.frame.size.height - 70)/3, 350, 70)];
    [newStoryButton setTitle:@"+ nova tarefa" forState:UIControlStateNormal];
    [[newStoryButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    [[newStoryButton layer] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor];
    
    [newStoryButton addTarget:self action:@selector(goToAddTask) forControlEvents:UIControlEventTouchUpInside];

    // add element to view
    [headerView addSubview:label];
//    [headerView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1]];
    [headerView addSubview:newStoryButton];
    
    // [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"taskIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // get element from store

    Task *currentTask = [[Task alloc] init];
    
    if (_tasks.count > 0) {
        currentTask = _tasks[idx];
        idx++;
    } else {
        [currentTask setName:@""];
    }
    
	// Set up the cell
	cell.textLabel.text = currentTask.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:currentTask.description];
//    if (indexPath.row%2 == 0)
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4]];
//    else [cell setBackgroundColor:[UIColor colorWithRed:0.6 green:0.8 blue:1 alpha:1]];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showTaskDetails" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTaskDetails"])
    {
        TaskViewController *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        int row = (int)[myIndexPath row];
        NSNumber *position = [[NSNumber alloc] initWithInt:row];
        Task *sessionTask = _tasks[row];
        
        detailViewController.taskDetailModel = @[position,
                                                 sessionTask.name,
                                                 sessionTask.description,
                                                 sessionTask.discipline,
                                                 sessionTask.initialDate,
                                                 sessionTask.finishDate
                                                 ];
    }
}

#pragma mark Selector Methods
- (void) goToAddTask
{
    [self performSegueWithIdentifier:@"addTask" sender:self];
}


@end
