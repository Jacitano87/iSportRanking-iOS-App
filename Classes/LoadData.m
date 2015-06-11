//
//  LoadData.m
//  ConnessioneWeb
//
//  Created by Antonio Fischetti on 18/11/10.
//  Copyright 2010 Amministatore. All rights reserved.
//

#import "LoadData.h"

@implementation LoadData
@synthesize delegateMethod;
@synthesize delegateErrorMethod;
@synthesize delegate;
@synthesize dati;

//COSTRUTTORE

-(id)initWithMyUrl:(NSString *)aUrl
{
if(self=[super init])
{     
	
	   dati=[[NSMutableData alloc]init];
	   url=[[NSURL alloc] initWithString:aUrl];
	      }
   return self;
	
}

//METODO PER EFFETTUARE LA RICHIESTA STANDARD

-(void)EffettuaRichiesta
{

	NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
	[request setHTTPMethod:@"GET"];
	
	if(connessione)
	{
		[connessione cancel];
		[connessione release];
	}
	connessione=[[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES]autorelease];
	[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
	
}

//appende i pacchetti che arrivano
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[dati appendData:data];

	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errore" message:@"Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[dati release];
	if([delegate respondsToSelector:delegateErrorMethod])
		[delegate performSelector:delegateErrorMethod];
}

//APPENA TUTTI I DATI SONO ARRIVATI VIENE RICHIAMATO QUESTO METODO CHE RITORNA I DATI

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;	
	if([delegate respondsToSelector:delegateMethod])
	{
		
		[delegate performSelector:delegateMethod withObject:self];
	
	}
	
	 

	
}


- (void)dealloc {
	 [dati release];	
	[url release];
	[super dealloc];
}



@end


