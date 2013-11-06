//
//  AddTaskViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "User.h"

@interface AddTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDiscipline;
@property (weak, nonatomic) IBOutlet UITextField *taskInitialDate;
@property (weak, nonatomic) IBOutlet UITextField *taskFinalDate;
@property (weak, nonatomic) IBOutlet UITextView *taskDescription;
@property (weak, nonatomic) IBOutlet UISwitch *importantTask;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    // call super
    [super viewWillAppear:animated];
    
    // set border to textview
    CGFloat borderWidth = 0.8;
    self.taskDescription.layer.borderColor = [[UIColor colorWithRed:0.933 green:0.933 blue:1 alpha:1.0] CGColor];
    self.taskDescription.layer.borderWidth = borderWidth;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    self.taskName.delegate = self;
    self.taskDiscipline.delegate = self;
    self.taskInitialDate.delegate = self;
    self.taskFinalDate.delegate = self;
    self.taskDescription.delegate = self;
    
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

- (IBAction)taskIsImportant:(id)sender {
}

-(void)dismissKeyboard
{
    [self.taskName resignFirstResponder];
    [self.taskDiscipline resignFirstResponder];
    [self.taskInitialDate resignFirstResponder];
    [self.taskFinalDate resignFirstResponder];
    [self.taskDescription resignFirstResponder];
    
}
- (IBAction)saveTask:(id)sender {

    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    NSInteger valueImportant = self.importantTask.on;
    
    if (sqlite3_open (dbpath, &_clazzDB) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO tasks (name, description, discipline, conclude, important, initial, final) VALUES (\"%@\", \"%@\", \"%@\", \"%d\", \"%ld\", \"%@\", \"%@\")", _taskName.text, _taskDescription.text, _taskDiscipline.text, 50, (long)valueImportant, _taskInitialDate.text, _taskFinalDate.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_clazzDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Contact added");
        } else {
            NSLog(@"Failed to add contact");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_clazzDB);
    }
    
    
//    Task *newTask = [[Task alloc] init];
//    [newTask setName:self.taskName.text];
//    [newTask setDescription:self.taskDescription.text];
//    [newTask setTest:self.taskTest.text];
//    [newTask setDiscipline:self.taskDiscipline.text];
//    
//    [[User sharedUser] createTask:newTask];
    
    [self performSegueWithIdentifier:@"backToTasks" sender:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
