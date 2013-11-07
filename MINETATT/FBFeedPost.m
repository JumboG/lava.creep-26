//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import "FBFeedPost.h"
#import "RootViewController.h"


#import "FriendLists.h"

@implementation FBFeedPost
@synthesize message, caption, image, url, postType, delegate;

- (id) initWithLinkPath:(NSString*) _url caption:(NSString*) _caption {
	self = [super init];
	if (self) {
		postType = FBPostTypeLink;
		url = [_url retain];
		caption = [_caption retain];
	}
	return self;
}

- (id) initWithPostMessage:(NSString*) _message {
	self = [super init];
	if (self) {
		postType = FBPostTypeStatus;
		message = [_message retain];
	}
	return self;
}

- (id) initWithPhoto:(UIImage*) _image name:(NSString*) _name {
	self = [super init];
	if (self) {
		postType = FBPostTypePhoto;
		image = [_image retain];
        
        NSLog(@"name is ---------->%@",_name);
		caption = [_name retain];//edited by me
	}
	return self;
}

/***************************************************************************************************************/

- (id) initWithFriendList:(UIImage*) _image //:(NSString*) _url caption:(NSString*) _caption {
{	
    NSLog(@"i am here in init method");
    self = [super init];
	if (self) {
		postType = FBPostTypeFriend;
		//url = [_url retain];
		//caption = [_caption retain];
	}
	return self;
}


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
                [[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
				break;
			}
			case FBPostTypeStatus:
			{
				[params setObject:@"status" forKey:@"type"];
				[params setObject:self.message forKey:@"message"];
                [[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
				break;
			}
			case FBPostTypePhoto:
			{
				graphPath = @"me/photos";
				[params setObject:self.image forKey:@"source"];
				[params setObject:self.caption forKey:@"message"];
                [[FBRequestWrapper defaultManager] sendFBRequestWithGraphPath:graphPath params:params andDelegate:self];
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
	[[FBRequestWrapper defaultManager] setIsLoggedIn:NO];
	
}

#pragma mark -
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"ResponseFailed: %@", error);
	
	if ([self.delegate respondsToSelector:@selector(failedToPublishPost:)])
		[self.delegate failedToPublishPost:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"Parsed Response: ---->%@", result);
    
 
    
    [[RootViewController sharedFirstViewController].activityIndicator stopAnimating];
    
    UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"MINETATT" message:@"Successfully Post " 
                                                         delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    
    [alertView show];
    
    
    
    
    //edited by me
    
    NSMutableArray *nameItems=[[[NSMutableArray alloc]init]autorelease];
    
    //ok so it's a dictionary with one element (key="data"), which is an array of dictionaries, each with "name" and "id" keys
    items = [[(NSDictionary *)result objectForKey:@"data"]retain];
    for (int i=0; i<[items count]; i++) {
        NSDictionary *friend = [items objectAtIndex:i];
        long long fbid = [[friend objectForKey:@"id"]longLongValue];
        NSString *name = [friend objectForKey:@"name"];
        
        [nameItems addObject:name];
        
        NSLog(@"id: %lld - Name: %@", fbid, name);
    }
    
  //  FriendListFacebook *obj=[[FriendListFacebook alloc]init];
    
  //  [obj getFreindName:items];
    
//    FBFriends *obj1=[[FBFriends alloc]init];
//    [obj1 getFreindName:nameItems];
    
    
//    FriendLists *obj1=[[[FriendLists alloc]init]autorelease];
//    [obj1 getFreindName:nameItems];
//
    
   
    //SendPics *newEnterNameController = [[SendPics alloc]initWithNibName:@"SendPics" bundle:[NSBundle mainBundle]];
   // [[self navigationController] pushViewController:newEnterNameController animated:YES];

    
    //ends
    
    
    
	
	if ([self.delegate respondsToSelector:@selector(finishedPublishingPost:)])
		[self.delegate finishedPublishingPost:self];
}


- (void) dealloc {
	self.delegate = nil;
	[url release], url = nil;
	[message release], message = nil;
	[caption release], caption = nil;
	[image release], image = nil;
	[super dealloc];
}

@end
