//
//  LoadDataTH.h
//  iSRankings
//
//  Created by Antonio Fischetti on 23/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface LoadDataTH : NSObject {
	
	NSMutableData * dati;
	NSURLConnection * connessione;
	NSURL * url;
	
	
	
}

-(void)EffettuaRichiesta;
-(id)initWithMyUrl:(NSString *)aUrl;



@property(nonatomic,retain)NSMutableData * dati;

@end
