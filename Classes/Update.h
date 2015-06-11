//
//  Update.h
//  iWRankigIphone
//
//  Created by Antonio Fischetti on 23/12/10.
//  Copyright 2010 Amministatore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TFHpple;
@class LoadData;
@class DatabasesViewController;

/*
 IL METODO CHE RICHIEDE PIù ALLOCAZIONE DI MEMORIA è QUESTO, IL QUALE SI OCCUPA DELL'UPDATE DEI DATI E IL 
 SALVATAGGIO SUL DATABASE,QUESTO INFATTI CONTIENE I METODI PER EFFETTUARE I RELATIVI AGGIORNAMENTI RIGUARDANTI
 TUTTI GLI SPORT.PERMETTE QUINDI DI TENERE IMMAGANIZZATI TUTTI I DATI PRELEVATI IMMETTENDOLI NEL DATABASE
 OVVIAMENTE DELEGA L'OGGETTO LOADDATA CHE SI OCCUPERà DI RITORNARE I DATI PRELEVATI DAL SERVER
 */



@interface Update : NSObject <UIAlertViewDelegate> {
	
	id delegate;
	SEL delegateMethod;
	
	UIAlertView *alertView3;
	DatabasesViewController *db;
	NSTimer * timer;
	NSXMLParser * XMLparser;
	
	
}
@property(nonatomic,assign)id delegate;
@property(nonatomic)SEL delegateMethod;
-(void)effettuaUpdateCalcio;
-(void)effettuaUpdateRugby;
-(void)effettuaUpdateTennis;
-(void)effettuaUpdateAltro;




-(void)errore:(id)sender;
@end
