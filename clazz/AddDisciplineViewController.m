//
//  AddDisciplineViewController.m
//  clazz
//
//  Created by Lucas Ramalho on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "AddDisciplineViewController.h"
#import "DisciplineListViewController.h"
#import "Discipline.h"
#import "User.h"

@interface AddDisciplineViewController ()

@property (weak, nonatomic) IBOutlet UITextField *disciplineName;
@property (weak, nonatomic) IBOutlet UITextView *disciplineDescription;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation AddDisciplineViewController

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
    self.disciplineDescription.layer.borderColor = [[UIColor colorWithRed:0.933 green:0.933 blue:1 alpha:1.0] CGColor];
    self.disciplineDescription.layer.borderWidth = borderWidth;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphone_bg.png"]];
    
	// Do any additional setup after loading the view.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    self.disciplineName.delegate = self;
    self.disciplineDescription.delegate = self;

    
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
- (IBAction)saveDiscipline:(id)sender {

    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open (dbpath, &_clazzDB) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO DISCIPLINES (NAME, DESCRIPTION) VALUES (\"%@\", \"%@\") ", _disciplineName.text, _disciplineDescription.text];
        
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
    
    
//    Discipline *newDiscipline = [[Discipline alloc] init];
//    [newDiscipline setName:self.disciplineName.text];
//    [newDiscipline setDescription:self.disciplineDescription.text];
//    
//    [[User sharedUser] createDiscipline:newDiscipline];
    
    [self performSegueWithIdentifier:@"backToDisciplines" sender:self];

}

-(void)dismissKeyboard
{
    [self.disciplineName resignFirstResponder];
    [self.disciplineDescription resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
