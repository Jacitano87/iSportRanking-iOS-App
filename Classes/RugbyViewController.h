//
//  RugbyViewController.h
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

//RUGBY VIEW CONTROLLER MI GESTISCE IL RUGBY

/*
 Il soccer, come il rugby , tennis e other, fanno uso di tabelle
 quindi la gestione delle stesse è simile per tutte e quattro le view controller associate,
 cioè fanno usao di un datasouce che tiene conto della competizione relativa e 
 delle immagini associate nella cartella resource
 */

@interface RugbyViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	UITableView * myTable;
		NSArray * campionati;
		NSArray * immagini;
	    NSInteger myTag;
}
-(id)initWithTitle:(NSString *)aTitle andImage:(NSString *)anImage andTag:(NSInteger)aTag;

@end
