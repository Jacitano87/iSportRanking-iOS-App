//
//  UIWebView.h
//  iSportRanking
//
//  Created by Antonio Fischetti on 12/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 La seguente classe serve per la visualizzazione dei contenuti online
 Questa infatti è unica per tutte le informazioni di ogni sport e per il ranking
*/

@interface IWebView : UIViewController <UIWebViewDelegate>{
	NSString *urlAddress;
	NSURLRequest *req;
    NSString *tipos;
	NSString *stringas;
	UIWebView *myContentView;
	UIAlertView *alertView3;
}
-(id)initWithStringa:(NSString *)stringa andTipo:(NSString *)tipo;
@end
