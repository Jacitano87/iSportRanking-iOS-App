    //
//  DatabasesViewController.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 11/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "DatabasesViewController.h"


@implementation DatabasesViewController

-(id)init{
	if(self=[super init])
	{
	[self openDB];
	}
    return self;
}

//METODO CHE SERVE A CERCARE O CREARE IL DATABASE NELLA POSIZIONE DOCUMENT

-(NSString *) filePath {
	NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir=[paths objectAtIndex:0];
	
	return [documentsDir stringByAppendingPathComponent:@"database.sql"];
	
}

//METODO PER L'APERTURA DEL DATABASE

-(void) openDB
{
	if(sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK)
	{
		sqlite3_close(db);
		NSAssert(0,@"database failed open");
	}
}

//CREAZIONE DELLA TABELLA

-(void) createTableNamed:(NSString *)tableName withField1:(NSString *)field1 withField2:(NSString *)field2 withField3:(NSString *)field3
{
	char *err;
	NSString *sql=[NSString stringWithFormat:
								            @"CREATE TABLE IF NOT EXISTS '%@' ('%@' INT PRIMARY KEY,'%@' TEXT,'%@' INT);",
				   tableName,field1,field2,field3];
	if(sqlite3_exec(db,[sql UTF8String],NULL,NULL, &err)!=SQLITE_OK)
	{
		sqlite3_close(db);
    NSAssert(0,@"database failed table create");
	}
	
}

//INSERIMENTO DEI RECORD

-(void)insertRicordIntoTableNamed:(NSString *)tableName 
					   
					   withField1:(NSString *)field1 
					  field1Value:(NSString *)field1Value
						
						andField2:(NSString *)field2
					  field2Value:(NSString *)field2Value
						
						andField3:(NSString *)field3
					  field3Value:(NSString *)field3Value

{
NSString *sql=[NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@'('%@','%@','%@') VALUES ('%@','%@','%@')",tableName,field1,field2,field3,field1Value,field2Value,field3Value];
char *err;
if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK)
{
	sqlite3_close(db);
	NSAssert(0,@"error updating table");
}
	
	
	
}

//PRELIEVO DEI DATI ED INSIERIMENTO IN UN ARRAY PROPERTY CHE POI VIENE RICHIAMATO DALL'ESTERNO

-(NSArray *)getAllRowsFromTableNamed:(NSString *)tableName
{
 	NSMutableArray *array1=[[NSMutableArray alloc]init];
	NSMutableArray *array2=[[NSMutableArray alloc]init];
	NSMutableArray *array3=[[NSMutableArray alloc]init];
	
	NSString *qsql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
	sqlite3_stmt *statement;
	
	if(sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, nil)==SQLITE_OK)
	{
	while (sqlite3_step(statement)==SQLITE_ROW) 
	{
		char *field1 = (char *) sqlite3_column_text(statement, 0);
		NSString *field1Str=[[NSString alloc]initWithUTF8String:field1];
		[array1 addObject:field1Str];
		[field1Str release];
		char *field2 = (char *) sqlite3_column_text(statement, 1);
		NSString *field2Str=[[NSString alloc]initWithUTF8String:field2];
		[array2 addObject:field2Str];
		[field2Str release];
		char *field3 = (char *) sqlite3_column_text(statement, 2);
		NSString *field3Str=[[NSString alloc]initWithUTF8String:field3];
		[array3 addObject:field3Str];
		[field3Str release];
		
	}	
		
		NSArray *array=[NSArray arrayWithObjects:array1,array2,array3,nil];
		[array1 release];
		[array2 release];
		[array3 release];
	    return array;
	}
	[array1 release];
	[array2 release];
	[array3 release];
	return nil;
}





// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}

- (void)viewDidLoad {
		[super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
