//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "FBFeedPost.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import<Social/Social.h>
#import <Accounts/Accounts.h>
#import "IGConnect.h"
#import "AppDelegate.h"
#import "MobclixAdvertisingViewController.h"
#import "AFPhotoEditorController.h"
#import "MobclixAdView.h"

@interface RootViewController : UIViewController <UIImagePickerControllerDelegate, 
UINavigationControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIDocumentInteractionControllerDelegate,IGSessionDelegate,MobclixAdViewDelegate,AFPhotoEditorControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGAffineTransform transOrig;
    
    UILabel *lblNS;
    BOOL effectCounter;
    float ssheight;
    float sswidth;
   // float tHeight;
    
    UIView *backView;
    BOOL check;
    NSMutableArray *arrayCheck;
    
    UIImageView *imageView;
    UIImageView *imageViewTatoo;
    UIImage *imageBody;
    UIImage *imageTattoo;
    
    BOOL newMedia;
    
    UIButton *tphoto;
    UIButton *tphotoFromLibrary;
    UIButton *tphotoFromFacebook;
    UIButton *tphotoFromTwitter;
    UIButton *tphotoSelf;
    UIButton *tphotoTatoo;
    
    UIButton *btn_mail;
    
    UIScrollView *scroll;
    UIScrollView *scrollTattoo;
    
    UIActionSheet *actionSheet1;
    UIActionSheet *actionSheet2;
    
    UIButton *FacebookBtn;
    
    int fCounter;
    int fbFriendCounter;
        
    /**********************************************************/
    
    UIButton *effectButton;
    UIButton *emailButton;
    UIButton *uploadButton;
    UIButton *tattooButton;
    
    UIButton *selectPhoto;
    UIButton *selectTattoo;
    
    /**********************************************************/
    
    UIActivityIndicatorView *activityIndicator;
    
    ACAccountStore *accountStore;
    UIWebView *webView;
    
    MobclixAdView* adView;
    
    UIView *viewForUploadPicker;
    
    UIImageView *imgBack;
    
    UICollectionView *collectionImageView;
    UIView *imageGalleryView;
    
    NSMutableArray *arrRowsValues;
    NSMutableArray *arrCollection;
}

@property (nonatomic,retain) NSMutableArray *arrImages;

// mobiclix
@property(nonatomic,retain)IBOutlet MobclixAdView* adView;
//----------------------------

@property (nonatomic, assign) BOOL effectCounter;
@property (strong, nonatomic) ALAssetsLibrary* library;
/*************************************************/
@property(strong,nonatomic)IBOutlet  UIButton *effectButton;
@property(strong,nonatomic)IBOutlet  UIButton *emailButton;
@property(strong,nonatomic)IBOutlet  UIButton *uploadButton;
@property(strong,nonatomic)IBOutlet  UIButton *tattooButton;

@property(strong,nonatomic)IBOutlet  UIButton *selectPhoto;
@property(strong,nonatomic)IBOutlet  UIButton *selectTattoo;

/**************************************************/

@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic)int fCounter;
@property(nonatomic)int fbFriendCounter;

@property(nonatomic,retain)UIActionSheet *actionSheet1;
@property(nonatomic,retain)UIActionSheet *actionSheet2;

@property(strong,nonatomic) UIImage *imageBody;
@property(strong,nonatomic)UIImage *imageTattoo;


@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageViewTatoo;

//@property(strong,nonatomic)IBOutlet  UIButton *tphoto;
//@property(strong,nonatomic)IBOutlet UIButton *tphotoFromLibrary;
//@property(strong,nonatomic)IBOutlet UIButton *tphotoFromFacebook;
//@property(strong,nonatomic)IBOutlet UIButton *tphotoFromTwitter;
//@property(strong,nonatomic)IBOutlet UIButton *tphotoSelf;
//@property(strong,nonatomic)IBOutlet UIButton *tphotoTatoo;

@property(nonatomic, strong) ACAccountStore *accountStore;
@property(nonatomic, strong) NSMutableArray *facebookAccount;

// instagram
@property (strong, nonatomic) Instagram *instagram;

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;

//-(IBAction)uploadImage;
//
//-(IBAction)takePhoto;
//-(IBAction)takePhotoFromLibrary;
////-(IBAction)effectButtonClicked;
//-(IBAction)takePhotoFromTwitter;
//
////methods for main buttons 
//-(IBAction)takePhotoSelf:(id)sender ;
//-(IBAction)takePhotoTatoo;
//-(IBAction)mailBtnClicked;
- (UIImage*)imageByCropping:(UIImage *)myImage toRect:(CGRect)cropToArea;


-(IBAction)effectButtonClicked;
-(IBAction)emailButtonClicked;
-(IBAction)tattooButtonClicked;
-(IBAction)uploadButtonClicked;
-(IBAction)selectPhotoButtonClicked;
-(IBAction)selectTattooButtonClicked;
-(void)arrangeButton;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

+(RootViewController*)sharedFirstViewController; 

@end
