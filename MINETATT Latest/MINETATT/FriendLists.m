//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

/***************************************************************************************************************/

#import "FBFeedPost.h"
#import "FriendLists.h"
#import "RootViewController.h"

/****************************************************************************************************************/
@implementation FriendLists
@synthesize myTableView;
@synthesize friendsArray,tryArray,friendsId;
@synthesize imgShare;
@synthesize x;
@synthesize adView;
/********************************************////FACEBOOK
@synthesize message, caption, image, url, postType, delegate,items;

/***************************************************************************************************************/

- (void) publishPostWithDelegate:(id) _delegate {
	
	//store the delegate incase the user needs to login
	self.delegate = _delegate;
	
	// if the user is not currently logged in begin the session
	BOOL loggedIn = [[FBRequestWrapper defaultManager] isLoggedIn];
	if (!loggedIn) {
		[[FBRequestWrapper defaultManager] FBSessionBegin:self];
	}
	else {
		NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
		
		//Need to provide POST parameters to the Facebook SDK for the specific post type
		NSString *graphPath = @"me/feed";
		
		switch (postType) {
			case FBPostTypeLink:
			{
				[params setObject:@"link" forKey:@"type"];
				[params setObject:self.url forKey:@"link"];
				[params setObject:self.caption forKey:@"description"];
				break;
			}
			case FBPostTypeStatus:
			{
				[params setObject:@"status" forKey:@"type"];
				[params setObject:self.message forKey:@"message"];
				break;
			}
			case FBPostTypePhoto:
			{
			//	graphPath = @"me/photos";
				[params setObject:self.image forKey:@"source"];
				[params setObject:self.caption forKey:@"message"];
				break;
			}
            case FBPostTypeFriend://edited by me
            {
                graphPath=@"me/friends";
                [[FBRequestWrapper defaultManager] getFBRequestWithGraphPath:graphPath andDelegate:self];
                break;
            }
			default:
				break;
		}
		
		//[[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
	}	
}

#pragma mark -
#pragma mark FacebookSessionDelegate

- (void)fbDidLogin {
	[[FBRequestWrapper defaultManager] setIsLoggedIn:YES];
	
	//after the user is logged in try to publish the post
	[self publishPostWithDelegate:self.delegate];
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    [activityIndicator stopAnimating];
	[[FBRequestWrapper defaultManager] setIsLoggedIn:NO];
	
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"ResponseFailed: %@", error);
    
	[activityIndicator stopAnimating];
    
	if ([self.delegate respondsToSelector:@selector(failedToPublishPost:)])
		[self.delegate failedToPublishPost:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
    
    NSLog(@"counter = %d",[RootViewController sharedFirstViewController].fCounter);
    if([RootViewController sharedFirstViewController].fCounter==2)
    {
    NSLog(@"Parsed Response: %@", result);
    
    //edited by me
    
    NSMutableArray *nameItems=[[[NSMutableArray alloc]init]autorelease];
    friendsId=[[[NSMutableArray alloc]init]autorelease];
    
    //ok so it's a dictionary with one element (key="data"), which is an array of dictionaries, each with "name" and "id" keys
    items = [[(NSDictionary *)result objectForKey:@"data"]retain];
    for (int i=0; i<[items count]; i++) 
    {
        friend = [items objectAtIndex:i];
        NSString *fbid = [friend objectForKey:@"id"];
        NSString *name = [friend objectForKey:@"name"];

        
       [nameItems addObject:name];
        [friendsId addObject:fbid];

    }
    
    friendsArray=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic;
    for(int i=0;i<[items count];i++)
    {
        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[nameItems objectAtIndex:i],@"name",[friendsId objectAtIndex:i],@"id",nil];
        [friendsArray addObject:dic];
    }

    
   // friendsArray=nameItems;
    [self.myTableView reloadData];
    
    [activityIndicator stopAnimating];
       
	if ([self.delegate respondsToSelector:@selector(finishedPublishingPost:)])
		[self.delegate finishedPublishingPost:self];
        
        [RootViewController sharedFirstViewController].fCounter=1;
        
    }
    else
    {
        [RootViewController sharedFirstViewController].fCounter=2;
//         [activityIndicator stopAnimating];
     
        [[RootViewController sharedFirstViewController].navigationController popViewControllerAnimated:YES];
    }
}

- (void) dealloc {
	self.delegate = nil;
	[url release], url = nil;
	[message release], message = nil;
	[caption release], caption = nil;
	[image release], image = nil;
	[super dealloc];
}
/*************************************************************************************************************************////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (void) viewWillDisappear:(BOOL)animated {
//    counter++;
//    NSLog(@"counter = %d",counter);
//   
//}



#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [self.adView resumeAdAutoRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.title=@"Facebook Friends";
    // Do any additional setup after loading the view from its nib.
   // myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    
    tryArray=[[NSArray alloc]initWithObjects:@"first",@"secnod",@"third",nil];
    
    
    UIImage *buttonImage = [UIImage imageNamed:@"back_btn.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, 35, 35);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftbtn];
    
    /****************************/
    
        postType = FBPostTypeFriend;
        [self publishPostWithDelegate:self];
    
    /***************************/

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        NSLog(@"ipad");
        myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 10, 768, 945) style:UITableViewStylePlain];
        myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        //myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.myTableView.delegate=self;
        self.myTableView.dataSource=self;
        
        [self.view addSubview:myTableView];
        
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 400.0, 400.0);
    }
    else{
        
        myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 10, 320, 420) style:UITableViewStylePlain];
        myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        //myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.myTableView.delegate=self;
        self.myTableView.dataSource=self;
        
        [self.view addSubview:myTableView];
        
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    }
#endif
	
	activityIndicator.center = self.view.center;
	[self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    activityIndicator.hidesWhenStopped = YES;
    
    // starting the load, show the activity indicator in the status bar
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.adView.delegate=self;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.adView pauseAdAutoRefresh];
}
#pragma mark -
#pragma mark MobclixAdViewDelegate Methods

- (void)adViewDidFinishLoad:(MobclixAdView*)adView {
	NSLog(@"Ad Loaded: %@.", NSStringFromCGSize(self.adView.frame.size));
}

- (void)adView:(MobclixAdView*)adView didFailLoadWithError:(NSError*)error {
	NSLog(@"Ad Failed: %@.", NSStringFromCGSize(self.adView.frame.size));
}

- (void)adViewWillTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Will Touch Through: %@.", NSStringFromCGSize(self.adView.frame.size));
}

- (void)adViewDidFinishTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Did Finish Touch Through: %@.", NSStringFromCGSize(self.adView.frame.size));
}

-(void)back
{
    // Tell the controller to go back
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self.adView cancelAd];
    self.adView.delegate = nil;
    self.adView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*********************************************************************************************************************************/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // finished loading, hide the activity indicator in the status bar
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
   return [friendsArray count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text=[[friendsArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    
    return cell;
}


/***************************************************************************************************************************************/



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // RootViewController *root=[[[RootViewController alloc]init]autorelease];
    
   NSLog(@"value of indexpath  is %d",indexPath.row);
   
    
    NSString *graphPath =[[[NSString alloc]initWithFormat:@"%@/photos",[[friendsArray objectAtIndex:indexPath.row]valueForKey:@"id"]]autorelease];
    
    
    NSMutableDictionary *params = [[[NSMutableDictionary alloc] init] autorelease];
    
    [params setObject:self.imgShare forKey:@"source"];
    [params setObject:@"via Application TatooShare" forKey:@"message"];
    
    
    [[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
    
    NSLog(@"i am in table row clicked");
 
    [myTableView reloadData];
    
    [activityIndicator startAnimating];
    activityIndicator.hidesWhenStopped = YES;
    
    [RootViewController sharedFirstViewController].fbFriendCounter=1;
    
  //  [[RootViewController sharedFirstViewController].navigationController popViewControllerAnimated:YES];
    
}

/***************************************************************************************************************************************/

@end
