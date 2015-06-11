//
//  LoadDataTH.m
//  iSRankings
//
//  Created by Antonio Fischetti on 23/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "LoadDataTH.h"


@implementation LoadDataTH


@synthesize dati;

-(id)initWithMyUrl:(NSString *)aUrl
{
	if(self=[super init])
	{     
		
		dati=[[NSMutableData alloc]init];
		url=[[NSURL alloc] initWithString:aUrl];
	}
	return self;
	
}


-(void)EffettuaRichiesta
{
	
	NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
	[request setHTTPMethod:@"GET"];
	
	if(connessione)
	{
		[connessione cancel];
		[connessione release];
	}
	connessione=[[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES]autorelease];
	
	
}

//appende i pacchetti che arrivano
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[dati appendData:data];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;	
	
	
	
	
	
}

//Sarebbe più corretto all'interno del metodo di errore, avvisare l'utente cn una UIAlert
//E,o avvisare la classe che ha chiesto la connessione dell'errore avvenuto
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{	
	NSLog(@"si è scatenato un errore:%@",error);
}
- (void)dealloc {
	[url release];
	[super dealloc];
}




@end
