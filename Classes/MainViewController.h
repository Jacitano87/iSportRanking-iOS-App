//
//  MainViewController.h
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Update;
@class Reachability;

//setto il delegato UIActionSheetDelegate poiche lo mostro la prima volta che mando in esecuzione l'app

@interface MainViewController : UIViewController <UIActionSheetDelegate>{
    UIView *contentView;
	
	//Ho creato un segmentedControl per gestire due scelte nel MainViewController
	
	UISegmentedControl * segmentedControl;
	UIActionSheet *action;
	
	/*poichè questa classe è adibita all'aggiornamento dei dati dal server
	  Creo un oggetto della classe Update che mi servirà poi ad effettuare 
	  Lo stesso aggiornamento.
	 */
	Update *up;
	
	//Controlli
	NSString *controllo;
	NSInteger myTag;
}

//Alcuni metodi che vengono richiamati al momento del click di alcuni pulsanti
-(void)rilascia:(id)sender;
-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2;
-(id)initWithTitle:(NSString *)aTitle andImage:(NSString *)anImage andTag:(NSInteger)aTag;
-(void)updateData;
-(void)cliccato:(id)sender;
@end
