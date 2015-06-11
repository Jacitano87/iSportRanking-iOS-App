//
//  TextTableView.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 18/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "TextTableView.h"
#import "MyCell.h"
#import "Reachability.h"
#import "IWebView.h"
@implementation TextTableView


#pragma mark -
#pragma mark Initialization
//COSTRUTTORE

-(id)initWithStringa:(NSString *)stringa andTitle:(NSString *)titolo andLink:(NSString *)link
{
	if(self = [super init]) {
	self.navigationItem.title=titolo;
    linko=[NSString stringWithString:link];
    texto=[NSString stringWithString:stringa];
	head=[NSString stringWithString:titolo];
	}
		return self;
}
-(void)moreInfo
{
	//metodo richiamato nel caso in cui viene cliccato il pulsante a destra wikipedia
	//anche qui ho scelto di effettuarlo in un metodo apposito
	
	internetReach = [[Reachability reachabilityForInternetConnection] retain];
	wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[self check:wifiReach andSecond:internetReach];
	
	
	
	
}
-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2 {
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	NetworkStatus netStatus2 = [curReach2 currentReachabilityStatus];
	
	if(netStatus==NotReachable && netStatus2==NotReachable)
	{
		//al solito controllo la connessione wifi internet e nel caso negativo avverto l'utente con una alertView
		
		//Utilizzo del NSLocalizedString
		
		UIAlertView * alertView3 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Turn on cellular data or use Wi-Fi to access data", @"") message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[self.view addSubview:alertView3];
		[alertView3 show];
		[alertView3 release];
		
	}
	if(netStatus==ReachableViaWWAN || netStatus==ReachableViaWiFi)
	{
		
		/*Se la connessione è attiva 
		 allora posso istanziare l'oggetto IWebView ovviamente passando altri parametri al costruttore
		 attenendosi alle sue specifiche
		 */
		
		IWebView *web=[[IWebView alloc]initWithStringa:@"" andTipo:linko];
		[self.navigationController pushViewController:web animated:YES];	
		[web release];		
	}
	
}



#pragma mark -
#pragma mark View lifecycle


- (void)loadView {

	//Creo i relativi bottoni per la navigationBar
	
	UIBarButtonItem *tastoAggiorna= [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Wikipedia", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(moreInfo)];
    self.navigationItem.rightBarButtonItem = tastoAggiorna;
	[tastoAggiorna release];
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	[contentView setBackgroundColor:[UIColor clearColor]];

	//Tabella,delegati,datasource e l'autoresizingMask per la rotazione
	myTable=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    myTable.delegate=self;
	myTable.dataSource=self;
	[contentView addSubview:myTable];
	
   	
	myTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	self.view=contentView;
	[myTable release];
	[contentView release];
	

    
}

/*
 Gestisco la rotazione,poichè utilizzo una UIlabel, setto la posizione della stessa in base alla posizione dello schermo
 Se in landscape o portrait avranno dimensioni diverse e le adatto alla tabella
 
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight))
		
	{
		
		controllo=[NSString stringWithString:@"l"];
	    cell.label1.center=CGPointMake(240, 175);
		
	}
	else if((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) 
		{
			controllo=[NSString stringWithString:@"p"];
			cell.label1.center=CGPointMake(155, 175);
			
		}
	return YES;	
}	
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 350.0f;
}

#pragma mark -
#pragma mark Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
	return head;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	//inserisco i dati nella tabella controllando inoltre inizialmente la posizione del dispositivo.
	
    static NSString *CellIdentifier1 = @"Testo";
    cell =(MyCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell == nil) {
        cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
    }
	if(controllo==@"l")
	cell.label1.center=CGPointMake(240, 175);
	cell.label1.text=texto;
	
    return cell;
	
	
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
    [super dealloc];
}


@end

