//
//  iSRankingAppDelegate.m
//  iSRanking
//
//  Created by Antonio Fischetti on 23/02/11.
//  Copyright 2011 Amministatore. All rights reserved.
//

#import "iSRankingAppDelegate.h"
#import "MainViewController.h"
#import "SoccerViewController.h"
#import "RugbyViewController.h"
#import "TennisViewController.h"
#import "OtherViewController.h"
#import "Reachability.h"
#import "Update.h"
#import "Appirater.h"
@implementation iSRankingAppDelegate




#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
	[Appirater appLaunched];
	
	/*
	 CREO LE RELATIVE UIVIEWCONTROLLER,LE INSERISCO ALL'INTENO DEL NAVIGATION CONTROLLER E LE RILASCIO
	 INFINE NELL'OGGETTO UITABBAR CONTROLLER, INSERISCO NELL'OPPORTUNO ARRAY I NAVIGATION CONTROLLER
	 CHE SUCCESSIVAMENTE RILASCIO.
	 */
	
	MainViewController * main=[[MainViewController alloc]initWithTitle:NSLocalizedString(@"Home",@"") andImage:@"home2.png" andTag:0];
	UINavigationController *myNav1=[[UINavigationController alloc]initWithRootViewController:main];
	myNav1.navigationBar.tintColor = [UIColor darkGrayColor];
	[main release];
	
	SoccerViewController *soccer=[[SoccerViewController alloc]initWithTitle:NSLocalizedString(@"Soccer",@"") andImage:@"soccer2.png" andTag:1];
	UINavigationController *myNav2=[[UINavigationController alloc]initWithRootViewController:soccer];
	myNav2.navigationBar.tintColor = [UIColor darkGrayColor];
	[soccer release];
	
	RugbyViewController *rugby=[[RugbyViewController alloc]initWithTitle:@"Rugby" andImage:@"rugby2.png" andTag:2];
	UINavigationController *myNav3=[[UINavigationController alloc]initWithRootViewController:rugby];
	myNav3.navigationBar.tintColor = [UIColor darkGrayColor];
	[rugby release];
	
	TennisViewController *tennis=[[TennisViewController alloc]initWithTitle:@"Tennis" andImage:@"tennis.png" andTag:3];
	UINavigationController *myNav4=[[UINavigationController alloc]initWithRootViewController:tennis];
	myNav4.navigationBar.tintColor = [UIColor darkGrayColor];
	[tennis release];
	
	OtherViewController *other=[[OtherViewController alloc]initWithTitle:NSLocalizedString(@"Other",@"") andImage:@"others2.png" andTag:4];
	UINavigationController *myNav5=[[UINavigationController alloc]initWithRootViewController:other];
	myNav5.navigationBar.tintColor = [UIColor darkGrayColor];
    [other release];
	//Istanzio e definisco il controllore
	UITabBarController * tabBar=[[UITabBarController alloc]init];
	NSArray * array=[NSArray arrayWithObjects:myNav1,myNav2,myNav3,myNav4,myNav5,nil];
    
	[myNav1 release];
	[myNav2 release];
	[myNav3 release];
	[myNav4 release];
	[myNav5 release];
	
	[tabBar  setViewControllers:array];
	
	[window addSubview:tabBar.view];
	
	
	
    [window makeKeyAndVisible];
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	
    [window release];
    [super dealloc];
}


@end
