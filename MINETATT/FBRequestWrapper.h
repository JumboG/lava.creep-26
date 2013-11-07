//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <Foundation/Foundation.h>
#import "Facebook.h"

//#define FB_APP_ID @"197366800287642"//412765842100017
//#define FB_APP_ID @"412765842100017" ts
#define FB_APP_ID @"630622230281481"


//#define FB_API_KEY @"3269fff9ef3b6fc13255e670ebb44c4d" ts

#define FB_API_KEY @"4c88d9a6e09a0d90de2c4339a269feba"


//#define FB_APP_SECRET @"d038b12cc8632865952f69722fe26393"//371c2a8b93b0a3306335d746ffcd317b

//#define FB_APP_SECRET @"371c2a8b93b0a3306335d746ffcd317b" ts
#define FB_APP_SECRET @"4c88d9a6e09a0d90de2c4339a269feba"

@interface FBRequestWrapper : NSObject <FBRequestDelegate, FBSessionDelegate> 
{
	Facebook *facebook;
	BOOL isLoggedIn;
}

@property (nonatomic, assign) BOOL isLoggedIn;

+ (id) defaultManager;
- (void) setIsLoggedIn:(BOOL) _loggedIn;
- (void) FBSessionBegin:(id<FBSessionDelegate>) _delegate;
- (void) FBLogout;
- (void) getFBRequestWithGraphPath:(NSString*) _path andDelegate:(id) _delegate;
- (void) sendFBRequestWithGraphPath:(NSString*) _path params:(NSMutableDictionary*) _params andDelegate:(id) _delegate;

@end
