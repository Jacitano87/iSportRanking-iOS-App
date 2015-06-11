    //
//  UIWebView.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 12/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "IWebView.h"


@implementation IWebView

//Costruttore. Memorizzo in oggetti stringhe locali, i parametri passati nel costruttore

-(id)initWithStringa:(NSString *)stringa andTipo:(NSString *)tipo
{ 
	if(self = [super init]) {

	tipos=[NSString stringWithString:tipo];
	stringas=[NSString stringWithString:stringa];
	}
	return self;
}



- (void)loadView {
	
	
	
	
	/*
	 Creo un bottone Localizzato, che permette di tornare indietro nella navigazione web
	 Poi effettuo dei controlli in base ai dati passati dal costruttore, che mi permettono
	 Di accedere ai siti con le giuste risoluzioni mobile.In base all'url che viene passata nel 
	 costruttore e alla relativa pagina di Wikipedia
	 */
	
	
	UIBarButtonItem *tastoBack= [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = tastoBack;
	[tastoBack release];
	
	
	UIView *contentView2 = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	[contentView2 setBackgroundColor:[UIColor clearColor]];
	
	if(tipos==@"mondiali_"){
		NSString * stringo = [NSString stringWithFormat:@"http://it.wikipedia.org/wiki/%@%@",tipos,stringas];
		
		
		//Url e richiesta
		urlAddress=[stringo stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSURL * url=[NSURL URLWithString:urlAddress];
		req = [NSURLRequest requestWithURL:url];
		
		myContentView=[[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
		myContentView.delegate=self;
		[myContentView loadRequest:req];
		
		contentView2.autoresizesSubviews = YES;
		contentView2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		[contentView2 addSubview:myContentView];
		[myContentView release];
		
		
}
	else {
		//Url e richiesta
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
		NSString *currentLanguage = [languages objectAtIndex:0];
		
		NSString * stringo = [NSString stringWithFormat:@"http://%@.m.wikipedia.org/wiki/%@",currentLanguage,tipos];
		
		
		
		urlAddress=[stringo stringByReplacingOccurrencesOfString:@" " withString:@""];
		
		NSURL * url=[NSURL URLWithString:urlAddress];
		
		req = [NSURLRequest requestWithURL:url];
		myContentView=[[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
		myContentView.delegate=self;
		[myContentView loadRequest:req];
		
		contentView2.autoresizesSubviews = YES;
		contentView2.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		myContentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

		[contentView2 addSubview:myContentView];
		[myContentView release];
		
		
	}
    self.view=contentView2;
	
	
	
}
-(void)back
{
	myContentView.goBack;
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
	/*
	 Ho gestito il caricamento della pagina con un UIActivityIndicator che mi permette
	 Di aspettare fino al completamento del caricamento della pagina...
	 Questo viene dismesso quando il caricamento è completato
	 Dopo gestisco nel relativo metodo delegato anche il ritorno alla pagina precedente 
	 nel caso in cui ci sono problemi a visualizzare o caricare la pagina web
	 
	 */
	
	
	UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.frame = CGRectMake(121.0f, 50.0f, 37.0f, 37.0f);
	[activityView startAnimating];
	alertView3 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Loading...", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	//Aggiungo l'indicatore come una subview
	[alertView3 addSubview:activityView];
	[activityView release];
	[alertView3 show];
	[alertView3 release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
	
	[alertView3 dismissWithClickedButtonIndex:0 animated:YES];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[alertView3 dismissWithClickedButtonIndex:0 animated:YES];
	[webView canGoBack];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
}


//SUPPORTO TUTTI GLI ORIENTAMENTI

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
       return YES;
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    

}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
    [super dealloc];
}


@end
