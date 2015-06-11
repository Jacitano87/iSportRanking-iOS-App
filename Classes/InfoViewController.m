    //
//  InfoViewController.m
//  iSportRankings
//
//  Created by Antonio Fischetti on 21/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "InfoViewController.h"
#import "MainViewController.h"

@implementation InfoViewController


- (id)initWithFrame:(CGRect)rect{
	if(self = [super init]) {
	rett=rect;
}
    return self;
}



- (void)loadView {
	
	//Setto una UIView contenitore con delle misure relative
	
	contentView = [[UIView alloc] initWithFrame:CGRectMake(rett.origin.x, rett.origin.y, rett.size.width, rett.size.height)];
	
	[contentView setBackgroundColor:[UIColor blackColor]];
	
	//Sovrascrivo il normale tasto per il ritorno indietro con un pulsate mio 
	//Gestisce anche il supporto Multilingua
	
	UIBarButtonItem *tastoBack= [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = tastoBack;
	[tastoBack release];
	
	
		
	
	self.view=contentView;
	
	
	
	contentView.autoresizesSubviews=YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	//Istanziazione e creazione delle relative label
	
	
	newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
	newLabel.center=CGPointMake(160, 20);
	newLabel.numberOfLines=1;
	newLabel.font=[UIFont boldSystemFontOfSize:15];
	newLabel.textColor=[UIColor whiteColor];
	newLabel.text=@"Copyright 2011 Fischetti Antonio";
	newLabel.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel];
	[newLabel release];
	
	
	newLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
	newLabel2.center=CGPointMake(160, 60);
	newLabel2.numberOfLines=1;
	newLabel2.font=[UIFont boldSystemFontOfSize:18];
	newLabel2.textColor=[UIColor whiteColor];
	newLabel2.text=NSLocalizedString(@"Ideated by:",@"");
	newLabel2.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel2];
	[newLabel2 release];
	
	newLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
	newLabel3.center=CGPointMake(160, 80);
	newLabel3.numberOfLines=1;
	newLabel3.font=[UIFont systemFontOfSize:15];
	newLabel3.textColor=[UIColor whiteColor];
	newLabel3.text=@"Antonio Fischetti,Dario Liotta";
	newLabel3.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel3];
	[newLabel3 release];
	
	newLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
	newLabel4.center=CGPointMake(160, 120);
	newLabel4.numberOfLines=1;
	newLabel4.font=[UIFont boldSystemFontOfSize:18];
	newLabel4.textColor=[UIColor whiteColor];
	newLabel4.text=NSLocalizedString(@"Coding and bug reviewers:",@"");
	newLabel4.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel4];
	[newLabel4 release];
	 
	newLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
	newLabel5.center=CGPointMake(160, 140);
	newLabel5.numberOfLines=1;
	newLabel5.font=[UIFont systemFontOfSize:15];
	newLabel5.textColor=[UIColor whiteColor];
	newLabel5.text=@"Antonio Fischetti";
	newLabel5.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel5];
    [newLabel5 release];
	
	newLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
	newLabel6.center=CGPointMake(160, 180);
    newLabel6.numberOfLines=1;
	newLabel6.font=[UIFont boldSystemFontOfSize:18];
	newLabel6.textColor=[UIColor whiteColor];
	newLabel6.text=NSLocalizedString(@"Data entry:",@"");
	newLabel6.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel6];
	[newLabel6 release];
	
	newLabel7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
	newLabel7.center=CGPointMake(160, 200);
	newLabel7.numberOfLines=1;
	newLabel7.font=[UIFont systemFontOfSize:15];
	newLabel7.textColor=[UIColor whiteColor];
	newLabel7.text=@"Antonio Fischetti,Giuseppe Battiato";
	newLabel7.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel7];
	[newLabel7 release];
	
	newLabel8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
	newLabel8.center=CGPointMake(160, 240);
	newLabel8.numberOfLines=1;
	newLabel8.font=[UIFont boldSystemFontOfSize:18];
	newLabel8.textColor=[UIColor whiteColor];
	newLabel8.text=NSLocalizedString(@"Data found on:",@"");
	newLabel8.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel8];
	[newLabel8 release];
	
	newLabel9 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
	newLabel9.center=CGPointMake(160, 260);
	newLabel9.numberOfLines=1;
	newLabel9.font=[UIFont systemFontOfSize:15];
	newLabel9.textColor=[UIColor whiteColor];
	newLabel9.text=@"Wikipedia";
	newLabel9.backgroundColor=[UIColor clearColor];
	[contentView addSubview:newLabel9];
	[contentView release];
	[newLabel9 release];
}
-(void)back
{
	//La gestione del ritorno nel Main
	
	MainViewController * main=[[MainViewController alloc]initWithTitle:NSLocalizedString(@"Home",@"") andImage:@"home2.png" andTag:0];
	[self.navigationController pushViewController:main animated:YES];	
	[main release];
	
}

//Gestione della rotazione e della relativa animazione

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight)){
		
	
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:2];
		
	    newLabel.center=CGPointMake(240, 20);
		
		newLabel2.center=CGPointMake(130, 50);
		newLabel3.center=CGPointMake(130, 70);
		newLabel4.center=CGPointMake(385, 50);
		newLabel5.center=CGPointMake(385, 70);
		
		newLabel6.center=CGPointMake(130, 100);
		newLabel7.center=CGPointMake(130, 120);
		newLabel8.center=CGPointMake(385, 100);
		newLabel9.center=CGPointMake(385, 120);
		
		
		
		
		[UIView commitAnimations];
	}
	if((interfaceOrientation == UIInterfaceOrientationPortrait)||(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
		
		
		
		
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:2];
		
		newLabel.center=CGPointMake(160, 20);
		newLabel2.center=CGPointMake(160, 60);
		newLabel3.center=CGPointMake(160, 80);
		newLabel4.center=CGPointMake(160, 120);
		newLabel5.center=CGPointMake(160, 140);
		newLabel6.center=CGPointMake(160, 180);
		newLabel7.center=CGPointMake(160, 200);
		newLabel8.center=CGPointMake(160, 240);
		newLabel9.center=CGPointMake(160, 260);
		[UIView commitAnimations];
		
		
		
	}
	
	
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
