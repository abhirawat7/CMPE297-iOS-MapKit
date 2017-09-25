//
//  DatabaseViewController.h
//  SQLite Assignment
//
//  Created by Anvit on 9/23/17.
//  Copyright © 2017 Anvit. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DatabaseViewController : UIViewController

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)saveData:(id)sender;
- (IBAction)findContact:(id)sender;

@end
