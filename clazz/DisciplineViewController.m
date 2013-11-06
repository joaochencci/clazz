//
//  DisciplineViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 30/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "DisciplineViewController.h"
#import "Task.h"
#import "Test.h"

@interface DisciplineViewController ()

@property (weak, nonatomic) IBOutlet UILabel *disciplineName;
@property (weak, nonatomic) IBOutlet UITextView *disciplineDescription;

@property (weak, nonatomic) IBOutlet UITableView *disciplineTaskList;
@property (weak, nonatomic) IBOutlet UITableView *disciplineTestList;

@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSMutableArray *tests;
@end

@implementation DisciplineViewController

int momentTask = 0;
int momentTest = 0;

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
    self.disciplineTestList.dataSource = self;
    self.disciplineTestList.delegate = self;
    
    self.disciplineTaskList.dataSource = self;
    self.disciplineTaskList.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];

    [self.disciplineName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    self.disciplineDescription.backgroundColor = [UIColor clearColor];
    self.disciplineTaskList.backgroundColor = [UIColor clearColor];
    self.disciplineTestList.backgroundColor = [UIColor clearColor];
    
    self.disciplineTaskList.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.disciplineTestList.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    
    _tasks = [[NSMutableArray alloc] init];
    _tests = [[NSMutableArray alloc] init];
    
    _disciplineName.text = _disciplineDetailModel[0];
    _disciplineDescription.text = _disciplineDetailModel[1];
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"tasks.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //ABRINDO BANCO DE TAREFAS
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS TASKS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT, DISCIPLINE TEXT, CONCLUDE INTEGER, IMPORTANT INTEGER)";
            
            if (sqlite3_exec(_clazzDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            } else {
                NSLog(@"Success to create table");
            }
            sqlite3_close(_clazzDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    
    //FILTRANDO AS TAREFAS
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT name, description, discipline, conclude, important FROM tasks WHERE discipline=\"%@\"", _disciplineName.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_clazzDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Task *newTask = [[Task alloc] init];
                
                newTask.name = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0) ];
                newTask.description = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1) ];
                newTask.discipline = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2) ];
                newTask.conclude = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 3) ] integerValue];
                newTask.important = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 4) ] integerValue];
                
                [_tasks addObject:newTask];
                
                NSLog(@"Match found");
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_clazzDB);
    }
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    filemgr = [NSFileManager defaultManager];
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"tests.db"]];
    const char *dbpathS = [_databasePath UTF8String];
    sqlite3_stmt *statementS;
    
    
//    //ABRINDO BANCO DE PROVAS
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
//        const char *dbpath = [_databasePath UTF8String];
//        
//        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
//        {
//            char *errMsg;
//            const char *sql_stmt =
//            "CREATE TABLE IF NOT EXISTS TESTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT,  DISCIPLINE TEXT, SCORE INTEGER, PONDER INTEGER)";
//            
//            if (sqlite3_exec(_clazzDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//            {
//                NSLog(@"Failed to create table");
//            } else {
//                NSLog(@"Success to create table");
//            }
//            sqlite3_close(_clazzDB);
//        } else {
//            NSLog(@"Failed to open/create database");
//        }
//    }
//    
//    
//    //FILTRANDO AS PROVAS
//    if (sqlite3_open(dbpathS, &_clazzDB) == SQLITE_OK)
//    {
//        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE discipline=\"%@\"", _disciplineName.text];
//        
//        const char *query_stmt = [querySQL UTF8String];
//        
//        if (sqlite3_prepare_v2(_clazzDB, query_stmt, -1, &statementS, NULL) == SQLITE_OK) {
//            
//            while (sqlite3_step(statementS) == SQLITE_ROW) {
//                
//                Test *newTest= [[Test alloc] init];
//                
//                newTest.name = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statementS, 0) ];
//                newTest.discipline = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1) ];
//                newTest.score = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 2) ] integerValue];
//                newTest.ponder = [[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 3) ] integerValue];
//                
//                [_tests addObject:newTest];
//                
//                NSLog(@"Match found");
//                
//            }
//            
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(_clazzDB);
//    }
    
    NSLog(@"Parou aqui");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _disciplineTaskList){
        return ([_tasks count]);
    } else {
        return ([_tests count]);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _disciplineTaskList) {
        NSString *cellIdentifier = @"taskByDisc";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        // get element from store
        
        Task *currentTask = [[Task alloc] init];
        
        if (_tasks.count > 0) {
            currentTask = _tasks[momentTask];
            momentTask++;
        } else {
            [currentTask setName:@""];
        }
        
        // Set up the cell
        cell.textLabel.text = currentTask.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:currentTask.description];
        //    if (indexPath.row%2 == 0)
        [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        //    else [cell setBackgroundColor:[UIColor colorWithRed:0.6 green:0.8 blue:1 alpha:1]];
        
        return cell;
    } else {
        NSString *cellIdentifier = @"testByDisc";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        
        // get element from store
        
        Test *currentTest = [[Test alloc] init];
        
        if (_tests.count > 0) {
            currentTest = _tests[momentTest];
            momentTest++;
        } else {
            [currentTest setName:@""];
        }
        
        // Set up the cell
        cell.textLabel.text = currentTest.name;
//        cell.detailTextLabel.text = [NSString stringWithFormat:currentTest.description];
        //    if (indexPath.row%2 == 0)
        [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        //    else [cell setBackgroundColor:[UIColor colorWithRed:0.6 green:0.8 blue:1 alpha:1]];
        
        return cell;
    }
}

@end
