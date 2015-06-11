    //
//  TennisViewController.m
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "TennisViewController.h"
#import "aTableView.h"
#import "DatabasesViewController.h"
@implementation TennisViewController

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
		[myItem release];
		self.navigationItem.title=@"Tennis";

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
	
	campionati=[[NSArray alloc] initWithObjects:NSLocalizedString(@"Australian Open Men",@""),NSLocalizedString(@"Australian Open Women",@""),NSLocalizedString(@"Usopen Men",@""),NSLocalizedString(@"Usopen Women",@""),NSLocalizedString(@"Wimbledon Men",@""),NSLocalizedString(@"Wimbledon Women",@""),NSLocalizedString(@"Roland Garros Men",@""),NSLocalizedString(@"Roland Garros Women",@""),@"Davis cup",nil];
	immagini=[[NSArray alloc ]initWithObjects:@"australian.jpg",@"australian.jpg",@"usopen.jpeg",@"usopen.jpeg",@"wimbledon.jpeg",@"wimbledon.jpeg",@"rolandGarros.jpg",@"rolandGarros.jpg",@"coppaDavis.jpeg",nil];
	
	/*
	 Normali instanziazioni dei tabella,
	 Delegati e datasource, e di supporto a autoresizingMask per il portrait e Landscape
	 */
	
	myTable=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
	myTable.delegate=self;
	myTable.dataSource=self;
	[contentView addSubview:myTable];
	myTable.autoresizesSubviews = YES;
	myTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	self.view=contentView;
	[myTable release];
	[contentView release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [campionati count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Rankings Tennis";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
   	
	
	
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
	NSArray * databaseRichiama=[NSArray arrayWithObjects:@"australianMaschile",@"australianFemminile",@"usopenMaschile",@"usopenFemminile",@"wimbledonMaschile",@"wimbledonFemminile",@"rolandGarrosMaschile",@"rolandGarrosFemminile",@"davis",nil];
	NSArray * discipline=[NSArray arrayWithObjects:@"Australian_Open",@"Australian_Open",@"US_Open_(tennis)",@"US_Open_(tennis)",@"Wimbledon_Championships",@"Wimbledon_Championships",@"Roland_Garros_(Torneo_sportivo)",@"Roland_Garros_(Torneo_sportivo)",@"Coppa_Davis",nil];
	
	/*
	 Questi array li setto per la gestione poi del collegamento alla relativa pagina di wikipedia
	 e per passare al costruttore della tabella con i dati, il nome del'entita del database da richiamare
	 */
	
	//Istanzio le sottotabelle
	DatabasesViewController *db=[[DatabasesViewController alloc]init];
	if ([db getAllRowsFromTableNamed:[databaseRichiama objectAtIndex:indexPath.row]]!=nil)
	{	
	aTableView * tab=[[aTableView alloc]initWithTabella:[databaseRichiama objectAtIndex:indexPath.row] andValue:@"SI" andSport:[discipline objectAtIndex:indexPath.row]andTitle:[campionati objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:tab animated:YES];
	[myTable deselectRowAtIndexPath:indexPath animated:YES];
	[tab release];
	}
	else 
	{
		UIAlertView * alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning! updates the database in wi-fi mode", @"") message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alert show];
        [alert release];
	}
	[db release];
	
	
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
