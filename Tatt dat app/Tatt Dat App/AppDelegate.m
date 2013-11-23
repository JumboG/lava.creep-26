//  Tatt Dat App
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import "AppDelegate.h"
#import "RootViewController.h"

#import "Mobclix.h"

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"logged_in"];
    
    UIViewController *rootController;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            
            NSLog(@"gaurav");
        }
        if(result.height == 568)
        {
            // iPhone 5
        }
    }

    // This is where Mobclix should be called.
  //  [Mobclix startWithApplicationId:@"0C5A93D1-E3CE-4CE4-BF66-8DC4430A5633"];
   

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            NSLog(@"Iphone");
            rootController = [[[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil]autorelease];
        }
        else{
            NSLog(@"Iphone");
            rootController = [[[RootViewController alloc]initWithNibName:@"RootViewController5" bundle:nil]autorelease];
        }
        
       
    }
    else
    {
        NSLog(@"ipad");
        rootController = [[[RootViewController alloc]initWithNibName:@"RootViewController~iPad" bundle:nil]autorelease];
    }
    
    
   navigationController = [[UINavigationController alloc]initWithRootViewController:rootController];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_new_iphone.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_new.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
 
    
    
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
   // navigationController.title=@"Tatoo Pics";
    
    //self.navigationItem.hidesBackButton = YES; 
/*	UINavigationBar *navBar = self.navigationcontroller.navigationBar;
	
	UIImage *image = [UIImage imageNamed:@"striptoppng.png"];
	UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,55)];
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
	imgView.image = image;
	[tempView addSubview:imgView];
	[navBar addSubview:tempView];
	[tempView release];
  */  
   
    [self.window addSubview:navigationController.view];
//    UIView *viewAdd=[[UIView alloc]initWithFrame:CGRectMake(0, 385, 320, 32)];
//    viewAdd.backgroundColor=[UIColor grayColor];
//    [self.window addSubview:viewAdd];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
