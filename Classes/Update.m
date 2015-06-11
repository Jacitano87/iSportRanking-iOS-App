//
//  Update.m
//  iWRankigIphone
//
//  Created by Antonio Fischetti on 23/12/10.
//  Copyright 2010 Amministatore. All rights reserved.
//

#import "Update.h"
#import "LoadData.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "DatabasesViewController.h"
#import "XMLParser.h"


@implementation Update
@synthesize delegate;
@synthesize delegateMethod;
-(id)init
{
	if(self=[super init])
	{
	   db=[[DatabasesViewController alloc]init];
	}
	return self;
}



-(void)ontimer
{
	[alertView3 dismissWithClickedButtonIndex:0 animated:YES];
	
	

}

-(void)errore:(id)sender
{
	
}
-(void)effettuaUpdateCalcio
{
	UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityView.frame = CGRectMake(121.0f, 50.0f, 37.0f, 37.0f);
	[activityView startAnimating];
	alertView3 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Updating now...", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
	//Aggiungo l'indicatore come una subview
	[alertView3 addSubview:activityView];
	[activityView release];
	[alertView3 show];
	[alertView3 release];
	
	
	
	/*
	 A SEGUIRE PER OGNI SPORT PASSO L'URL DEL MIO SERVER CHE CONTIENE I DATI IN FORMATO XML, E APPENA I DATI SONO ARRIVA 
	 VIENE RICHIAMATO IL METODO DELEGATO ALLA GESTIONE DEGLI STESSI, QUESTO PROCEDIMENTO è STANDARD PER TUTTI AD ECCEZIONE
	 DEL RANKING IRB, IL QUALE NON EFFETTUA UN PARSING XML, MA DELL'HTML, ATTRAVERSO L'UTILIZZO DELLE CLASSI HAPPLE
	 */
	
	
#pragma mark Premiere
	LoadData * premiereData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/premiereLeague.html"];
	[premiereData EffettuaRichiesta];
	premiereData.delegate=self;
	premiereData.delegateMethod=@selector(ParsePremiereData:);
	premiereData.delegateErrorMethod=@selector(errore:);
    [premiereData release];
	
#pragma mark SerieA
	LoadData * serieAData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/serieA.html"];
	[serieAData EffettuaRichiesta];
	serieAData.delegate=self;
	serieAData.delegateMethod=@selector(ParseSerieAData:);
	serieAData.delegateErrorMethod=@selector(errore:);
	[serieAData release];
	
#pragma mark ChampionsLeague
	LoadData * championsData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/champions.html"];
	[championsData EffettuaRichiesta];
	championsData.delegate=self;
	championsData.delegateMethod=@selector(ParseChampionsData:);
	championsData.delegateErrorMethod=@selector(errore:);
	[championsData release];
#pragma mark EuropaLeague
	LoadData * europaData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/europaLeague.html"];
	[europaData EffettuaRichiesta];
	europaData.delegate=self;
	europaData.delegateMethod=@selector(ParseEuropaData:);
	europaData.delegateErrorMethod=@selector(errore:);
	[europaData release];
#pragma mark PrimeraDivision
	LoadData * primeraData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/primera.html"];
	[primeraData EffettuaRichiesta];
	primeraData.delegate=self;
	primeraData.delegateMethod=@selector(ParsePrimeraData:);
	primeraData.delegateErrorMethod=@selector(errore:);
	[primeraData release];
#pragma mark mondiali 
	LoadData * mondialiData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/coppaMondo.html"];
	[mondialiData EffettuaRichiesta];
	mondialiData.delegate=self;
	mondialiData.delegateMethod=@selector(ParseMondialiData:);
	mondialiData.delegateErrorMethod=@selector(errore:);
	[mondialiData release];
#pragma mark Bundesliga
	LoadData * bundeData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/bundesliga.html"];
	[bundeData EffettuaRichiesta];
	bundeData.delegate=self;
	bundeData.delegateMethod=@selector(ParseBundeData:);
	bundeData.delegateErrorMethod=@selector(errore:);
	[bundeData release];
	
	
}
-(void)effettuaUpdateRugby
{
#pragma mark rugbyData	
	
	LoadData * rugbyData=[[LoadData alloc]initWithMyUrl:@"http://www.irb.com/rankings/full.html"];
	[rugbyData EffettuaRichiesta];
	rugbyData.delegate=self;
	rugbyData.delegateMethod=@selector(ParseRugbyData:);
	rugbyData.delegateErrorMethod=@selector(errore:);
	[rugbyData release];
	
#pragma mark seiNazioni	
	LoadData * seiNazData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/seiNazioni.html"];
	[seiNazData EffettuaRichiesta];
	seiNazData.delegate=self;
	seiNazData.delegateMethod=@selector(ParseSeiNazData:);
	seiNazData.delegateErrorMethod=@selector(errore:);
	[seiNazData release];
#pragma mark treNazioni	
	LoadData * treNazData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/treNazioni.html"];
	[treNazData EffettuaRichiesta];
	treNazData.delegate=self;
	treNazData.delegateMethod=@selector(ParseTreNazData:);
	treNazData.delegateErrorMethod=@selector(errore:);
	[treNazData release];
#pragma mark mondialiRugby
	LoadData * mondialiRugbyData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialiRugby.html"];
	[mondialiRugbyData EffettuaRichiesta];
	mondialiRugbyData.delegate=self;
	mondialiRugbyData.delegateMethod=@selector(ParseMondialiRugbyData:);
	mondialiRugbyData.delegateErrorMethod=@selector(errore:);
	[mondialiRugbyData release];
#pragma mark heinekenCup
	LoadData * heinekenData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/heinekenCup.html"];
	[heinekenData EffettuaRichiesta];
	heinekenData.delegate=self;
	heinekenData.delegateMethod=@selector(ParseHeinekenData:);
	heinekenData.delegateErrorMethod=@selector(errore:);
	[heinekenData release];
	
}
-(void)effettuaUpdateTennis
{
#pragma mark wimbledon maschile
	LoadData * wimbledonMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/wimbledonMaschile.html"];
	[wimbledonMData EffettuaRichiesta];
	wimbledonMData.delegate=self;
	wimbledonMData.delegateMethod=@selector(ParseWimbledonMData:);
	wimbledonMData.delegateErrorMethod=@selector(errore:);
	[wimbledonMData release];
#pragma mark wimbledon femminile
	LoadData * wimbledonFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/wimbledonFemminile.html"];
	[wimbledonFData EffettuaRichiesta];
	wimbledonFData.delegate=self;
	wimbledonFData.delegateMethod=@selector(ParseWimbledonFData:);	
	wimbledonFData.delegateErrorMethod=@selector(errore:);
	[wimbledonFData release];
#pragma mark usopen maschile
	LoadData * usopenMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/usopenMaschile.html"];
	[usopenMData EffettuaRichiesta];
	usopenMData.delegate=self;
	usopenMData.delegateMethod=@selector(ParseUsopenMData:);	
	usopenMData.delegateErrorMethod=@selector(errore:);
	[usopenMData release];
#pragma mark usopen femminile
	LoadData * usopenFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/usopenFemminile.html"];
	[usopenFData EffettuaRichiesta];
	usopenFData.delegate=self;
	usopenFData.delegateMethod=@selector(ParseUsopenFData:);
	usopenFData.delegateErrorMethod=@selector(errore:);
	[usopenFData release];
#pragma mark rolandGarros maschile
	LoadData * rolandMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/rolandGarrosMaschile.html"];
	[rolandMData EffettuaRichiesta];
	rolandMData.delegate=self;
	rolandMData.delegateMethod=@selector(ParseRolandMData:);
	rolandMData.delegateErrorMethod=@selector(errore:);
	[rolandMData release];
#pragma mark rolandGarros maschile
	LoadData * rolandFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/rolandGarrosFemminile.html"];
	[rolandFData EffettuaRichiesta];
	rolandFData.delegate=self;
	rolandFData.delegateMethod=@selector(ParseRolandFData:);
	rolandFData.delegateErrorMethod=@selector(errore:);
	[rolandFData release];
#pragma mark rolandGarros maschile
	LoadData * davisData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/coppaDavis.html"];
	[davisData EffettuaRichiesta];
	davisData.delegate=self;
	davisData.delegateMethod=@selector(ParseDavisData:);
	davisData.delegateErrorMethod=@selector(errore:);
	[davisData release];
#pragma mark australian open Maschile
	LoadData * australianMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/australianMaschile.html"];
	[australianMData EffettuaRichiesta];
	australianMData.delegate=self;
	australianMData.delegateMethod=@selector(ParseAustralianMData:);
	australianMData.delegateErrorMethod=@selector(errore:);
	[australianMData release];
#pragma mark australian open Femminile
	LoadData * australianFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/australianFemminile.html"];
	[australianFData EffettuaRichiesta];
	australianFData.delegate=self;
	australianFData.delegateMethod=@selector(ParseAustralianFData:);
	australianFData.delegateErrorMethod=@selector(errore:);
    [australianFData release];
	
}
-(void)effettuaUpdateAltro
{

#pragma mark basket Mondiale Maschile
	LoadData * basketMMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialeBasketMaschile.html"];
	[basketMMData EffettuaRichiesta];
	basketMMData.delegate=self;
	basketMMData.delegateMethod=@selector(ParseBasketMMData:);
	basketMMData.delegateErrorMethod=@selector(errore:);
	[basketMMData release];
#pragma mark basket Mondiale Femminile
	LoadData * basketMFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialeBasketFemminile.html"];
	[basketMFData EffettuaRichiesta];
	basketMFData.delegate=self;
	basketMFData.delegateMethod=@selector(ParseBasketMFData:);
	basketMFData.delegateErrorMethod=@selector(errore:);
	[basketMFData release];
#pragma mark basket Europeo Maschile
	LoadData * basketEMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/europeoBasketMaschile.html"];
	[basketEMData EffettuaRichiesta];
	basketEMData.delegate=self;
	basketEMData.delegateMethod=@selector(ParseBasketEMData:);
	basketEMData.delegateErrorMethod=@selector(errore:);
	[basketEMData release];
#pragma mark basket Europeo Femminile
	LoadData * basketEFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/europeoBasketFemminile.html"];
	[basketEFData EffettuaRichiesta];
	basketEFData.delegate=self;
	basketEFData.delegateMethod=@selector(ParseBasketEFData:);	
	basketEFData.delegateErrorMethod=@selector(errore:);
	[basketEFData release];
#pragma mark volley mondiale Maschile
	LoadData * volleyMData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialePallavoloMaschile.html"];
	[volleyMData EffettuaRichiesta];
	volleyMData.delegate=self;
	volleyMData.delegateMethod=@selector(ParseVolleyMData:);
	volleyMData.delegateErrorMethod=@selector(errore:);
	[volleyMData release];
#pragma mark basket Europeo Femminile
	LoadData * volleyFData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialePallavoloFemminile.html"];
	[volleyFData EffettuaRichiesta];
	volleyFData.delegate=self;
	volleyFData.delegateMethod=@selector(ParseVolleyFData:);
	volleyFData.delegateErrorMethod=@selector(errore:);
	[volleyFData release];
#pragma mark F1costruttori
	LoadData * f1cData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialeF1costruttori.html"];
	[f1cData EffettuaRichiesta];
	f1cData.delegate=self;
	f1cData.delegateMethod=@selector(ParseCostruttoriData:);
	f1cData.delegateErrorMethod=@selector(errore:);
	[f1cData release];
#pragma mark F1piloti
	LoadData * f1pData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialeF1piloti.html"];
	[f1pData EffettuaRichiesta];
	f1pData.delegate=self;
	f1pData.delegateMethod=@selector(ParsePilotiData:);
	f1pData.delegateErrorMethod=@selector(errore:);
	[f1pData release];
#pragma mark moto gp
	LoadData * motoData=[[LoadData alloc]initWithMyUrl:@"http://sviluppoantonio.altervista.org/mondialeMotogp.html"];
	[motoData EffettuaRichiesta];
	motoData.delegate=self;
	motoData.delegateMethod=@selector(ParseMotoData:);
	motoData.delegateErrorMethod=@selector(errore:);
	[motoData release];
	
	timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ontimer) userInfo:nil  repeats:NO];
  
	
	
	if([delegate respondsToSelector:delegateMethod])
	{
		
		[delegate performSelector:delegateMethod withObject:self];
		
		
	}
	
}

/*
 VEDIAMO QUESTO METODO, GLI ALTRI FANNO LA STESSA COSA MA RICHIAMANO TABELLE DIVERSE DEL DATABASE ED EFFETTUANO
 UN PARSER DIVERSO NEI TAG XML
 APRO IL DATABASE INIZIALMENTE E CREO LA TABELLA RELATIVA AI DATI PARSATI, E INSERISCO I CAMPI RELATIVI
 DOPO CHE HO EFETTUATO IL PARSER DEI DATI DAL SERVER, OVVIAMETNE QUESTI METODI VENGONO RICHIAMATI QUANDO I DATI SONO
 ARRIVATI.GESTISCO IL SALVATGGIO DEI RECORD SU DATABASE ATTRAVERSO UN CICLO FOR.
 */

-(void)ParseCostruttoriData:(id)sender
{
	
	
	[db createTableNamed:@"costruttoreMondiale" withField1:@"anno" withField2:@"costruttore" withField3:@"nazione"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *costruttoreAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=costruttoreAnno.array;
	XMLParser *costruttoreVincitore=[[XMLParser alloc]initWithDati:@"costruttore" aDati:tmp14];
    NSArray *appoggio2=costruttoreVincitore.array;
	XMLParser *costruttoreSede=[[XMLParser alloc]initWithDati:@"nazione" aDati:tmp14];
    NSArray *appoggio3=costruttoreSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"costruttoreMondiale" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"costruttore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"nazione" field3Value:[appoggio3 objectAtIndex:i]];}
	[costruttoreAnno release];
	[costruttoreVincitore release];
	[costruttoreSede release];
	
	
	

}
-(void)ParsePilotiData:(id)sender
{
	
	[db createTableNamed:@"pilotiMondiale" withField1:@"anno" withField2:@"pilota" withField3:@"scuderia"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *pilotiAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=pilotiAnno.array;
	XMLParser *pilotiVincitore=[[XMLParser alloc]initWithDati:@"pilota" aDati:tmp14];
    NSArray *appoggio2=pilotiVincitore.array;
	XMLParser *pilotiSede=[[XMLParser alloc]initWithDati:@"scuderia" aDati:tmp14];
    NSArray *appoggio3=pilotiSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"pilotiMondiale" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"pilota" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"scuderia" field3Value:[appoggio3 objectAtIndex:i]];}
	[pilotiAnno release];
	[pilotiVincitore release];
	[pilotiSede release];
	
	
}
-(void)ParseMotoData:(id)sender
{
	
	[db createTableNamed:@"motoGP" withField1:@"anno" withField2:@"vincitore" withField3:@"scuderia"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *motoAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=motoAnno.array;
	XMLParser *motoVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=motoVincitore.array;
	XMLParser *motoSede=[[XMLParser alloc]initWithDati:@"scuderia" aDati:tmp14];
    NSArray *appoggio3=motoSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"motoGP" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"scuderia" field3Value:[appoggio3 objectAtIndex:i]];}
	[motoAnno release];
	[motoVincitore release];
	[motoSede release];
	
}

-(void)ParseBasketMMData:(id)sender
{
	
	[db createTableNamed:@"basketMondialeMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *basketAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=basketAnno.array;
	XMLParser *basketVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=basketVincitore.array;
	XMLParser *basketSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=basketSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"basketMondialeMaschile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[basketAnno release];
	[basketVincitore release];
	[basketSede release];
	
	
	
}

-(void)ParseBasketMFData:(id)sender
{
	
	[db createTableNamed:@"basketMondialeFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *basketAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=basketAnno.array;
	XMLParser *basketVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=basketVincitore.array;
	XMLParser *basketSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=basketSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"basketMondialeFemminile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[basketAnno release];
	[basketVincitore release];
	[basketSede release];
	
}
-(void)ParseBasketEMData:(id)sender
{
	
	[db createTableNamed:@"basketEuropeoMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *basketAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=basketAnno.array;
	XMLParser *basketVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=basketVincitore.array;
	XMLParser *basketSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=basketSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"basketEuropeoMaschile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[basketAnno release];
	[basketVincitore release];
	[basketSede release];
	

}
-(void)ParseBasketEFData:(id)sender
{
	
	[db createTableNamed:@"basketEuropeoFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *basketAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=basketAnno.array;
	XMLParser *basketVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=basketVincitore.array;
	XMLParser *basketSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=basketSede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"basketEuropeoFemminile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[basketAnno release];
	[basketVincitore release];
	[basketSede release];
	
}
-(void)ParseVolleyMData:(id)sender
{
	
	[db createTableNamed:@"volleyMondialeMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *volleyAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=volleyAnno.array;
	XMLParser *volleyVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=volleyVincitore.array;
	XMLParser *volleySede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=volleySede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"volleyMondialeMaschile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[volleyAnno release];
	[volleyVincitore release];
	[volleySede release];
	
}
-(void)ParseVolleyFData:(id)sender
{
	    
	[db createTableNamed:@"volleyMondialeFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"sede"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *volleyAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggio=volleyAnno.array;
	XMLParser *volleyVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggio2=volleyVincitore.array;
	XMLParser *volleySede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp14];
    NSArray *appoggio3=volleySede.array;
	
	
	for (int i=0; i<[appoggio count]; i++) {
		
		[db insertRicordIntoTableNamed:@"volleyMondialeFemminile" 
							withField1:@"anno" field1Value:[appoggio objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggio2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3 objectAtIndex:i]];}
	[volleyAnno release];
	[volleyVincitore release];
	[volleySede release];
	     
}





-(void)ParseAustralianFData:(id)sender
{
	    
	[db createTableNamed:@"australianFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *austFAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggioAF=austFAnno.array;
	XMLParser *austFVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggioAF2=austFVincitore.array;
	XMLParser *austFNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp14];
    NSArray *appoggioAF3=austFNazionalita.array;
	
	
	for (int i=0; i<[appoggioAF count]; i++) {
		
		[db insertRicordIntoTableNamed:@"australianFemminile" 
							withField1:@"anno" field1Value:[appoggioAF objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioAF2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioAF3 objectAtIndex:i]];}
	[austFAnno release];
	[austFNazionalita release];
	[austFVincitore release];
	     
}


-(void)ParseAustralianMData:(id)sender
{
	    
	[db createTableNamed:@"australianMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp13=(LoadData *)sender;
	XMLParser *austMAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp13];
	NSArray *appoggioAM=austMAnno.array;
	XMLParser *austMVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp13];
    NSArray *appoggioAM2=austMVincitore.array;
	XMLParser *austMNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp13];
    NSArray *appoggioAM3=austMNazionalita.array;
	
	
	for (int i=0; i<[appoggioAM count]; i++) {
		
		[db insertRicordIntoTableNamed:@"australianMaschile" 
							withField1:@"anno" field1Value:[appoggioAM objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioAM2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioAM3 objectAtIndex:i]];}
	[austMAnno release];
	[austMNazionalita release];
	[austMVincitore release];
	     
}

-(void)ParseWimbledonMData:(id)sender
{
	 
	[db createTableNamed:@"wimbledonMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp12=(LoadData *)sender;
	XMLParser *wimbMAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp12];
	NSArray *appoggioWM=wimbMAnno.array;
	XMLParser *wimbMVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp12];
    NSArray *appoggioWM2=wimbMVincitore.array;
	XMLParser *wimbMNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp12];
    NSArray *appoggioWM3=wimbMNazionalita.array;
	
	
	for (int i=0; i<[appoggioWM count]; i++) {
		
		[db insertRicordIntoTableNamed:@"wimbledonMaschile" 
							withField1:@"anno" field1Value:[appoggioWM objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioWM2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioWM3 objectAtIndex:i]];}
	[wimbMAnno release];
	[wimbMNazionalita release];
	[wimbMVincitore release];
	
	
}


-(void)ParseWimbledonFData:(id)sender
{
	
	[db createTableNamed:@"wimbledonFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp13=(LoadData *)sender;
	XMLParser *wimbFAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp13];
	NSArray *appoggioWF=wimbFAnno.array;
	XMLParser *wimbFVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp13];
    NSArray *appoggioWF2=wimbFVincitore.array;
	XMLParser *wimbFNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp13];
    NSArray *appoggioWF3=wimbFNazionalita.array;
	
	
	for (int i=0; i<[appoggioWF count]; i++) {
		
		[db insertRicordIntoTableNamed:@"wimbledonFemminile" 
							withField1:@"anno" field1Value:[appoggioWF objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioWF2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioWF3 objectAtIndex:i]];}
	[wimbFAnno release];
	[wimbFNazionalita release];
	[wimbFVincitore release];
	
}

-(void)ParseUsopenMData:(id)sender
{

	[db createTableNamed:@"usopenMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp14=(LoadData *)sender;
	XMLParser *usMAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp14];
	NSArray *appoggioUM=usMAnno.array;
	XMLParser *usMVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp14];
    NSArray *appoggioUM2=usMVincitore.array;
	XMLParser *usMNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp14];
    NSArray *appoggioUM3=usMNazionalita.array;
	
	
	for (int i=0; i<[appoggioUM count]; i++) {
		
		[db insertRicordIntoTableNamed:@"usopenMaschile" 
							withField1:@"anno" field1Value:[appoggioUM objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioUM2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioUM3 objectAtIndex:i]];}
	[usMAnno release];
	[usMNazionalita release];
	[usMVincitore release];
	

}
-(void)ParseUsopenFData:(id)sender
{
	
	[db createTableNamed:@"usopenFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp15=(LoadData *)sender;
	XMLParser *usFAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp15];
	NSArray *appoggioUF=usFAnno.array;
	XMLParser *usFVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp15];
    NSArray *appoggioUF2=usFVincitore.array;
	XMLParser *usFNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp15];
    NSArray *appoggioUF3=usFNazionalita.array;
	
	
	for (int i=0; i<[appoggioUF count]; i++) {
		
		[db insertRicordIntoTableNamed:@"usopenFemminile" 
							withField1:@"anno" field1Value:[appoggioUF objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioUF2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioUF3 objectAtIndex:i]];}
	[usFAnno release];
	[usFNazionalita release];
	[usFVincitore release];
	

}

-(void)ParseRolandMData:(id)sender
{   
	
	[db createTableNamed:@"rolandGarrosMaschile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp16=(LoadData *)sender;
	XMLParser *rolandMAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp16];
	NSArray *appoggioRM=rolandMAnno.array;
	XMLParser *rolandMVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp16];
    NSArray *appoggioRM2=rolandMVincitore.array;
	XMLParser *rolandMNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp16];
    NSArray *appoggioRM3=rolandMNazionalita.array;
	
	
	for (int i=0; i<[appoggioRM count]; i++) {
		
		[db insertRicordIntoTableNamed:@"rolandGarrosMaschile" 
							withField1:@"anno" field1Value:[appoggioRM objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioRM2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioRM3 objectAtIndex:i]];}
	[rolandMAnno release];
	[rolandMNazionalita release];
	[rolandMVincitore release];
	
}

-(void)ParseRolandFData:(id)sender
{

	[db createTableNamed:@"rolandGarrosFemminile" withField1:@"anno" withField2:@"vincitore" withField3:@"nazionalita"];
	
	LoadData *tmp17=(LoadData *)sender;
	XMLParser *rolandFAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp17];
	NSArray *appoggioRF=rolandFAnno.array;
	XMLParser *rolandFVincitore=[[XMLParser alloc]initWithDati:@"vincitore" aDati:tmp17];
    NSArray *appoggioRF2=rolandFVincitore.array;
	XMLParser *rolandFNazionalita=[[XMLParser alloc]initWithDati:@"nazionalita" aDati:tmp17];
    NSArray *appoggioRF3=rolandFNazionalita.array;
	
	
	for (int i=0; i<[appoggioRF count]; i++) {
		
		[db insertRicordIntoTableNamed:@"rolandGarrosFemminile" 
							withField1:@"anno" field1Value:[appoggioRF objectAtIndex:i] 
							 andField2:@"vincitore" field2Value:[appoggioRF2 objectAtIndex:i]
							 andField3:@"nazionalita" field3Value:[appoggioRF3 objectAtIndex:i]];}
	[rolandFAnno release];
	[rolandFNazionalita release];
	[rolandFVincitore release];
	
}

-(void)ParseDavisData:(id)sender
{

	[db createTableNamed:@"davis" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp18=(LoadData *)sender;
	XMLParser *davisAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp18];
	NSArray *appoggioD=davisAnno.array;
	XMLParser *davisSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp18];
    NSArray *appoggioD2=davisSquadra.array;
	
	XMLParser *davisSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp18];
    NSArray *appoggioD3=davisSede.array;
	
	
	for (int i=0; i<[appoggioD count]; i++) {
		
		
		
		[db insertRicordIntoTableNamed:@"davis" 
							withField1:@"anno" field1Value:[appoggioD objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioD2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioD3 objectAtIndex:i]];}
	[davisAnno release];
	[davisSede release];
	[davisSquadra release];


}



-(void)ParseSeiNazData:(id)sender
{
	
	[db createTableNamed:@"seiNazioni" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp11=(LoadData *)sender;
	XMLParser *seiNazAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp11];
	NSArray *appoggioSN=seiNazAnno.array;
	XMLParser *seiNazSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp11];
    NSArray *appoggioSN2=seiNazSquadra.array;
	
	for (int i=0; i<[appoggioSN count]; i++) {
		
		[db insertRicordIntoTableNamed:@"seiNazioni" 
							withField1:@"anno" field1Value:[appoggioSN objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioSN2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioSN objectAtIndex:i]];}
	[seiNazAnno release];
	[seiNazSquadra release];
	
	
}



-(void)ParseTreNazData:(id)sender
{
	
	[db createTableNamed:@"treNazioni" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp10=(LoadData *)sender;
	XMLParser *treNazAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp10];
	NSArray *appoggioTN=treNazAnno.array;
	XMLParser *treNazSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp10];
    NSArray *appoggioTN2=treNazSquadra.array;
	
	for (int i=0; i<[appoggioTN count]; i++) {
		
		[db insertRicordIntoTableNamed:@"treNazioni" 
							withField1:@"anno" field1Value:[appoggioTN objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioTN2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioTN objectAtIndex:i]];}
	[treNazAnno release];
	[treNazSquadra release];
	

}



-(void)ParseMondialiRugbyData:(id)sender
{
	
	[db createTableNamed:@"mondialiRugby" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp9=(LoadData *)sender;
	XMLParser *mondialiRugbyAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp9];
	NSArray *appoggioMR=mondialiRugbyAnno.array;
	XMLParser *mondialiRugbySquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp9];
    NSArray *appoggioMR2=mondialiRugbySquadra.array;
	
	for (int i=0; i<[appoggioMR count]; i++) {
		
		[db insertRicordIntoTableNamed:@"mondialiRugby" 
							withField1:@"anno" field1Value:[appoggioMR objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioMR2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioMR objectAtIndex:i]];}
	[mondialiRugbyAnno release];
	[mondialiRugbySquadra release];
	
}

-(void)ParseHeinekenData:(id)sender
{
	
	[db createTableNamed:@"heineken" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp8=(LoadData *)sender;
	XMLParser *heinekenAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp8];
	NSArray *appoggioH=heinekenAnno.array;
	XMLParser *heinekenSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp8];
    NSArray *appoggioH2=heinekenSquadra.array;
		
	for (int i=0; i<[appoggioH count]; i++) {
		
		[db insertRicordIntoTableNamed:@"heineken" 
							withField1:@"anno" field1Value:[appoggioH objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioH2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioH objectAtIndex:i]];}
	[heinekenAnno release];
	[heinekenSquadra release];
		
	
	
}


/*
 QUESTO METODO DIFFERISCE IN QUANTO EFFETTUA UN PARSING HTML UTILIZZATO LE CLASSI HAPPLE.
 CREANDO UN OGGETTO TFHAPPLE CERCO IL NODO RELATIVO AI DATI, IN QUESTO CASO SI TROVANO
 IN UNA TABELLA, TD CON ATTRIBUTI CLASS="L"-
 SALVO TUTTO SU UN ARRAY E POI MI VADO A PRENDERE GLI ELEMENTI IN BASE ALLA POSIZIONE IN CUI
 ESSI SI TROVANO NELL'ARRAY INFINE SALVO TUTTO SUL DATABASE
 */

-(void)ParseRugbyData:(id)sender 
{
	
	[db createTableNamed:@"rugbyRanking" withField1:@"pos" withField2:@"squadra" withField3:@"punti"];
	
	
	LoadData *tmp2=(LoadData *)sender;
	NSData * datiRugby=[NSData dataWithData:tmp2.dati];
	TFHpple * xpathParser = [[TFHpple alloc] initWithHTMLData:datiRugby];
	
  
	NSArray * elements3  = [xpathParser search:@"//td[@class='l']"];
	[xpathParser release];
	int pos=0;
	int squa=1;
	int punti=2;
	int contatore=[elements3 count];
	int posizione=0;
	
	for (int i=0; i<contatore/3; i++) 
	    {
		TFHppleElement *element = [elements3 objectAtIndex:pos];
		TFHppleElement *element2 = [elements3 objectAtIndex:squa];
		TFHppleElement *element3 = [elements3 objectAtIndex:punti];
		pos=pos+3;
		squa=squa+3;
		punti=punti+3;
		NSString *content1 = [element content]; 
		NSString *content2 = [element2 content];
		NSString *content3 = [element3 content];
		
		[db insertRicordIntoTableNamed:@"rugbyRanking" 
							withField1:@"pos" field1Value:content1 
							 andField2:@"squadra" field2Value:content2
							 andField3:@"punti" field3Value:content3];
		posizione++;	
    	}
	
}





-(void)ParseBundeData:(id)sender
{
	
	[db createTableNamed:@"bundesliga" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp7=(LoadData *)sender;
	XMLParser *bundeAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp7];
	NSArray *appoggioB=bundeAnno.array;
	XMLParser *bundeSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp7];
    NSArray *appoggioB2=bundeSquadra.array;
	XMLParser *bundeSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp7];
    NSArray *appoggioB3=bundeSede.array;
	
	for (int i=0; i<[appoggioB count]; i++) {
		
		[db insertRicordIntoTableNamed:@"bundesliga" 
							withField1:@"anno" field1Value:[appoggioB objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioB2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioB3 objectAtIndex:i]];}
	[bundeAnno release];
	[bundeSquadra release];
	[bundeSede release];
	
	
}



-(void)ParseMondialiData:(id)sender
{
	
	[db createTableNamed:@"coppaMondo" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];
	
	LoadData *tmp6=(LoadData *)sender;
	XMLParser *mondialiAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp6];
	NSArray *appoggioM=mondialiAnno.array;
	XMLParser *mondialiSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp6];
    NSArray *appoggioM2=mondialiSquadra.array;
	XMLParser *mondialiSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp6];
    NSArray *appoggioM3=mondialiSede.array;
	
	for (int i=0; i<[appoggioM count]; i++) {
		
		[db insertRicordIntoTableNamed:@"coppaMondo" 
							withField1:@"anno" field1Value:[appoggioM objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioM2 objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggioM3 objectAtIndex:i]];}
	[mondialiAnno release];
	[mondialiSquadra release];
	[mondialiSede release];
	
	
}




-(void)ParsePrimeraData:(id)sender
{
	 
	[db createTableNamed:@"primeraDivision" withField1:@"anno" withField2:@"squadra" withField3:@"pos"];
	
	LoadData *tmp5=(LoadData *)sender;
	XMLParser *primeraAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp5];
	NSArray *appoggioPr=primeraAnno.array;
	XMLParser *primeraSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp5];
    NSArray *appoggioPr2=primeraSquadra.array;
	for (int i=0; i<[appoggioPr count]; i++) {
		
		[db insertRicordIntoTableNamed:@"primeraDivision" 
							withField1:@"anno" field1Value:[appoggioPr objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggioPr2 objectAtIndex:i]
							 andField3:@"pos" field3Value:[appoggioPr objectAtIndex:i]];}
	[primeraAnno release];
	[primeraSquadra release];
	
	
	
    }




-(void)ParseEuropaData:(id)sender
{
	
	[db createTableNamed:@"europaLeague" withField1:@"anno" withField2:@"squadra" withField3:@"pos"];
	
	LoadData *tmp4=(LoadData *)sender;
	XMLParser *europaAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp4];
	NSArray *appoggioE=europaAnno.array;
	XMLParser *europaSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp4];
    NSArray *appoggio2E=europaSquadra.array;
	for (int i=0; i<[appoggioE count]; i++) {
		
		[db insertRicordIntoTableNamed:@"europaLeague" 
							withField1:@"anno" field1Value:[appoggioE objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggio2E objectAtIndex:i]
							 andField3:@"pos" field3Value:[appoggioE objectAtIndex:i]];}
	[europaAnno release];
	[europaSquadra release];

	
	
    }




-(void)ParseChampionsData:(id)sender
{
	
	[db createTableNamed:@"championsLeague" withField1:@"anno" withField2:@"squadra" withField3:@"sede"];

	LoadData *tmp3=(LoadData *)sender;
	XMLParser *championsAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp3];
	NSArray *appoggioC=championsAnno.array;
	XMLParser *championsSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp3];
    NSArray *appoggio2C=championsSquadra.array;
	XMLParser *championsSede=[[XMLParser alloc]initWithDati:@"sede" aDati:tmp3];
    NSArray *appoggio3C=championsSede.array;
	
	for (int i=0; i<[appoggioC count]; i++) {
		
		[db insertRicordIntoTableNamed:@"championsLeague" 
							withField1:@"anno" field1Value:[appoggioC objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggio2C objectAtIndex:i]
							 andField3:@"sede" field3Value:[appoggio3C objectAtIndex:i]];}
	[championsAnno release];
	[championsSquadra release];
	[championsSede release];
	
	
   }





-(void)ParseSerieAData:(id)sender
{
	
	[db createTableNamed:@"serieA" withField1:@"pos" withField2:@"squadra" withField3:@"anno"];
	
	LoadData *tmp2=(LoadData *)sender;
	XMLParser *serieAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp2];
	NSArray *appoggioS=serieAnno.array;
	XMLParser *serieSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp2];
    NSArray *appoggio2S=serieSquadra.array;
	for (int i=0; i<[appoggioS count]; i++) {
		[db insertRicordIntoTableNamed:@"serieA" 
							withField1:@"pos" field1Value:[appoggioS objectAtIndex:i] 
							 andField2:@"squadra" field2Value:[appoggio2S objectAtIndex:i]
							 andField3:@"anno" field3Value:[appoggioS objectAtIndex:i]];}
	[serieAnno release];
	[serieSquadra release];
	
	
	
   
}

	   


-(void)ParsePremiereData:(id)sender
{
	
	[db createTableNamed:@"premiereLeague" withField1:@"pos" withField2:@"squadra" withField3:@"anno"];
	
	LoadData *tmp1=(LoadData *)sender;
	XMLParser *premiereAnno=[[XMLParser alloc]initWithDati:@"anno" aDati:tmp1];
	NSArray *appoggioP=premiereAnno.array;
	XMLParser *premiereSquadra=[[XMLParser alloc]initWithDati:@"squadra" aDati:tmp1];
    NSArray *appoggio2P=premiereSquadra.array;
	for (int i=0; i<[appoggioP count]; i++) {
	[db insertRicordIntoTableNamed:@"premiereLeague" 
						withField1:@"pos" field1Value:[appoggioP objectAtIndex:i] 
						 andField2:@"squadra" field2Value:[appoggio2P objectAtIndex:i]
						 andField3:@"anno" field3Value:[appoggioP objectAtIndex:i]];
	}
	
		
	[premiereAnno release];
	[premiereSquadra release];
		
	
}

- (void)dealloc {
	
	[db release];
	[super dealloc];
}



@end
