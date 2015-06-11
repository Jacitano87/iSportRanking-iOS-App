//
//  DatabasesViewController.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 11/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

/*
 QUESTA CLASSE NON FA ALTRO CHE CREARE DA ZERO IL DATABASE E POI PIAN PIANO INSERIRE I DATI
 E FETCHARLI QUANDO VENGONO RICHIESTI PER ESSERE MOSTRATI ALL'UTENTE
 L'IMPLEMENTAZIONE DEL DATABASE è STANDARD, COME NELLA DOCUMENTAZIONE APPLE E COME DESCRITTA DAI LIBRI
 
 */


@interface DatabasesViewController : UIViewController {

	sqlite3 *db;
	
}
-(NSString *)filePath;
-(void)openDB;

//METODO PER CREARE LA TABELLA
-(void)createTableNamed:(NSString *)tableName withField1:(NSString *)field1 withField2:(NSString *)field2 withField3:(NSString *)field3;
//METODO PER L'INSERIMENTO DEI DATI
-(void)insertRicordIntoTableNamed:(NSString *)tableName 
					   
					   withField1:(NSString *)field1 
					  field1Value:(NSString *)field1Value
						
						andField2:(NSString *)field2
					  field2Value:(NSString *)field2Value
						
						andField3:(NSString *)field3
					  field3Value:(NSString *)field3Value;
//METODO PER LA RESTITUZIONE DEI DATI
-(NSArray *)getAllRowsFromTableNamed:(NSString *)tableName;

@end
