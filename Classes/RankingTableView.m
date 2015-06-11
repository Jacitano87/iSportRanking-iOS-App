    //
//  RankingTableView.m
//  iSportRanking
//
//  Created by Antonio Fischetti on 15/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "RankingTableView.h"
#import "TextTableView.h"
@implementation RankingTableView


-(id)init
{
	if(self = [super init]) {
	self.navigationItem.title=@"Ranking";}
	return self;
}



- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	campionati=[[NSArray alloc] initWithObjects:@"Soccer info",@"Pallone D'oro info",@"Rugby info",@"Tennis info",@"F1 info",@"Basket info",nil];
	immagini=[[NSArray alloc ]initWithObjects:@"fifas.jpeg",@"ballonDor.jpeg",@"irb.jpg",@"aptennis.jpg",@"formula1.jpeg",@"basket2.jpg",nil];
	informazioni=[[NSMutableArray alloc]init];
	
	/*
	 Mi salvo dentro l'array delle stringhe localizzate che contengono delle informazioni base sul ranking dello sport cliccato
	 Ho l'opportunità di visionare il sito riferente completo su wikiperdia..La gestione del sito è solo Italiana..in versione Mobile
	 */
	
	[informazioni addObject:NSLocalizedString(@"The International Federation of Association Football (French: Federation Internationale de Football Association), commonly known by the acronym FIFA (usual English pronunciation: fiːfa), is the international governing body of association football, futsal and beach football. Its headquarters are located in Zurich, Switzerland, and its current president is Sepp Blatter. FIFA is responsible for the organisation and governance of football's major international tournaments, most notably the FIFA World Cup, held since 1930. Nineteen editions of the FIFA World Cup have been held so far. The next edition is to be held in Brazil in 2014.FIFA has 208 member associations, three more than the International Olympic Committee and five fewer than the International Association of Athletics Federations.",@"")];
	[informazioni addObject:NSLocalizedString(@"The Ballon d'Or,referred to as the European Footballer of the Year award, was an annual association football award. It was presented to the player who had been considered to have performed the best over the previous calendar year. The award was conceived by France Football's chief magazine writer Gabriel Hanot, who asked his colleagues to vote for the player of the year in Europe in 1956. The inaugural winner was Stanley Matthews of Blackpool.",@"")];
	[informazioni addObject:NSLocalizedString(@"The International Rugby Board (IRB) is the world governing and law-making body for the sport of rugby union, and previously for rugby football. It was founded in 1886 as the International Rugby Football Board (IRFB) by the unions of Scotland, Wales and Ireland. England originally refused to take part, but in 1890, it became the first non-founding union to become a member. The International Rugby Football Board changed its name to the International Rugby Board in 1997. The IRB's headquarters are located in Dublin, Ireland.",@"")];
	[informazioni addObject:NSLocalizedString(@"The Barclays ATP World Tour Finals is a tennis tournament played at the end of each year, involving the top eight players in the men's tennis world rankings.Unlike most of the other events on the men's tour, the ATP World Tour Finals is not a straightforward knock-out tournament. Eight players are divided into two groups of four, and play three round-robin matches each against the other three players in their group. From there, the two players with the best records in each group progress to the semifinals, with the winners meeting in the final to determine the champion. Winners are awarded up to 1500 rankings points.",@"")];
	[informazioni addObject:NSLocalizedString(@"Formula One, also known as Formula 1 or F1 and referred to officially as the FIA Formula One World Championship, is the most restrictive class of single seater auto racing sanctioned by the Federation Internationale de l'Automobile (FIA). The formula in the name refers to a set of rules with which all participants' cars must comply. The F1 season consists of a series of races, known as Grands Prix (translated to English as Big Prizes), held on purpose-built circuits and public roads. The results of each race are combined to determine two annual World Championships, one for the drivers and one for the constructors, with racing drivers, constructor teams, track officials, organizers, and circuits required to be holders of valid Super Licences, the most restrictive class of racing licence issued by the FIA.",@"")];
	[informazioni addObject:NSLocalizedString(@"The National Basketball Association (NBA) is the pre-eminent men's professional basketball league in North America which consists of thirty franchised member clubs, of which twenty-nine are located in the United States and one in Canada. It is an active member of USA Basketball (USAB), which is recognized by the International Basketball Federation as the National Governing Body (NGB) for basketball in the United States. The NBA is one of the four major North American professional sports leagues, which include Major League Baseball (MLB), the National Football League (NFL), and the National Hockey League (NHL).",@"")];
	
	//Mi salvo i link a cui fare riferimento una volta cliccato per le maggiori informazioni
	link=[[NSArray alloc]initWithObjects:@"F%c3%a9d%c3%a9ration_Internationale_de_Football_Association",@"Pallone_d%27oro",@"International_Rugby_Board",@"ATP_World_Tour_Finals",@"Formula_1",@"National_Basketball_Association",nil];
	
	//Gestione della Tabella
	
	myTable=[[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
	myTable.delegate=self;
	myTable.dataSource=self;
	myTable.autoresizesSubviews = YES;
	myTable.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	[contentView addSubview:myTable];
	self.view=contentView;
	[contentView release];
	[myTable release];

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



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }

		
		UIImage * image=[UIImage imageNamed:[immagini objectAtIndex:indexPath.row]];
		cell.imageView.image=image;
		cell.textLabel.text=[campionati objectAtIndex:indexPath.row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	//Gestione delle sottoTabelle
	
	TextTableView *tab=[[TextTableView alloc]initWithStringa:[informazioni objectAtIndex:indexPath.row]andTitle:(NSString *)[campionati objectAtIndex:indexPath.row]andLink:[link objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:tab animated:YES];
	[myTable deselectRowAtIndexPath:indexPath animated:YES];
	[tab release];
	
	
}


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
	[link release];
	[campionati release];
	[immagini release];
	[informazioni release];
    [super dealloc];
}


@end
