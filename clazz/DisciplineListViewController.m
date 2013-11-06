//
//  DisciplineListViewController.m
//  clazz
//
//  Created by João Victor Chencci on 29/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

//@property (strong, nonatomic) NSString *name;           //form
//@property (strong, nonatomic) NSString *description;    //form
//@property (strong, nonatomic) NSMutableArray *tests;


#import "DisciplineListViewController.h"
#import "DisciplineViewController.h"
#import "User.h"
#import "Discipline.h"

@interface DisciplineListViewController ()

@property (strong, nonatomic) NSMutableArray *disciplines;

@end

@implementation DisciplineListViewController

int i = 0;

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
    
    self.title = @"Minhas Disciplinas";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.separatorStyle = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
    
    _disciplines = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"disciplines.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS DISCIPLINES (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT)";
            
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT NAME, DESCRIPTION FROM DISCIPLINES"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_clazzDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                Discipline *newDiscipline = [[Discipline alloc] init];
                
                newDiscipline.name = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0) ];
                newDiscipline.description = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1) ];
                
                [_disciplines addObject:newDiscipline];
                
                NSLog(@"Match found");
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_clazzDB);
    }
    
    NSLog(@"%d", (int)[[User sharedUser] numberOfDisciplines]);
    return [_disciplines count]/2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create header view
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    
    // set custom title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, (headerView.frame.size.height - 10)/2, 80, 20)];
    [label setFont:[UIFont boldSystemFontOfSize:24]];
    //    [label setText:@"Disciplinas"];
    
    // add button for story creation
    UIButton *newStoryButton = [[UIButton alloc] initWithFrame:CGRectMake((headerView.frame.size.width - 310 - 20), (headerView.frame.size.height - 70)/3, 350, 70)];
    [newStoryButton setTitle:@"+ nova disciplina" forState:UIControlStateNormal];
    [[newStoryButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    [[newStoryButton layer] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor];

    
    [newStoryButton addTarget:self action:@selector(goToAddDiscipline) forControlEvents:UIControlEventTouchUpInside];
    
    // add element to view
    [headerView addSubview:label];
//    [headerView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1]];
    [headerView addSubview:newStoryButton];
    
    // [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"disciplineIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    // get element from store
    Discipline *currentDiscipline = [[Discipline alloc] init];
    
    if (_disciplines.count > 0) {
        currentDiscipline = _disciplines[i];
        i++;
    } else {
        [currentDiscipline setName:@""];
    }

    
    
	// Set up the cell
	cell.textLabel.text = currentDiscipline.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:currentDiscipline.description];
    
//    if (indexPath.row%2 == 0)
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4]];
//    else [cell setBackgroundColor:[UIColor colorWithRed:0.6 green:0.8 blue:1 alpha:1]];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDisciplineDetails" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDisciplineDetails"])
    {
        DisciplineViewController *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        int row = (int)[myIndexPath row];
        Discipline *sessionDiscipline = _disciplines[row];
        
        detailViewController.disciplineDetailModel = @[sessionDiscipline.name,
                                                       sessionDiscipline.description
                                                       ];
    }
}

#pragma mark Selector Methods
- (void) goToAddDiscipline
{
    [self performSegueWithIdentifier:@"addDiscipline" sender:self];
}


@end