//  Tatt Dat App
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>
#import "MobclixAds.h"

@interface MobclixAdvertisingViewController : UIViewController<MobclixAdViewDelegate> {
@private
	UIScrollView* scrollView; 
	
	MobclixAdView* adUnit1; // MobclixAdViewiPhone_300x50 or MobclixAdViewiPad_728x90
	MobclixAdView* adUnit2; // MobclixAdViewiPhone_300x250 or MobclixAdViewiPad_300x250
	MobclixAdView* adUnit3; // MobclixAdViewiPad_120x600
	MobclixAdView* adUnit4; // MobclixAdViewiPad_468x60
}

- (IBAction)refreshAds;
- (IBAction)moveBack:(id)sender;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *btnRight;

@property(nonatomic,retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic,retain) IBOutlet MobclixAdView*	adUnit1;
@property(nonatomic,retain) IBOutlet MobclixAdView*	adUnit2;
@property(nonatomic,retain) IBOutlet MobclixAdView*	adUnit3;
@property(nonatomic,retain) IBOutlet MobclixAdView*	adUnit4;
@end

