//
//  SerieAtableView.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 12/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>




//questa classe mi serve nella gestione delle informazioni relative a calcio,rugby,tennis e altri sport
//utilizzo della classe Reachability per il controllo della connessione wi-fi o 3g
@class Reachability;
@interface aTableView : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	
	//array che utilizzo come datasource per i dati prelevati dal database
	NSArray *array1;
	NSArray *array2;
	NSArray *array3;
	
	//array che utilizzo come indice per la creazione delle righe dalla tabella
	NSMutableArray *indice;
	
	//oggetti locali che vengono iniliziazzate nel costruttore e che utilizzo per controlli sul database
	NSString *tabel;
	NSString *controllo;
	NSString *controlloSport;
	
	
	UITableView * myTable;
	
	
	//oggetti istanziati dalla classe reachability che mi servono per controllare la connessione se presente
	Reachability* internetReach;
	Reachability* wifiReach;
	
	
}
//metodi della classe
-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2 andIndex:(NSIndexPath *)indexPath;
-(id)initWithTabella:(NSString *)tabella andValue:(NSString *)value andSport:(NSString *)sport andTitle:(NSString *)titolo;
@end
