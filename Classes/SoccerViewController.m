    //
//  SoccerViewController.m
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "SoccerViewController.h"
#import "aTableView.h"
#import "DatabasesViewController.h"
@implementation SoccerViewController

/*
 Un'inizilizzazione standard del costruttore per il calcio, tennis rugby e other,
 Informzioni relative all'immagine che deve caricare la tab bar relativa alla classe 
 in questione. Il titolo della stessa gestita con il localized String (Lingue supportate INGLESE ITALIANO SPAGNOLO)
*/

-(id)initWithTitle:(NSString *)aTitle andImage:(NSString *)anImage andTag:(NSInteger)aTag
{
if(self = [super init]) {
	UITabBarItem *myItem = [[UITabBarItem alloc] initWithTitle:aTitle image:[UIImage imageNamed:anImage] tag:aTag];
	myTag = aTag;
	self.tabBarItem = myItem;
	self.navigationItem.title=NSLocalizedString(@"Soccer",@"");

	[myItem release];
}
return self;
}

- (void)loadView {
	
		
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	[contentView setBackgroundColor:[UIColor clearColor]];
    
	/*
	   Anche qui ho gestito le varie celle della tabella,attraverso l'uso di un array che contiene i nomi delle competizioni
	   e un altro che contiene i nomi delle immagini che sono caricate in resource e che verranno mostrate.
	   Questo utilizzo di questi array è simile in tutti e quattro i controllori degli sport 
	*/
	
	campionati=[[NSArray alloc] initWithObjects:NSLocalizedString(@"Mondial",@""),@"League of champions",@"European League",@"Italian League",@"England League",@"Spanish League",@"Germany League",nil];
	immagini=[[NSArray alloc ]initWithObjects:@"coppaMondo.jpg",@"championsLeague.jpeg",@"europaLeague.jpeg",@"serieA.jpeg",@"premiereLeague.jpeg",@"primeraDivision.jpeg",@"bundesliga.jpeg",nil];
	
	/*
	 Normali instanziazioni dei tabella,
	 Delegati e datasource, e di supporto a autoresizingMask per il portrait e Landscape
	 */
	myTable=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
	
	myTable.delegate=self;
	myTable.dataSource=self;
	
	[contentView addSubview:myTable];
	myTable.autoresizesSubviews = YES;
	myTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth |        UIViewAutoresizingFlexibleHeight);
	
	
	
	self.view=contentView;
	[myTable release];
	[contentView release];
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [campionati count];
	
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Rankings Soccer";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
   	
	//Controllo la sezione, poichè in sviluppi futuri voglio inserire altre sezioni
	
	if(indexPath.section==0)
	{
		UIImage * image=[UIImage imageNamed:[immagini objectAtIndex:indexPath.row]];
		cell.imageView.image=image;
		cell.textLabel.text=[campionati objectAtIndex:indexPath.row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}	
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSArray * databaseRichiama=[NSArray arrayWithObjects:@"coppaMondo",@"championsLeague",@"europaLeague",@"serieA",@"premiereLeague",@"primeraDivision",@"bundesliga",nil];
	NSArray * discipline=[NSArray arrayWithObjects:@"mondiali_",@"UEFA_Champions_League",@"UEFA_Europa_League",@"Serie_A",@"Premier_League",@"Primera_Divisi%C3%B3n_spagnola",@"Bundesliga",nil];
	
	/*
	 Questi array li setto per la gestione poi del collegamento alla relativa pagina di wikipedia
	 e per passare al costruttore della tabella con i dati, il nome del'entita del database da richiamare
	 */
	DatabasesViewController *db=[[DatabasesViewController alloc]init];
	if ([db getAllRowsFromTableNamed:[databaseRichiama objectAtIndex:indexPath.row]]!=nil)
	{	
	
	if(indexPath.row<=1){
		
		//poichè alcune tabelle dovranno utilizzare numeri diversi di informazioni
		//ho gestito il tutto con un if-else
		
		
		aTableView * tab=[[aTableView alloc]initWithTabella:[databaseRichiama objectAtIndex:indexPath.row] andValue:@"SI" andSport:[discipline objectAtIndex:indexPath.row]andTitle:[campionati objectAtIndex:indexPath.row]];
		
		[myTable addSubview:tab.view];
		[self.navigationController pushViewController:tab animated:YES];	
		[myTable deselectRowAtIndexPath:indexPath animated:YES];
		[tab release];
			 
		//SI per visualizzare la sede
	}
	else
	{
		aTableView * tab=[[aTableView alloc]initWithTabella:[databaseRichiama objectAtIndex:indexPath.row] andValue:@"NO"andSport:[discipline objectAtIndex:indexPath.row]andTitle:[campionati objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:tab animated:YES];
		[myTable deselectRowAtIndexPath:indexPath animated:YES];
		[tab release];
	}
	}
	else 
	{
		UIAlertView * alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning! updates the database in wi-fi mode", @"") message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        [alert release];
	}
	[db release];
	
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    if(!(self.tabBarController.selectedIndex == myTag)) {
		[self.view removeFromSuperview];
		self.view = nil;
	}
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
}


- (void)dealloc {
	[campionati release];
	[immagini release];
    [super dealloc];
}


@end
