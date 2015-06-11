//
//  LoadData.h
//  ConnessioneWeb
//
//  Created by Antonio Fischetti on 18/11/10.
//  Copyright 2010 Amministatore. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 ANCHE QUESTA CLASSE EFFETTUA OPERAZIONI STANDARD PER LA RICHIESTA 
 DI DATI DA UN SERVER REMOTO...PASSO NEL COSTRUTTORE L'URL, E TRAMITE 
 LA DELEGAZIONE, POSSO FAR RESTITUIRE I DATI AL METODO CHIAMANTE APPENA QUESTI
 SIANO EFFETTIVAMENTE PRONTI
 */

@interface LoadData : NSObject {

	//DATI E URL
	
	NSMutableData * dati;
	NSURLConnection * connessione;
	NSURL * url;
	
	/*
	 GESTIONE DEL METODO DELEGATO
	 */
	
	id delegate;
	SEL delegateMethod;
	SEL delegateErrorMethod;
	
}
//METODI INTERNI E COSTRUTTORE
-(void)EffettuaRichiesta;
-(id)initWithMyUrl:(NSString *)aUrl;

	
//PROPERTY CHE MI SERVONO ALLA GESTIONE DEL METODO DELEGATO E ESPORTAZIONE DATI
@property(nonatomic,assign)id delegate;
@property(nonatomic) SEL delegateMethod;
@property (nonatomic) SEL delegateErrorMethod;
@property(nonatomic,retain)NSMutableData * dati;

@end
