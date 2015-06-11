//
//  XMLParser.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 11/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "XMLParser.h"
#import "LoadData.h"

@implementation XMLParser
@synthesize array;

/*
 L'utilizzo di questa classe è quello spiegato nella documentazione
 Solo che utilizzo un array, la cui property mi serve per prendere i dati
 Parsati e poi inserirli all'esterno nel database
 */


-(id)initWithDati:(NSString *)elementoDaParsare aDati:(LoadData *)data
{
	if(self=[super init])
	{
		annoFound=NO;
	array=[[NSMutableArray alloc]init];
	elemento=[NSString stringWithString:elementoDaParsare];
	LoadData *tmp=(LoadData *)data;
	NSXMLParser * XMLparser=[[NSXMLParser alloc]initWithData:tmp.dati];
	
	[XMLparser setDelegate:self];
	[XMLparser setShouldResolveExternalEntities:YES];
	[XMLparser parse];
	[XMLparser release];
		
	
	}
	return self;	
}


//METODI DELEGATI DEL NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict

{
	if([elementName isEqualToString:elemento])
	{
		annoFound = YES;
		
	}
	
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(annoFound){
		[array addObject:string];
				
	
	}
}
    
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
 namespaceURI:(NSString *)namespaceURI 
qualifiedName:(NSString *)qName	   

{
	
	annoFound=NO;
	
	
}
- (void)dealloc {
	[array release];
	[super dealloc];
}

@end
