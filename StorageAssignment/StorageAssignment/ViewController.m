//
//  ViewController.m
//  StorageAssignment
//
//  Created by Student on 9/12/17.
//  Copyright © 2017 Anvit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveToFile:(id)sender {
    NSLog(@"This data will save to file");
    NSFileManager *filemgr;
    NSData * datatosave;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *strbookname;
    NSString *strauthorname;
    NSString *strdescription;
    NSString *strdata;
    
    strbookname=[@"Bookname : " stringByAppendingString:_txtbookname.text];
    strauthorname =[@"Authorname : " stringByAppendingString:_txtauthorname.text];
    strdescription=[@"Description : " stringByAppendingString:_txtdescription.text];
    strdata=[NSString stringWithFormat:@"%@\n%@\n%@",strbookname,strauthorname,strdescription];
    
    
    filemgr =[NSFileManager defaultManager];
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir=[dirPaths objectAtIndex:0];
    dataFile=[docsDir stringByAppendingPathComponent:@"savetofile.dat"];
    NSLog(@"This data will save to file == %@", dataFile);
    
    datatosave = [strdata dataUsingEncoding:NSASCIIStringEncoding];
    [filemgr createFileAtPath:dataFile contents:datatosave attributes:nil];
}

- (IBAction)saveToArchive:(id)sender {
    NSLog(@"This data will save to Archive");
    NSMutableArray 	*dataArray;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir=[dirPaths objectAtIndex:0];
    dataFile=[docsDir stringByAppendingPathComponent:@"savetoArchive.dat"];
    dataArray=[[NSMutableArray alloc] init];
    [dataArray addObject:_txtbookname.text];
    [dataArray addObject:_txtauthorname.text];
    [dataArray addObject:_txtdescription.text];
    [NSKeyedArchiver archiveRootObject:dataArray toFile:dataFile];
    NSLog(@"This data will archive to file == %@", dataFile);
    
}

@end
