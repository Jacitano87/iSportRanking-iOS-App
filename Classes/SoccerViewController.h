//
//  SoccerViewController.h
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

//SOCCER VIEW CONTROLLER CHE GESTISCE IL CALCIO

/*
 Il soccer, come il rugby , tennis e other, fanno uso di tabelle
 quindi la gestione delle stesse è simile per tutte e quattro le view controller associate,
 cioè fanno usao di un datasouce che tiene conto della competizione relativa e 
 delle immagini associate nella cartella resource
 */

@interface SoccerViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{

	//Il mio DataSource per i relativi campionati e immagini che devono apparire.
	
	NSArray * campionati;
	NSArray * immagini;
	
	
	UITableView * myTable;
	NSInteger myTag;
}
-(id)initWithTitle:(NSString *)aTitle andImage:(NSString *)anImage andTag:(NSInteger)aTag;
@end
