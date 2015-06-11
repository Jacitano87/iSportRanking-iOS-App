//
//  RankingTableView.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 15/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Questa classe si occupa della gestione della tabella relativa a alcune informazioni
 Sui Ranking di alcuni sport, che poi attravero sottoTabelle, permette di visionare alcune
 Informazioni presenti e altre di visionarle su wikipedia
 */

@interface RankingTableView : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    UITableView * myTable;
	
	//Sono degli array che utilizzo per la creazione della tabella e per passare poi alla sottotabella informazioni sul link da visualizzare
	NSArray * campionati;
	NSArray * immagini;
	NSArray * link;
	NSMutableArray * informazioni;
}

@end
