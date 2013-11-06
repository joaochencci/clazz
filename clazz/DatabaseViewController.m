//
//  DatabaseViewController.m
//  clazz
//
//  Created by Joao Victor Chencci Marques on 31/10/13.
//  Copyright (c) 2013 João / Lucas. All rights reserved.
//

#import "DatabaseViewController.h"

@interface DatabaseViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name_field;
@property (weak, nonatomic) IBOutlet UITextField *address_field;
@property (weak, nonatomic) IBOutlet UITextField *phone_field;
@property (weak, nonatomic) IBOutlet UILabel *hidden_label;

@end

@implementation DatabaseViewController


- (IBAction)saveData:(id)sender {
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open (dbpath, &_clazzDB) == SQLITE_OK) {
        
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")", _name_field.text, _address_field.text, _phone_field.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_clazzDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            _hidden_label.text = @"Contact added";
            _name_field.text = @"";
            _address_field.text = @"";
            _phone_field.text = @"";
        } else {
            _hidden_label.text = @"Failed to add contact";
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_clazzDB);
    }
    
}

- (IBAction)findData:(id)sender {
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT address, phone FROM contacts WHERE name=\"%@\"", _name_field.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_clazzDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *addressField = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0) ];
                _address_field.text = addressField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1) ];
                _phone_field.text = phoneField;
                
                _hidden_label.text = @"Match found";
                
            }
//            else {
//                
//                _hidden_label.text = @"Match not found";
//                _address_field.text = @"";
//                _phone_field.text = @"";
//                
//            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_clazzDB);
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_clazzDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if (sqlite3_exec(_clazzDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _hidden_label.text = @"Failed to create table";
            }
            sqlite3_close(_clazzDB);
        } else {
            _hidden_label.text = @"Failed to open/create database";
        }
    }
}

-(void)dismissKeyboard
{
    [self.name_field resignFirstResponder];
    [self.address_field resignFirstResponder];
    [self.phone_field resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
