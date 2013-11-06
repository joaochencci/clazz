//
//  AddTestViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "AddTestViewController.h"
#import "Test.h"
#import "User.h"


@interface AddTestViewController ()

@property (weak, nonatomic) IBOutlet UITextField *testName;
@property (weak, nonatomic) IBOutlet UITextField *testPonder;
@property (strong, nonatomic) IBOutlet UITextField *testDiscipline;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation AddTestViewController

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
    
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    self.testName.delegate = self;
    self.testPonder.delegate = self;

    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"tests.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS TESTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SCORE INTEGER, PONDER INTEGER, DISCIPLINE TEXT)";
            
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

-(void)dismissKeyboard
{
    [self.testName resignFirstResponder];
    [self.testPonder resignFirstResponder];
    
}
- (IBAction)saveTest:(id)sender {

    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open (dbpath, &_clazzDB) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TESTS (NAME, SCORE, PONDER, DISCIPLINE) VALUES (\"%@\", \"%d\", \"%d\",\"%@\") ", _testName.text, 0, 4, _testDiscipline.text];
        
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
    
    
//    Test *newTest = [[Test alloc] init];
//    [newTest setName:self.testName.text];
//    [newTest setPonder: [self.testPonder.text integerValue]];
//    
//    [[User sharedUser] createTest:newTest];
    
    [self performSegueWithIdentifier:@"backToTests" sender:self];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
