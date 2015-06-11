//
//  MyCell.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 18/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "MyCell.h"


@implementation MyCell
@synthesize label1;

//costruttore della classe, con relativa implementazione dell'oggetto UILabel

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//
		label1=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, 280, 330)];
		
		label1.backgroundColor=[UIColor clearColor];
		label1.numberOfLines=50;
		label1.textAlignment=UITextAlignmentCenter;
		label1.font=[UIFont boldSystemFontOfSize:16];
				
		[self.contentView addSubview:label1];
		[label1 release];
    }
    return self;
}
	
- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    // Non deve succedere nulla se clicco
}


- (void)dealloc {
    [super dealloc];
}


@end
