//
//  ViewController.h
//  StorageAssignment
//
//  Created by Student on 9/12/17.
//  Copyright © 2017 Anvit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtbookname;
@property (strong, nonatomic) IBOutlet UITextField *txtauthorname;
@property (strong, nonatomic) IBOutlet UITextView  *txtdescription;

- (IBAction)saveToFile:(id)sender;

- (IBAction)saveToArchive:(id)sender;

- (IBAction)readFromFile:(id)sender;


- (IBAction)readFromArchive:(id)sender;

@end


