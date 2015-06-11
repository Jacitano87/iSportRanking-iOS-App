    //
//  MainViewController.m
//  iSportRankings
//
//  Created by Antonio Fischetti on 19/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "MainViewController.h"
#import "Reachability.h"
#import "Update.h"
#import "RankingTableView.h"
#import "InfoViewController.h"
@implementation MainViewController
-(id)initWithTitle:(NSString *)aTitle andImage:(NSString *)anImage andTag:(NSInteger)aTag
{
	if(self = [super init]) {
		UITabBarItem *myItem = [[UITabBarItem alloc] initWithTitle:aTitle image:[UIImage imageNamed:anImage] tag:aTag];
		myTag = aTag;
		self.tabBarItem = myItem;
		
		[myItem release];
	}
	return self;
}

- (void)loadView {
	
	contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds] ];
	
	/*
	 Poichè ho pensato che la visione ripetitiva di un actionSheet può provocare nervosismo
	 all'utente che esegue l'app, faccio in modo che esso possa scegliere se mostrare questa,
	 quindi devo salvare su file lo stato di questa scelta.
	 La prima volta devo anche crearlo questo file e inserire una stringa SI, che nel caso in 
	 cui questa diventa NO farà si che non verrà più mostrato l'actionSheet
	 */
	
	NSError *error;
    NSString *homeDirectory = NSHomeDirectory();
	NSString *documentPath = [homeDirectory stringByAppendingPathComponent:@"Documents"];
	NSString *filePath = [documentPath stringByAppendingPathComponent:@"impostazioni"];
	NSString *app=[NSString stringWithContentsOfFile:filePath encoding:NSUnicodeStringEncoding error:&error];
	//Effettuo un controllo in un file di testo per verificare se l'actionSheet deve apparire o no
	if (app==nil) 
	{
		NSString *app=[NSString stringWithString:@"si"];
		[app writeToFile:filePath atomically:NO encoding:NSUnicodeStringEncoding error:&error];
		
	}
	if([app isEqual:@"si"] || app==nil)
	{
		//Mostro l'actionSheet
		
		action =[[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"Welcome to iSportRankings.If this is your first visit, you must upgrade data (Wi-fi mode):",@"") delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"Update now",@"") otherButtonTitles:nil,nil];	
		[action showInView:contentView];
		
		
		
	}
	
	
	//Istanziazione degli oggetti Bottoni e SegmentControl	
	
	UIBarButtonItem *tastoAggiorna= [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Update", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(updateData)];
    self.navigationItem.leftBarButtonItem = tastoAggiorna;
	self.navigationItem.title=@"iSportRankings";
	[tastoAggiorna release];
	
	segmentedControl=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Ranking's site",@""),NSLocalizedString(@"Credits",@""),nil]];
	segmentedControl.segmentedControlStyle = 7;
	segmentedControl.momentary=YES;
		
	//gestione del segmentControll e dell'autoresizing dell'app
	
	[segmentedControl addTarget:self action:@selector(cliccato:) forControlEvents:UIControlEventValueChanged];
	contentView.autoresizesSubviews=YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
   
	
	[contentView addSubview:segmentedControl];
	
	self.view=contentView;
	[contentView release];
	
}

//Metodo che mi gestisce il click dell segment controll

-(void)cliccato:(id)sender
{
	if( [sender selectedSegmentIndex] == 0 )
    {
		//La prima scelta
		
		[segmentedControl setEnabled:YES forSegmentAtIndex:0];
		RankingTableView *rank=[[RankingTableView alloc]init];
		
		[contentView addSubview:rank.view];
		[self.navigationController pushViewController:rank animated:YES];
		[rank release];
			
	}
	if( [sender selectedSegmentIndex] == 1 )
    {
		//La seconda scelta
		
		[segmentedControl setEnabled:YES forSegmentAtIndex:1];
		InfoViewController *info=[[InfoViewController alloc]initWithFrame:CGRectMake(contentView.frame.origin.x,contentView.frame.origin.y+44, contentView.frame.size.width, contentView.frame.size.height)];		
		
		
		[self.navigationController pushViewController:info animated:YES];
		
		[info release];
		
		
		
		
		
    }
	

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//in base a quale pulsante viene selezionato nell'actionSheet effettua la scelta
	if (buttonIndex==0) {
		
		Reachability * internetReach = [Reachability reachabilityForInternetConnection];
		Reachability * wifiReach = [Reachability reachabilityForLocalWiFi];
		[self check:wifiReach andSecond:internetReach];
		
		//Modifica la stringa contenuta nel file di impostazioni per non fare apparire l'actionSheet
		NSError *error;
		NSString *homeDirectory = NSHomeDirectory();
		NSString *documentPath = [homeDirectory stringByAppendingPathComponent:@"Documents"];
		NSString *filePath = [documentPath stringByAppendingPathComponent:@"impostazioni"];
		NSString *app=[NSString stringWithString:@"no"];
		[app writeToFile:filePath atomically:NO encoding:NSUnicodeStringEncoding error:&error];
	}
		[action release];
	
	 
}



-(void)updateData
{ 	
	//anche qui ho deciso di effettuare il richiamo dell'oggetto update su un'altro metodo
	
	Reachability * internetReach = [Reachability reachabilityForInternetConnection];
	Reachability * wifiReach = [Reachability reachabilityForLocalWiFi];
	[self check:wifiReach andSecond:internetReach];
	
	
}
-(void)check:(Reachability*) curReach andSecond:(Reachability*) curReach2 {
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	NetworkStatus netStatus2 = [curReach2 currentReachabilityStatus];
	
	if(netStatus==NotReachable && netStatus2==NotReachable)
	{
		
		UIAlertView * alertView3 = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Turn on cellular data or use Wi-Fi to access data", @"") message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[contentView addSubview:alertView3];
		[alertView3 show];
		[alertView3 release];
		
	}
	else 
	{
		/*
		 Poichè la classe Update fa uso di delegati impostati da me
		 Per effettuare richieste al server,
		 Ho voluto utilizzare anche qui un selettore per il rilascio dell'oggetto uPdate
		 L'idea è stata quella di utilizzarlo come un SEMAFORO
		 
		 */
		
		up =[[Update alloc]init]; 
		up.delegate=self;
		up.delegateMethod=@selector(rilascia:);
		[up effettuaUpdateCalcio];
		[up effettuaUpdateRugby];
		[up effettuaUpdateTennis];
		
		[up effettuaUpdateAltro];
	}
	
	
}

-(void)rilascia:(id)sender
{
[up release];	
}

//Gestione del risize dell'immagine e del segment controll in caso di landscape e portrait

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight))
	{
		
		controllo=[NSString stringWithString:@"l"];
		segmentedControl.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, 480,contentView.frame.origin.x+44);
		UIImage *image=[UIImage imageNamed:@"480x210.png"];
		[contentView setBackgroundColor:[UIColor colorWithPatternImage:image]];
		
		
	}
	else  if((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
		
		segmentedControl.frame = CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y, 320,contentView.frame.origin.x+44);
		UIImage *image=[UIImage imageNamed:@"320x480.png"];
		[contentView setBackgroundColor:[UIColor colorWithPatternImage:image]];
	self.view=contentView;
		
	}
	return YES;
	
}


//METODO TROVATO SU DEVAPP."PER UN PUGNO DI KB"

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
	[segmentedControl release];
	[up release];
    [super dealloc];
}


@end
