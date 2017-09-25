//
//  DatabaseViewController.m
//  SQLite Assignment
//
//  Created by Anvit on 9/23/17.
//  Copyright © 2017 Anvit. All rights reserved.
//

#import "DatabaseViewController.h"

@interface DatabaseViewController ()

@end

@implementation DatabaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

    
    NSLog(@"\nDBPath %@\n", docsDir);

    
    
    NSFileManager *filemgr = [NSFileManager defaultManager];

    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        NSLog(@"Inside if path");
       const char *dbpath = [_databasePath UTF8String];

       if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
       {
           NSLog(@"Inside db");
            char *errMsg;
            const char *sql_stmt =
           "CREATE TABLE IF NOT EXISTS CONTACTS_A (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT, LOCATION TEXT, EMAIL TEXT)";
           
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                 _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
                 _status.text = @"Failed to open/create database";
        }
    } else {
        NSLog(@"Inside else path");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
     sqlite3_stmt    *statement;
     const char *dbpath = [_databasePath UTF8String];

     if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
     {

           NSString *insertSQL = [NSString stringWithFormat:
             @"INSERT INTO CONTACTS_A (name, address, phone, location, email) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
             _name.text, _address.text, _phone.text, _location.text, _email.text];

           const char *insert_stmt = [insertSQL UTF8String];
           sqlite3_prepare_v2(_contactDB, insert_stmt,
             -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                 _status.text = @"Contact added";
                 _name.text = @"";
                 _address.text = @"";
                 _phone.text = @"";
                _location.text = @"";
                _email.text = @"";
            } else {
                NSLog(@"Insert failure: %s", sqlite3_errmsg(_contactDB));
                 _status.text = @"Failed to add contact";
            }
            sqlite3_finalize(statement);
            sqlite3_close(_contactDB);
    }

}

- (IBAction)findContact:(id)sender {
     const char *dbpath = [_databasePath UTF8String];
     sqlite3_stmt    *statement;

     if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
     {
             NSString *querySQL = [NSString stringWithFormat:
               @"SELECT address, phone, location, email FROM contacts_a WHERE name=\"%@\"",
               _name.text];

             const char *query_stmt = [querySQL UTF8String];

             if (sqlite3_prepare_v2(_contactDB,
                 query_stmt, -1, &statement, NULL) == SQLITE_OK)
             {
                     if (sqlite3_step(statement) == SQLITE_ROW)
                     {
                             NSString *addressField = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                  statement, 0)];
                             _address.text = addressField;
                             NSString *phoneField = [[NSString alloc]
                                 initWithUTF8String:(const char *)
                                 sqlite3_column_text(statement, 1)];
                             _phone.text = phoneField;
                            NSString *locationField = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                statement, 2)];
                            _location.text = locationField;
                         NSString *emailField = [[NSString alloc]
                                initWithUTF8String:
                                (const char *) sqlite3_column_text(
                                statement, 3)];
                            _email.text = emailField;
                             _status.text = @"Match found";
                     } else {
                             _status.text = @"Match not found";
                             _address.text = @"";
                             _phone.text = @"";
                            _location.text = @"";
                            _email.text = @"";
                     }
                     sqlite3_finalize(statement);
             }
             sqlite3_close(_contactDB);
     }

}
@end
