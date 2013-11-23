//  Tatt Dat App
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>
/************************/
#import "MobclixAdvertisingViewController.h"
#import "MobclixAdView.h"

#import "FBRequestWrapper.h"

@protocol FBFeedPostDelegate;

  /*************************/

@interface FriendLists : UIViewController<UITableViewDelegate,UITableViewDataSource,MobclixAdViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *friendsArray;
    NSMutableArray *friendsId;
    NSArray *tryArray;
    
    UIImage *imgShare;
    NSDictionary *friend;
    int x;
    
    UIActivityIndicatorView *activityIndicator;
    /******************************///Facebook
    
    
    NSString *url;
	NSString *message;
	NSString *caption;
	UIImage *image;
	FBPostType postType;
    
    NSArray *items; // to get facebook friends
	
	id <FBFeedPostDelegate> delegate;
    
    
    
    MobclixAdView* adView;
    
    
}
@property(nonatomic)int x;
@property(nonatomic,retain)UIImage *imgShare;
@property(nonatomic,retain)NSArray *tryArray;
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *friendsArray;
@property(nonatomic,retain)NSMutableArray *friendsId;


// mobiclix
@property(nonatomic,retain)IBOutlet MobclixAdView* adView;



/***************************************/
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) FBPostType postType;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, assign) id <FBFeedPostDelegate> delegate;

- (id) initWithLinkPath:(NSString*) _url caption:(NSString*) _caption;
- (id) initWithPostMessage:(NSString*) _message;
- (id) initWithPhoto:(UIImage*) _image name:(NSString*) _name;
- (void) publishPostWithDelegate:(id) _delegate;

@end


@protocol FBFeedPostDelegate <NSObject>
@required
- (void) failedToPublishPost:(FBFeedPost*) _post;
- (void) finishedPublishingPost:(FBFeedPost*) _post;

/**************************************/


@end
