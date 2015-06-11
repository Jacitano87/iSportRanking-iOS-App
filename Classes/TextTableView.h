//
//  TextTableView.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 18/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//


#import <UIKit/UIKit.h>

//questa classe viene utilizzata nella gestione delle informazioni relative al Ranking

@class MyCell;
@class Reachability;

/*
 Anche qui viene effettuato un controllo della connettività perchè ho la possibilità attraverso un pulsante
 Di accedere a dati presenti su Wikipedia.
 Inoltre questa tabella fa uso di celle ridefinite in un'altra classe
 
 */

@interface TextTableView : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	UITableView *myTable;
	
	//mi servono al momento dell'istanziazione della classe per salvarmi alcune informazioni relative alla cella cliccata
	NSString *texto;
	NSString *head;
	NSString *linko;
	
	
	MyCell *cell;
	
	//utilizzo di oggetti per la classe reachability
	
	Reachability* internetReach;
	Reachability* wifiReach;
	NSString *controllo;
	
}
//metodi utilizzati nella classe e costruttore

-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2;
-(void)moreInfo;
-(id)initWithStringa:(NSString *)stringa andTitle:(NSString *)titolo andLink:(NSString *)link;
@end
