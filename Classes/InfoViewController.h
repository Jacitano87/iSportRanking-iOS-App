//
//  InfoViewController.h
//  iSportRankings
//
//  Created by Antonio Fischetti on 21/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

//Questa classe si occupa della gestione di informazioni sulla creazione dell'app


@interface InfoViewController : UIViewController {
UIView *contentView;
	
	//Oggetti UILabel
	
	UILabel *newLabel;
	UILabel *newLabel2;
	UILabel *newLabel3;
	UILabel *newLabel4;
	UILabel *newLabel5;
	UILabel *newLabel6;
	UILabel *newLabel7;
	UILabel *newLabel8;
	UILabel *newLabel9;
	CGRect rett;
}
-(void)back;
- (id)initWithFrame:(CGRect)rect;
@end
