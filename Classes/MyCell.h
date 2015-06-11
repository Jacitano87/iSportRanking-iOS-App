//
//  MyCell.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 18/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

//Redifinizione delle celle della tabella

@interface MyCell : UITableViewCell {
	UILabel *label1;
}
//property che mi serve per settare alcune impostazioni della label da altre classi.

@property(nonatomic,retain)UILabel *label1;
@end
