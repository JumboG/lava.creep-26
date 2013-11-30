//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MFMailComposeViewController.h>


#import "MobclixAdvertisingViewController.h"

#import "MobclixAdView.h"

@interface SendPics : UIViewController<UIImagePickerControllerDelegate, 
UINavigationControllerDelegate,MFMailComposeViewControllerDelegate,MobclixAdViewDelegate>
{
    UIImageView *imageView;
    BOOL newMedia;
    
    UIButton *cameraButton;
    UIButton *libraryButton;
    UIButton *sendMailButton;
    UIView *tempView2;
    
    MobclixAdView* adView;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic,retain)IBOutlet UIButton *cameraButton;
@property(nonatomic,retain)IBOutlet UIButton *libraryButton;
@property(nonatomic,retain)IBOutlet UIButton *sendMailButton;

// mobiclix
@property(nonatomic,retain)IBOutlet MobclixAdView* adView;

-(IBAction)cameraButtonClicked;
-(IBAction)libraryButtonClicked;
-(IBAction)sendEmailButtonClicked;


@end
