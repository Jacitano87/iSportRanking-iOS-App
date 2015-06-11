//
//  XMLParser.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 11/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <Foundation/Foundation.h>

//CLASSE CHE SI OCCUPA DI FARE IL PARSER XML


@class LoadData;
@interface XMLParser : NSObject <NSXMLParserDelegate>{

	NSString *elemento;
	
	BOOL annoFound;


	NSMutableArray *array;

	NSString * app;
}
-(id)initWithDati:(NSString *)elementoDaParsare aDati:(LoadData *)data;
@property(nonatomic,retain)NSMutableArray *array;
@end
