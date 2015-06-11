//
//  SerieAtableView.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 12/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "aTableView.h"
#import "DatabasesViewController.h"

#import "IWebView.h"
#import "Reachability.h"
@implementation aTableView

//inizializzazione con settaggio delle variabili locali 
-(id)initWithTabella:(NSString *)tabella andValue:(NSString *)value andSport:(NSString *)sport andTitle:(NSString *)titolo
{
	if(self = [super init]) {

	self.navigationItem.title=titolo;
	controllo=[NSString stringWithString:value];
    controlloSport=[NSString stringWithString:sport];
	 tabel=[NSString stringWithString:tabella];
	
	
	}
	return self;
}

#pragma mark -
#pragma mark Initialization
- (void)loadView {
	
	
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	[contentView setBackgroundColor:[UIColor clearColor]];
	
	//Effetto una query al database per farmi restituire gli elementi salvati e tramite una property me li vado a richiamare
	//e quindi salvare su array interni
	
	DatabasesViewController *db=[[DatabasesViewController alloc]init];
		
	
	NSArray * array=[NSArray arrayWithArray:[db getAllRowsFromTableNamed:tabel]];
	[db release];
	
	array1=[[NSArray alloc]initWithArray:[array objectAtIndex:0]];
	array2=[[NSArray alloc]initWithArray:[array objectAtIndex:1]];
	array3=[[NSArray alloc]initWithArray:[array objectAtIndex:2]];
	
	indice=[[NSMutableArray alloc]init];
	
	//questo ciclo mi serve per poter creare lo scroll della tabella utilizzando la notazione puntata "."
	
	for (int i=0; i<[array1 count]; i++) {
		
		NSString * string=[NSString stringWithFormat:@"."];
		[indice addObject:string];
	}	
	
	//istanzio la tabella e ne setto i delegati e il datasource
	
	myTable=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
	myTable.delegate=self;
	myTable.dataSource=self;
	
	//metodi per la gestione del landScape e portrait
	
	myTable.autoresizesSubviews = YES;	
	myTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
	
	[contentView addSubview:myTable];
	[myTable release];
	self.view=contentView;
	[contentView release];
	
	
}

#pragma mark -
#pragma mark View lifecycle



-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return indice;	
}
//sopporta l'autorotazione in portrait e landScape

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [array1 count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *stringa=[NSString stringWithFormat:@"Year:%@",[array1 objectAtIndex:section]];
	return stringa;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
	
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text=[array2 objectAtIndex:indexPath.section];
    if(controllo==@"SI"){
		NSString * country=[NSString stringWithFormat:@"%@",[array3 objectAtIndex:indexPath.section]];
		cell.detailTextLabel.text=country;}
	
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//deselezionare le righe cliccate
	
	[myTable deselectRowAtIndexPath:indexPath animated:YES];

	//istanzio gli oggetti che mi servono per il controllo della connessione e chiamo il metodo per controllare se questa è attiva o no
	//Ho scelto di effettuare questo controllo in un metodo a parte,quindi gli passo anche l'indexPath
	
	internetReach = [[Reachability reachabilityForInternetConnection] retain];
	wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[self check:wifiReach andSecond:internetReach andIndex:indexPath];
	
   
	
	
}
-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2 andIndex:(NSIndexPath *)indexPath{
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	NetworkStatus netStatus2 = [curReach2 currentReachabilityStatus];
	
	if(netStatus==NotReachable && netStatus2==NotReachable)
	{
		// Nel caso in cui la connessione non è attiva manda un messaggio negativo
		UIAlertView * alertView3 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Turn on cellular data or use Wi-Fi to access data", @"") message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[self.view addSubview:alertView3];
		[alertView3 show];
		[alertView3 release];
		
	}
	if(netStatus==ReachableViaWWAN || netStatus==ReachableViaWiFi)
	{
		//se la connessione è presente allora creo e instanzio un oggetto IWebView
		
		IWebView *web=[[IWebView alloc]initWithStringa:[array1 objectAtIndex:indexPath.section] andTipo:controlloSport];
		[self.navigationController pushViewController:web animated:YES];	
		[web release];	
			}

}




#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[internetReach release];
	[wifiReach release];
	[array1 release];
	[array2 release];
	[array3 release];
	[indice release];
    [super dealloc];
}


@end

