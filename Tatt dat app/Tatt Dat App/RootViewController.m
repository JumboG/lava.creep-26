//  Tatt Dat App
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import "RootViewController.h"
#import "ImageBase.h"
#import "SendPics.h"
#import "ImageMove.h"
#import "AFPhotoEditorController.h"
#import "Twitter/Twitter.h"
#import "FriendLists.h" 
#import "QuartzCore/QuartzCore.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "IFNNotificationDisplay.h"


//#include <QuartzCore/QuartzCore.h>

#import "FBRequestWrapper.h"


#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

@implementation RootViewController
@synthesize imageView,imageViewTatoo;
//@synthesize tphoto ,tphotoFromLibrary ,tphotoFromFacebook ,tphotoFromTwitter ,tphotoSelf, tphotoTatoo;
@synthesize imageBody,imageTattoo;
@synthesize actionSheet1,actionSheet2;
@synthesize fCounter,fbFriendCounter;
@synthesize selectPhoto,selectTattoo;
@synthesize activityIndicator,effectCounter;

@synthesize instagram = _instagram;

@synthesize adView;

@synthesize effectButton,tattooButton,emailButton,uploadButton,accountStore,facebookAccount;

int imgCounter=0;

float x,y;

static RootViewController* _sharedFirstViewController = nil;
   
int highlitedButton=1;

-(IBAction)selectPhotoButtonClicked
{
    imgCounter=1;
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"])
    {
        lblNS.text=@"FALSE";
    }

  //  scroll.scrollEnabled = FALSE;
    
    UIActionSheet *popupQuery = [[[UIActionSheet alloc] initWithTitle:@"Tatt dat app" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Library", nil]autorelease];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    
	
    [popupQuery showInView:self.view];   
}
-(IBAction)selectTattooButtonClicked{
 
    NSLog(@"take photo tatoo called");
    imgCounter=2;
    UIActionSheet *popupQuery = [[[UIActionSheet alloc] initWithTitle:@"Tatt dat app" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Library", nil]autorelease];
    
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    [popupQuery showInView:self.view];
    
}
/************************************************************///Main buttons codeing

-(IBAction)effectButtonClicked
{
    NSLog(@"Effect button");
    
    highlitedButton=2;
    [self arrangeButton];
    
    UIActionSheet *popupQuery1 = [[UIActionSheet alloc] initWithTitle:@"Tatt dat app" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Image Effects" otherButtonTitles:@"Tatoo Effects", nil];
    
    
    popupQuery1.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    actionSheet1=popupQuery1;
	
    [popupQuery1 showInView:self.view];
    
}


/*************************************************************////Email Button clicked
-(IBAction)emailButtonClicked{
    highlitedButton=3;
    [self arrangeButton];
    if(imageView.image)
    {
        SendPics *newEnterNameController;
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            
        {
            NSLog(@"ipad");
            newEnterNameController = [[[SendPics alloc]initWithNibName:@"SendPics~iPad" bundle:[NSBundle mainBundle]]autorelease];
        }
        else
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            
            if(result.height == 480)
            {
                NSLog(@"Iphone");
                newEnterNameController = [[[SendPics alloc]initWithNibName:@"SendPics" bundle:nil]autorelease];
            }
            else{
                NSLog(@"Iphone");
                newEnterNameController = [[[SendPics alloc]initWithNibName:@"SendPics5" bundle:nil]autorelease];
            }           
        }
        
#endif
        [[self navigationController] pushViewController:newEnterNameController  animated:YES];
    }
    else
    {
        UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Mail to Friend" message:@"Select photo First" 
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        
        [alertView show];
    }

}
-(IBAction)tattooButtonClicked{
    highlitedButton=1;
    [self arrangeButton];
    
}

/*********************************************************///Upload button clicked
-(IBAction)uploadButtonClicked{
    
    highlitedButton=4;
    [self arrangeButton];
    
//    UIActionSheet *popupQuery2 = [[UIActionSheet alloc] initWithTitle:@"Tatt dat app" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:@"",@"",@"",@"",nil];
//    popupQuery2.frame=CGRectMake(0, 400, 320, 400);
    
//    UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnCancel.frame=CGRectMake(25, 285, 250, 65);
//    [btnCancel setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
//    [popupQuery2 addSubview:btnCancel];
//    
//    UIButton *btnFb1=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnFb1.frame=CGRectMake(25, 5, 250, 65);
//    [btnFb1 setImage:[UIImage imageNamed:@"ShareFB.png"] forState:UIControlStateNormal];
//    [popupQuery2 addSubview:btnFb1];
//    
//    UIButton *btnTwit=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnTwit.frame=CGRectMake(25, 75, 250, 65);
//    [btnTwit setImage:[UIImage imageNamed:@"ShareTwitter.png"] forState:UIControlStateNormal];
//    [popupQuery2 addSubview:btnTwit];
//    
//    UIButton *btnFb2=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnFb2.frame=CGRectMake(25, 145, 250, 65);
//    [btnFb2 setImage:[UIImage imageNamed:@"ShareFB.png"] forState:UIControlStateNormal];
//    [popupQuery2 addSubview:btnFb2];
//    
//    UIButton *btnInstag=[UIButton buttonWithType:UIButtonTypeCustom];
//    btnInstag.frame=CGRectMake(25, 215, 250, 65);
//    [btnInstag setImage:[UIImage imageNamed:@"ShareInstagram.png"] forState:UIControlStateNormal];
//    [popupQuery2 addSubview:btnInstag];
    
//    [[[popupQuery2 valueForKey:@"_buttons"] objectAtIndex:4] setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
//    
//    [[[popupQuery2 valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"ShareFB.png"] forState:UIControlStateNormal];
//    
//    [[[popupQuery2 valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"ShareTwitter.png"] forState:UIControlStateNormal];
//    
//    [[[popupQuery2 valueForKey:@"_buttons"] objectAtIndex:2] setImage:[UIImage imageNamed:@"ShareFB.png"] forState:UIControlStateNormal];
//    
//    [[[popupQuery2 valueForKey:@"_buttons"] objectAtIndex:3] setImage:[UIImage imageNamed:@"ShareInstagram.png"] forState:UIControlStateNormal];
//    
//    popupQuery2.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    
//    actionSheet2=popupQuery2;
//	
//    [popupQuery2 showInView:self.view];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        NSLog(@"ipad");
        [UIView beginAnimations:@"Start" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        viewForUploadPicker.frame=CGRectMake(0, 650, 768, 320);
        [UIView commitAnimations];
    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            NSLog(@"Iphone4");
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 100, 320, 320);
            [UIView commitAnimations];
            
        }
        else{
            NSLog(@"Iphone5");
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 190, 320, 320);
            [UIView commitAnimations];
        }
    }

}
                                    //UPLoading Images
/********************************************************************************************************************************/
-(IBAction)uploadImage
{
    UIActionSheet *popupQuery2 = [[UIActionSheet alloc] initWithTitle:@"Tatt dat app" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Post on Facebook Wall" otherButtonTitles:@"Post on Tweeter Wall",@"Facebook Friends Wall", nil];
    
    
    popupQuery2.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    actionSheet2=popupQuery2;
	
    [popupQuery2 showInView:self.view];
       
}
                                    //POST IMAGE ON FACEBOOK WALL
/********************************************************************************************************************************/


-(void)postImageOnFacebookWall
{
    [self callFrameSet];
    
    if (imageView.image)
    {
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version>=6.0)
        {
//            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//            {
            
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [controller setInitialText:@"Hello! Welcome to Tat dat app"];
                [controller addImage:imageView.image];
                
                SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
                {
                    
                    NSString *output;
                    switch (result)
                    {
                        case SLComposeViewControllerResultCancelled:
                            output = @"Action Cancelled";
                            //dismissViewControllerAnimated:YES completion:nil];
                            break;
                            
                        case SLComposeViewControllerResultDone:
                        {
                            output = @"Post Successfull";
                        }
                            break;
                        default:
                            break;
                    }
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    
                    [controller dismissViewControllerAnimated:YES completion:Nil];
                };
                controller.completionHandler =myBlock;
                
                [controller setInitialText:[NSString stringWithFormat:@"Welcome"]];
                [controller addImage:imageView.image];
                [controller addURL:[NSURL URLWithString:@"http://www.facebook.com/tattdatapp"]];
                //[controller addImage:choosePhotoBtn.imageView.image];
                [self presentViewController:controller animated:YES completion:Nil];
           // }

        }
        else
        {
            FBFeedPost *post = [[FBFeedPost alloc] initWithPhoto:self.imageView.image name:@"Image Posted"];
            [post publishPostWithDelegate:self];
            
            [activityIndicator startAnimating];
            activityIndicator.hidesWhenStopped = YES;
        }
        //  [[FBRequestWrapper defaultManager] FBLogout];
        
        //  NSLog(@"facebook action called");
        
    }
    else
    {
        UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Facebook " message:@"Select photo to Upload" 
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        
        [alertView show]; 
    }

}
#pragma mark- new Facebook Code integrated


//------------------------------------------------------------------

                                // POST IMAGE ON FRIENDS WALL FACEBOOK
/********************************************************************************************************************************/
-(void)postImageOnFriendsFacebookWall
{
    FriendLists *friendList;
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
       NSLog(@"ipad"); 
        friendList=[[[FriendLists alloc]initWithNibName:@"FriendLists~iPad" bundle:[NSBundle mainBundle]]autorelease];
      
    }
    else{
        friendList=[[[FriendLists alloc]initWithNibName:@"FriendLists" bundle:[NSBundle mainBundle]]autorelease];
    }
#endif
        
    
   
    if (imageView.image)
    {
        
        friendList.imgShare=[[[UIImage alloc]init]autorelease];
        friendList.imgShare=imageView.image;
        friendList.x=imgCounter;
        
        [[self navigationController] pushViewController:friendList  animated:YES];
        
    }
    else
   {
        UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Select photo to Upload" 
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
       
       [alertView show];
       
  }

}
-(void)callFrameSet
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        [UIView beginAnimations:@"Start" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        viewForUploadPicker.frame=CGRectMake(0, 1024, 768, 320);
        [UIView commitAnimations];
    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 568, 320, 320);
            [UIView commitAnimations];
        }
        else{
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 568, 320, 320);
            [UIView commitAnimations];
        }
        
    }

}

//POST IMAGE ON TWEETER WALL
/********************************************************************************************************************************/


- (void)postImageOnTweeterWall
{
    [self callFrameSet];
    
    if (imageView.image)
    {
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version>=6.0)
        {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
                SLComposeViewController *twitterCompose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [twitterCompose setInitialText:@"Hello! Welcome to Tat dat app"];
                [twitterCompose addImage:imageView.image]; // Adding your UIImage
                
                twitterCompose.completionHandler = ^(SLComposeViewControllerResult result){
                    // Handle result, dismiss view controller
                    [self dismissViewControllerAnimated:YES
                                             completion:nil];
                };
                
                [self presentViewController:twitterCompose
                                   animated:YES
                                 completion:nil];
        }
        else{
                // Wow you're going retro with this app, 
                // you must be on iOS 4 if you ever get here...
            }
        }
        else
        {
            if( NSClassFromString(@"TWTweetComposeViewController") ){
                // We don't have the Social framework, work with the Twitter framework
                // iOS 5 only will use this
                
                if( [TWTweetComposeViewController canSendTweet] ){
                    TWTweetComposeViewController *twitterCompose = [[TWTweetComposeViewController alloc] init];
                    
                    [twitterCompose addImage:imageView.image];
                    [twitterCompose setInitialText:@"Hello! Welcome to Tat dat app "];
                    twitterCompose.completionHandler = ^(TWTweetComposeViewControllerResult result){
                        // Handle result, dismiss view controller
                        [self dismissViewControllerAnimated:YES
                                                 completion:nil];
                    };
                    [self presentViewController:twitterCompose
                                       animated:YES
                                     completion:nil];
                }else{
                    // the user hasn't go Twitter set up on their device.
                }
            }
            
    /*        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
            // Set the initial tweet text. See the framework for additional properties that can be set.
            [tweetViewController setInitialText:@"Hello! Welcome to Tat dat app "];
            [tweetViewController addImage:imageView.image];
            // Create the completion handler block.
            [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result)
             {
                 NSString *output;
                 
                 switch (result) {
                     case TWTweetComposeViewControllerResultCancelled:
                         // The cancel button was tapped.
                         output = @"Tweet cancelled.";
                         break;
                     case TWTweetComposeViewControllerResultDone:
                         // The tweet was sent.
                         output = @"Tweet done.";
                         break;
                     default:
                         break;
                 }
                 
                 [self performSelectorOnMainThread:@selector(displayText) withObject:output waitUntilDone:NO];
                 
                 // Dismiss the tweet composition view controller.
                 [self dismissModalViewControllerAnimated:YES];
             }];
            
            // Present the tweet composition view controller modally.
            [self presentModalViewController:tweetViewController animated:YES];
            
            // Create an account store object.
            accountStore = [[ACAccountStore alloc] init];
            
            // Create an account type that ensures Twitter accounts are retrieved.
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            
            // Request access from the user to use their Twitter accounts.
            [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
                if(granted) {
                    // Get the list of Twitter accounts.
                    NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
                    
                    // For the sake of brevity, we'll assume there is only one Twitter account present.
                    // You would ideally ask the user which account they want to tweet from, if there is more than one Twitter account present.
                    if ([accountsArray count] > 0) {
                        // Grab the initial Twitter account to tweet from.
                        ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                        
                        // Create a request, which in this example, posts a tweet to the user's timeline.
                        // This example uses version 1 of the Twitter API.
                        // This may need to be changed to whichever version is currently appropriate.
                        TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"] parameters:[NSDictionary dictionaryWithObject:@"Hello. This is a tweet." forKey:@"status"] requestMethod:TWRequestMethodPOST];
                        
                        // Set the account used to post the tweet.
                        [postRequest setAccount:twitterAccount];
                        
                        // Perform the request created above and create a handler block to handle the response.
                        [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
                            [self performSelectorOnMainThread:@selector(displayText) withObject:output waitUntilDone:NO];
                        }];
                    }
                }
            }];
*/
        
            }
    }
    else
    {   UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Tweeter" message:@"Select photo to Upload" 
                                                                 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            
            [alertView show];
            
       
        
    }
}


/********************************************************************************************************************************/


- (UIImage*)imageByCropping:(UIImage *)myImage toRect:(CGRect)cropToArea{
    CGImageRef cropImageRef = CGImageCreateWithImageInRect(myImage.CGImage, cropToArea);
    UIImage* cropped = [UIImage imageWithCGImage:cropImageRef];
    
    CGImageRelease(cropImageRef);
    return cropped;
}

/*************************************************************************************************/

//Delegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
   // [self dismissModalViewControllerAnimated:YES]; for ios 5
    //[self dismissViewControllerAnimated:NO completion:nil];//for ios 6
   // [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info 
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        if(imgCounter==1)
        {
            imageView.image = image;
            imageBody=image;
           // scroll.userInteractionEnabled = YES;
            
           // imageView.contentMode = UIViewContentModeScaleToFill;
            
            
         
           // imageView.contentMode = UIViewContentModeScaleAspectFill;
//            imageView.contentMode =UIViewContentModeScaleAspectFit;
        }
        else if(imgCounter==2)
        {
            imageViewTatoo.image=image;
            imageTattoo=image;
           //imageViewTatoo.contentMode = UIViewContentModeScaleAspectFill;
            imageViewTatoo.contentMode = UIViewContentModeScaleAspectFit;
                       // imageViewTatoo.contentMode =UIViewContentModeScaleAspectFit;
        }
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image, 
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
		// Code here to support video if enabled
	}
}

- (void) storeimage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"tattoo.ig"];
    UIImage *NewImg=[self resizedImage:imageView.image :CGRectMake(0, 0, 612, 612) ];
    NSData *imageData = UIImagePNGRepresentation(NewImg);
    [imageData writeToFile:savedImagePath atomically:NO];
}

-(UIImage*) resizedImage:(UIImage *)inImage :(CGRect) thumbRect
{
    CGImageRef imageRef = [inImage CGImage];
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    // There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
    // see Supported Pixel Formats in the Quartz 2D Programming Guide
    // Creating a Bitmap Graphics Context section
    // only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
    // and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
    // The images on input here are likely to be png or jpeg files
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,       // width
                                                thumbRect.size.height,      // height
                                                CGImageGetBitsPerComponent(imageRef),   // really needs to always be 8
                                                4 * thumbRect.size.width,   // rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef  ref = CGBitmapContextCreateImage(bitmap);
    UIImage*    result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);   // ok if NULL
    CGImageRelease(ref);
    
    return result;
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error 
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil]autorelease];
        [alert show];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

/**************************************************************************************************/




-(void)takePhoto
{
   // NSLog(@"takephoto");
    
 
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker 
                                animated:YES];
        newMedia = YES;
    }

}

-(void)takePhotoFromLibrary
{
 /*  // NSLog(@"takephoto from library");
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = 
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
        newMedia = NO;
    }
  */
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        NSLog(@"ipad");
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [popover presentPopoverFromRect:CGRectMake(0.0, 0.0, 400.0, 400.0)
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
        newMedia = NO;
    }
    else
    {
        NSLog(@"Iphone");
        // NSLog(@"takephoto from library");
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker.allowsEditing = NO;
            [self presentModalViewController:imagePicker animated:YES];
            newMedia = NO;
        }
        
        
    }
    
    
#endif
    


}



-(IBAction)takePhotoSelf:(id)sender
{
    
    imgCounter=1;
    
   // scroll.scrollEnabled = FALSE;
    
    UIActionSheet *popupQuery = [[[UIActionSheet alloc] initWithTitle:@"Tatt Dat App" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Library", nil]autorelease];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
   
	
    [popupQuery showInView:self.view];
	
  //  [popupQuery release];

    
    
}
                                    //ACTION SHEET 

/********************************************************************************************************************************/

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    
    if (actionSheet==actionSheet1)
    {
        // do something
        if (buttonIndex == 0)
        {
            NSLog (@"button index 0 Pressed");
            
            if(imageView.image)
            {
                effectCounter=YES;
                [self displayEditorForImage:imageView.image];
            }
            else
            {
                UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Effects " message:@"Select photo to Upload"
                                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                
                [alertView show]; 
            }
        }
        else if (buttonIndex == 1)
        {
            NSLog (@"button index 1 pressed");
            
            if(imageViewTatoo.image)
            {
                effectCounter=NO;
                [self displayEditorForImage:imageViewTatoo.image]; 
            }
            else
            {
                UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Effects " message:@"Select Tatoo to Upload" 
                                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
                
                [alertView show]; 
            }
        } 
        else if (buttonIndex == 2)
        {
            NSLog (@"button index 2 pressed");
        }
      
    }
    else if(actionSheet==actionSheet2)
    {
        if (buttonIndex == 0)
        {
            NSLog (@"button index 0 Pressed");
            
            [self postImageOnFacebookWall];
             
        }
        else if (buttonIndex == 1)
        {
            NSLog (@"button index 1 pressed");
            [self postImageOnTweeterWall];
            
        } 
        else if (buttonIndex == 2)
        {
            fCounter=2;
            NSLog(@"counter = %d",fCounter);
            NSLog (@"button index 2 pressed");
            [self postImageOnFriendsFacebookWall];
        }
        else if (buttonIndex == 3)
        {
            NSLog (@"button index 3 pressed");
            [self shareOnInstagram];
        }
        
    }
    else
    {
        // do something
        if (buttonIndex == 0) {
            
            NSLog (@"button Camera Pressed");
            [self takePhoto];
            
        } else if (buttonIndex == 1) {
            
            
            
            NSLog (@"button Library pressed");
            
            [self takePhotoFromLibrary];
            
          // CGSize scrollSize = scroll.frame.size;
            //[scroll setContentSize:scrollSize];
            
           // imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight);
            
           // CGPoint center = imageView.center;
           // center.x = scroll.center.x;
           // imageView.center = center;
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            
        //    [scroll setZoomScale:1 animated:NO];
          // scroll.delegate=nil;
          //  scroll.scrollEnabled = FALSE;
            
            
        } else if (buttonIndex == 2) {
            
            NSLog (@"button index 2 pressed");
            
        } else if (buttonIndex == 3) {
            
            NSLog (@"button index 3 pressed");
            
        }

    }
   
		
}
/*****************************************************************************************************************************/
-(void)takePhotoTatoo
{
    NSLog(@"take photo tatoo called");
    imgCounter=2;
    UIActionSheet *popupQuery = [[[UIActionSheet alloc] initWithTitle:@"Tatt Dat App" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Library", nil]autorelease];
    
    	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    [popupQuery showInView:self.view];
    
}

-(void)takePhotoFromTwitter//merge
{
    int width=500;
    int height=500;
    NSLog(@"takephoto from twitter");
    UIImage *bottomImage = self.imageView.image;//background image
   
    
    UIImage *image       = self.imageViewTatoo.image;//foreground image
    
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext( newSize );
    
    // Use existing opacity as is
    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Apply supplied opacity if applicable
    //  [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.8];
    
    
    //[image drawInRect:CGRectMake(180,200,200,200) blendMode:kCGBlendModeNormal alpha:0.3];
    
//    [image drawInRect:CGRectMake(180,200,200,200) blendMode:kCGBlendModeColorBurn alpha:0.4];
    
    [image drawInRect:CGRectMake(180,200,200,200) blendMode:kCGBlendModeDarken alpha:0.4];
    
  //  [image drawInRect:CGRectMake(180,200,200,200) blendMode:kCGBlendModeMultiply alpha:0.4];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    ///////////////
    
  //  CGSize newSize1 = CGSizeMake(300, 300);
   // newImage=[self imageWithImage:imageView.image scaledToSize:newSize1];
    
    //////////////
    
    
    
    UIGraphicsEndImageContext();
    
    
    imageView.image=newImage;
    
    
}
  
// resize the image

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
                  
    
    UIGraphicsBeginImageContext(newSize);
                  
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage1 = UIGraphicsGetImageFromCurrentImageContext();
                  
    UIGraphicsEndImageContext();
                  
    return newImage1;
}
              
              

#pragma mark- Instagram
- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller canPerformAction:(SEL)action
{
    //    NSLog(@"5dsklfjkljas");
    return YES;
}

- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller performAction:(SEL)action
{
    //    NSLog(@"dsfa");
    return YES;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    //    NSLog(@"fsafasd;");
}
-(void)shareOnInstagram
{
    [self callFrameSet];
    
    [self storeimage];
    
    if (imageView.image)
    {
        self.instagram = [[Instagram alloc] initWithClientId:APP_ID delegate:nil];
        
        self.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
        self.instagram.sessionDelegate = self;
        if ([self.instagram isSessionValid]) {
        } else {
            [self.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
        }
        
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://camera"];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        {
            CGRect rect = CGRectMake(0 ,0 , 612, 612);
            NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tattoo.ig"];
            
            NSURL *igImageHookFile = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"file://%@", jpgPath]];
            self.documentInteractionController.UTI = @"com.instagram.photo";
            self.documentInteractionController.delegate=self;
            self.documentInteractionController = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
            self.documentInteractionController=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
            self.documentInteractionController.delegate=self;
            [self.documentInteractionController presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
            //        //  [[UIApplication sharedApplication] openURL:instagramURL];
        }
        else
        {
            //   NSLog(@"instagramImageShare");
            UIAlertView *errorToShare = [[UIAlertView alloc] initWithTitle:@"Instagram unavailable " message:@"You need to install Instagram in your device in order to share this image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            errorToShare.tag=3010;
            [errorToShare show];
        }

    }
    else
    {
        UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Facebook " message:@"Select photo to Upload"
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        
        [alertView show];
    }
    
}

// YOU NEED TO CAPTURE igAPPID:// schema
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.instagram handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.instagram handleOpenURL:url];
}

#pragma - IGSessionDelegate

-(void)igDidLogin {
    NSLog(@"Instagram did login : %@",self.instagram.accessToken);
    // here i can store accessToken
    
    [[NSUserDefaults standardUserDefaults] setObject:self.instagram.accessToken forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)igDidNotLogin:(BOOL)cancelled {
    NSLog(@"Instagram did not login");
    NSString* message = nil;
    if (cancelled) {
        message = @"Access cancelled!";
    } else {
        message = @"Access denied!";
    }
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)igDidLogout {
    NSLog(@"Instagram did logout");
    // remove the accessToken
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)igSessionInvalidated {
    NSLog(@"Instagram session was invalidated");
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //resume add view
    
   // [self.adView resumeAdAutoRefresh];
    
    NSLog(@"fb counter is %d",fbFriendCounter);
    
    if(fbFriendCounter==1)
    {
        UIAlertView  *alertView = [[[UIAlertView alloc] initWithTitle:@"Tatt Dat App" message:@"Successfully Post "
                                                             delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        
        [alertView show];
        fbFriendCounter=0;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    viewForUploadPicker=[[UIView alloc]init];
    
    viewForUploadPicker.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.9];
    UILabel *lblTitle=[[UILabel alloc]init];
    lblTitle.text=@"Tatt dat app";
    lblTitle.backgroundColor=[UIColor clearColor];
    lblTitle.textColor=[UIColor whiteColor];
    
    
    UIButton *btnFacebook=[UIButton buttonWithType:UIButtonTypeCustom];    
    [btnFacebook setImage:[UIImage imageNamed:@"ShareFB.png"] forState:UIControlStateNormal];
    [btnFacebook addTarget:self action:@selector(postImageOnFacebookWall) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnTwitter=[UIButton buttonWithType:UIButtonTypeCustom];    
    [btnTwitter setImage:[UIImage imageNamed:@"ShareTwitter.png"] forState:UIControlStateNormal];
    [btnTwitter addTarget:self action:@selector(postImageOnTweeterWall) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnInstagram=[UIButton buttonWithType:UIButtonTypeCustom];    
    [btnInstagram setImage:[UIImage imageNamed:@"ShareInstagram.png"] forState:UIControlStateNormal];
    [btnInstagram addTarget:self action:@selector(shareOnInstagram) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btnCancel setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
    
    
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        viewForUploadPicker.frame=CGRectMake(0, 1024, 768, 320);
        lblTitle.frame=CGRectMake(350, 0, 200, 30);
        btnFacebook.frame=CGRectMake(300, 30, 195, 65);
        btnTwitter.frame=CGRectMake(300, 100, 200, 65);
        btnInstagram.frame=CGRectMake(300, 170, 200, 65);
        btnCancel.frame=CGRectMake(300, 240, 200, 65);
                
        NSLog(@"ipad");
        [self setiPadDesign];
     
    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            viewForUploadPicker.frame=CGRectMake(0, 480, 320, 320);
            lblTitle.frame=CGRectMake(120, 0, 200, 30);
            btnFacebook.frame=CGRectMake(70, 30, 195, 65);
            btnTwitter.frame=CGRectMake(70, 100, 200, 65);
            btnInstagram.frame=CGRectMake(70, 170, 200, 65);
            btnCancel.frame=CGRectMake(70, 240, 200, 65);
            NSLog(@"Iphone");
            [self setPDesign];
        }
        else{
            viewForUploadPicker.frame=CGRectMake(0, 568, 320, 320);
            lblTitle.frame=CGRectMake(120, 0, 200, 30);
            btnFacebook.frame=CGRectMake(70, 30, 195, 65);
            btnTwitter.frame=CGRectMake(70, 100, 200, 65);
            btnInstagram.frame=CGRectMake(70, 170, 200, 65);
            btnCancel.frame=CGRectMake(70, 240, 200, 65);
            [self iPhone5Design];
        }
        
    }
    
    
#endif
    
    /**********************************************************************************/
    
    transOrig = scrollTattoo.transform;
    
    scrollTattoo.transform = transOrig;
    
    self.imageViewTatoo.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)]autorelease];
    [self.imageViewTatoo addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)]autorelease];
    [imageViewTatoo addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)]autorelease];
    [self.imageViewTatoo addGestureRecognizer:rotationRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)]autorelease];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.imageViewTatoo addGestureRecognizer:tapRecognizer];
    
    [viewForUploadPicker addSubview:lblTitle];
    [viewForUploadPicker addSubview:btnFacebook];
    [viewForUploadPicker addSubview:btnTwitter];
    [viewForUploadPicker addSubview:btnInstagram];
    [viewForUploadPicker addSubview:btnCancel];
    
    [self.view addSubview:viewForUploadPicker];
    // Do any additional setup after loading the view from its nib.
   // self.adView.delegate=self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // [self.adView pauseAdAutoRefresh];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)cancelView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        [UIView beginAnimations:@"Start" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        viewForUploadPicker.frame=CGRectMake(0, 1024, 768, 320);
        [UIView commitAnimations];        
    }
    else
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 568, 320, 320);
            [UIView commitAnimations];
        }
        else{
            [UIView beginAnimations:@"Start" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            viewForUploadPicker.frame=CGRectMake(0, 568, 320, 320);
            [UIView commitAnimations];
        }
        
    }
}
#pragma mark -
#pragma mark MobclixAdViewDelegate Methods

- (void)adViewDidFinishLoad:(MobclixAdView*)adView {
	NSLog(@"Ad Loaded: %@.", NSStringFromCGSize(self.adView.frame.size));
}

- (void)adView:(MobclixAdView*)adView didFailLoadWithError:(NSError*)error {
	NSLog(@"Ad Failed: %@. %@", NSStringFromCGSize(self.adView.frame.size), error);
}

- (void)adViewWillTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Will Touch Through: %@.", NSStringFromCGSize(self.adView.frame.size));
}

- (void)adViewDidFinishTouchThrough:(MobclixAdView*)adView {
	NSLog(@"Ad Did Finish Touch Through: %@.", NSStringFromCGSize(self.adView.frame.size));
}

-(void)arrangeButton
{
    if(highlitedButton==1)
    {
//        UIImage *buttonImage = [UIImage imageNamed:@"tattoo-hover.png"];
//        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
//       
//        buttonImage=[UIImage imageNamed:@"effect-up.png"];
//        [effectButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"mail-up.png"];
//        [emailButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"upload-up.png"];
//        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
        UIImage *buttonImage = [UIImage imageNamed:@"tatto-sel.png"];
        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"effect.png"];
        [effectButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"mail11.png"];
        [emailButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"upload.png"];
        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
    }
    else if(highlitedButton==2)
    {
//        UIImage *buttonImage = [UIImage imageNamed:@"tattoo-up.png"];
//        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"effect-hover.png"];
//        [effectButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"mail-up.png"];
//        [emailButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"upload-up.png"];
//        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
        UIImage *buttonImage = [UIImage imageNamed:@"tatto-effect.png"];
        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"effect-sel.png"];
        [effectButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"mail11.png"];
        [emailButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"upload.png"];
        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
    }
    else if(highlitedButton==3)
    {
//        UIImage *buttonImage = [UIImage imageNamed:@"tattoo-up.png"];
//        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"effect-up.png"];
//        [effectButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"mail-hover.png"];
//        [emailButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"upload-up.png"];
//        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
        UIImage *buttonImage = [UIImage imageNamed:@"tatto-effect.png"];
        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"effect.png"];
        [effectButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"mail11-sel.png"];
        [emailButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"upload.png"];
        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
    }
    else if(highlitedButton==4)
    {
//        UIImage *buttonImage = [UIImage imageNamed:@"tattoo-up.png"];
//        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"effect-up.png"];
//        [effectButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"mail-up.png"];
//        [emailButton setImage:buttonImage forState:UIControlStateNormal];
//        
//        buttonImage=[UIImage imageNamed:@"upload-hover.png"];
//        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
        UIImage *buttonImage = [UIImage imageNamed:@"tatto-effect.png"];
        [tattooButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"effect.png"];
        [effectButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"mail11.png"];
        [emailButton setImage:buttonImage forState:UIControlStateNormal];
        
        buttonImage=[UIImage imageNamed:@"upload-sel.png"];
        [uploadButton setImage:buttonImage forState:UIControlStateNormal];
    }
}

//////////////////////// FOR PHOTO LIBRARY ADDING FOLDER
- (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        // ios5.0 has bug when access to asset or UIImagePicker(ios 5.1 fixed)
        // wrap with try/catch and library is nil then pred = 0 to rerun dispatch_once
        // reference : https://devforums.apple.com/message/568023#568023
        // reference : http://stackoverflow.com/questions/7701578/app-crashes-when-trying-to-obtain-photos-from-photo-library-via-image-picker
        @try
        {
            library = [[ALAssetsLibrary alloc] init];
        }
        @catch (NSException *e)
        {
            //LOG_OBJECT(e);
        }
        
    });
    
    if (!library)
    {
        pred = 0;
    }
    return library;
}


-(void)checkFolder
{
    IFNNotificationDisplay *display = [[IFNNotificationDisplay alloc] init];
    display.type = NotificationDisplayTypeLoading;
    display.tag = NOTIFICATION_DISPLAY_TAG;
    [display setNotificationText:@"Please Wait..."];
    [display displayInView:self.view atCenter:CGPointMake(self.view.center.x, self.view.center.y-50.0) withInterval:0.0];
    
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];
    
    [al  enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         NSString *getStr = [NSString stringWithFormat:@"%@",group];
         [arrayCheck addObject:getStr];
         NSString *str = @"ALAssetsGroup - Name:MyFolder";
         for (int i=0; i<[arrayCheck count]; i++) {
             NSArray *components = [[arrayCheck objectAtIndex:i] componentsSeparatedByString:@","];
             NSString *str1 = [components objectAtIndex:0];
             if ([str1 isEqualToString:str]) {
                 check = YES;
             }
         }
     }failureBlock:^(NSError *error){}] ;
    
    
    ////
    
    ALAssetsLibrary *all = [[ALAssetsLibrary alloc] init];
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    [all enumerateGroupsWithTypes:ALAssetsGroupAll
     
                      usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
          {
              if (asset)
              {
                  NSLog(@"%@",asset);
                  
                  NSLog(@".. do something with the asset");
              }
          }
          ];
     }
     
                    failureBlock:^(NSError *error)
     {
         // User did not allow access to library
         // .. handle error 
     }
     ] ;
    
    
      /////
    [self performSelector:@selector(checkCondition) withObject:nil afterDelay:1.0f];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self savePhoto];
    }
}

-(void)checkCondition
{
	UIView *dv = [self.view viewWithTag:NOTIFICATION_DISPLAY_TAG];
	[dv removeFromSuperview];
    if (check == NO) {
        
        
        //if([[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
            [self savePhoto];
        //}
        
        //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logged_in"];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Same Folder already exist" message:@"Do you wish to continue" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
       
    }
}
-(void)savePhoto
{
    self.library = [[ALAssetsLibrary alloc] init];
    [self.library addAssetsGroupAlbumWithName:@"Tattoos" resultBlock:nil failureBlock:nil];
    // [self performSelector:@selector(savePhoto1) withObject:nil afterDelay:1.0f];
    [self savePhoto1];
}
-(void)savePhoto1
{
//    [self savePhotoFinal:[UIImage imageNamed:@"tattoo1.jpg"]];    
//    // [NSThread sleepForTimeInterval:2.0];
//    [self savePhotoFinal:[UIImage imageNamed:@"tattoo2.jpg"]];
//    // [NSThread sleepForTimeInterval:2.0];
//    [self savePhotoFinal:[UIImage imageNamed:@"tattoo3.jpg"]];
//    // [NSThread sleepForTimeInterval:2.0];
//    [self savePhotoFinal:[UIImage imageNamed:@"tattoo4.jpg"]];
    
    for (int i=101; i<=366; i++) {
        [self savePhotoFinal:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
}

-(void)savePhotoFinal:(UIImage *)image
{
    [self.library saveImage:image toAlbum:@"Tattoos" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
}


/////////////////////

/////////////////////
-(void)iPhone5Design
{
    self.title = @"";
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ( ![userDefaults valueForKey:@"version"] )
    {
        // CALL your Function;
        
        [self checkFolder];
        
        
        // Adding version number to NSUserDefaults for first version:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:@"version"] == [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] )
    {
        /// Same Version so dont run the function
        // lblNS.text=@"FALSE";
    }
    else
    {
        // Call Your Function;
        
        
        [self checkFolder];
        
        // Update version number to NSUserDefaults for other versions:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    
    
    
    /////for add photo in library
    
    check = NO;
    [arrayCheck removeAllObjects];
    arrayCheck = [[NSMutableArray alloc] init];
    
    //Boolean a=[[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"];
    
    
    
    // highlitedButton=1;
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
	activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
	activityIndicator.center = self.view.center;
	[self.view addSubview: activityIndicator];
    
    
    
    [self arrangeButton];
    
    
    self.view.backgroundColor=[UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190, 200)];
    imgBack.image=[UIImage imageNamed:@"DoubleTap.png"];
    
    
    CGRect frame1 =CGRectMake(15,12,165,178);
    
    //  CGRect frame2 = CGRectMake(50,50,200,200);
    
    imageView=[[UIImageView alloc]initWithFrame:frame1];
       
    
//    imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_brd.png"]];
    
//    imageView.contentMode = UIViewContentModeCenter;
    
    
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 190, 200)];
    
    scroll.backgroundColor=[UIColor blackColor];
    
    [scroll addSubview:imgBack];
    [scroll addSubview:imageView];
    
    backView=[[UIView alloc]initWithFrame:frame1];
    backView.backgroundColor=[UIColor greenColor];
    
    
    
    [backView addSubview:scroll];
    [self.view addSubview:backView];
   
    
    scroll.contentSize = CGSizeMake(200, 200);
    scroll.minimumZoomScale = 1.0;
    scroll.maximumZoomScale = 1.5;
    
    
    
    [self centerScrollViewContents];
    
    scroll.scrollEnabled=NO;
    scroll.directionalLockEnabled = YES;
    scroll.bounces=NO;
    
    
    
    imageViewTatoo=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,100)];
    
    //  imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageViewTatoo.contentMode=UIViewContentModeScaleAspectFit;
    
    
    /*******************************************************************************************/
    
    CGRect frame4 = CGRectMake(210,50,100,100);
    scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
    //scrollTattoo.contentSize = CGSizeMake(150, 150);
    scrollTattoo.showsHorizontalScrollIndicator = NO;
    scrollTattoo.showsVerticalScrollIndicator = NO;
    
    imageViewTatoo.frame = CGRectMake(0,0,100,100);///////change by me
    [scrollTattoo addSubview:imageViewTatoo];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    scrollTattoo.minimumZoomScale = 1.0;
    scrollTattoo.maximumZoomScale = 1.5;
    scrollTattoo.delegate=self;
    
    ssheight=scrollTattoo.frame.size.height;
    sswidth=scrollTattoo.frame.size.width;
    
    
    [self.view addSubview:scrollTattoo];
    
    
    
    
}


-(void)setPDesign
{
    self.title = @"";
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ( ![userDefaults valueForKey:@"version"] )
    {
        // CALL your Function;
        
        [self checkFolder];
        
        
        // Adding version number to NSUserDefaults for first version:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:@"version"] == [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] )
    {
        /// Same Version so dont run the function
        // lblNS.text=@"FALSE";
    }
    else
    {
        // Call Your Function;
        
        
        [self checkFolder];
        
        // Update version number to NSUserDefaults for other versions:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    

    
    /////for add photo in library
    
    check = NO;
    [arrayCheck removeAllObjects];
    arrayCheck = [[NSMutableArray alloc] init];
    
    //Boolean a=[[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"];
    
        
    
    // highlitedButton=1;
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
	activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
	activityIndicator.center = self.view.center;
	[self.view addSubview: activityIndicator];
    
    
    
    [self arrangeButton];
    
    
    self.view.backgroundColor=[UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame1 = CGRectMake(15,12,165,178);
    
  //  CGRect frame2 = CGRectMake(50,50,200,200);
    
    UIImageView *imgBack=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190, 200)];
    imgBack.image=[UIImage imageNamed:@"DoubleTap.png"];
    
    
    
    imageView=[[UIImageView alloc]initWithFrame:frame1];
       
//    imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_brd.png"]];
    
//    imageView.contentMode = UIViewContentModeCenter;
    
    
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 190, 200)];
    
    scroll.backgroundColor=[UIColor blackColor];
    
    [scroll addSubview:imgBack];
    [scroll addSubview:imageView];
    
    backView=[[UIView alloc]initWithFrame:frame1];
    backView.backgroundColor=[UIColor greenColor];
    
    
    
    [backView addSubview:scroll];
    [self.view addSubview:backView];
    
    
    
    
    
    
    scroll.contentSize = CGSizeMake(200, 200);
    scroll.minimumZoomScale = 1.0;
    scroll.maximumZoomScale = 1.5;
    
    
    
    [self centerScrollViewContents];
    
    scroll.scrollEnabled=NO;
    scroll.directionalLockEnabled = YES;
    scroll.bounces=NO;
    
    
    
    imageViewTatoo=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,100)];
    
    //  imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageViewTatoo.contentMode=UIViewContentModeScaleAspectFit;
    
    
    /*******************************************************************************************/
    
    CGRect frame4 = CGRectMake(210,50,100,100);
    scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
    //scrollTattoo.contentSize = CGSizeMake(150, 150);
    scrollTattoo.showsHorizontalScrollIndicator = NO;
    scrollTattoo.showsVerticalScrollIndicator = NO;
    
    imageViewTatoo.frame = CGRectMake(0,0,100,100);///////change by me
    [scrollTattoo addSubview:imageViewTatoo];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    scrollTattoo.minimumZoomScale = 1.0;
    scrollTattoo.maximumZoomScale = 1.5;
    scrollTattoo.delegate=self;
    
    ssheight=scrollTattoo.frame.size.height;
    sswidth=scrollTattoo.frame.size.width;
    
    
    [self.view addSubview:scrollTattoo];
    
    
   
      
}

-(void)setiPadDesign
{
    self.title = @"";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ( ![userDefaults valueForKey:@"version"] )
    {
        // CALL your Function;
        
        [self checkFolder];
        
        
        // Adding version number to NSUserDefaults for first version:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:@"version"] == [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] )
    {
        /// Same Version so dont run the function
        // lblNS.text=@"FALSE";
    }
    else
    {
        // Call Your Function;
        
        
        [self checkFolder];
        
        // Update version number to NSUserDefaults for other versions:
        [userDefaults setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    }
    

    
    /////for add photo in library
    
    check = NO;
    [arrayCheck removeAllObjects];
    arrayCheck = [[NSMutableArray alloc] init];
    //[self checkFolder];
    
    
    
    // highlitedButton=1;
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge ];
	activityIndicator.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
	activityIndicator.center = self.view.center;
	[self.view addSubview: activityIndicator];
    
    
    
    [self arrangeButton];
    
    
    self.view.backgroundColor=[UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame1 = CGRectMake(15, 12, 265, 278);
    
  //  CGRect frame2 = CGRectMake(50,50,200,200);
    
    imageView=[[UIImageView alloc]initWithFrame:frame1];
    
    
    UIImageView *imgBack=[[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 300, 300)];
    imgBack.image=[UIImage imageNamed:@"DoubleTap.png"];
    
    
//    imageView.backgroundColor=[UIColor lightGrayColor];
    
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 500, 600)];
    scroll.backgroundColor=[UIColor blackColor];
    
    [scroll addSubview:imgBack];
    [scroll addSubview:imageView];
    
    backView=[[UIView alloc]initWithFrame:frame1];
    backView.backgroundColor=[UIColor greenColor];
    
    
    
    [backView addSubview:scroll];
    [self.view addSubview:backView];
    
    
    
    
    
    
    scroll.contentSize = CGSizeMake(200, 200);
    scroll.minimumZoomScale = 1.0;
    scroll.maximumZoomScale = 1.5;
    
    
    
    [self centerScrollViewContents];
    
    scroll.scrollEnabled=NO;
    scroll.directionalLockEnabled = YES;
    scroll.bounces=NO;
    
    
    
    imageViewTatoo=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,100)];
    
    //  imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageViewTatoo.contentMode=UIViewContentModeScaleAspectFill;
    
    
    /*******************************************************************************************/
    
    CGRect frame4 = CGRectMake(540,250,200,200);
    scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
    //scrollTattoo.contentSize = CGSizeMake(150, 150);
    scrollTattoo.showsHorizontalScrollIndicator = NO;
    scrollTattoo.showsVerticalScrollIndicator = NO;
    
    imageViewTatoo.frame = CGRectMake(0,0,200,200);///////change by me
    [scrollTattoo addSubview:imageViewTatoo];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    scrollTattoo.minimumZoomScale = 1.0;
    scrollTattoo.maximumZoomScale = 1.5;
    scrollTattoo.delegate=self;
    
    ssheight=scrollTattoo.frame.size.height;
    sswidth=scrollTattoo.frame.size.width;
    
    
    [self.view addSubview:scrollTattoo];
    
    
}
//////////////////////

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
   // NSLog(@"delegate method called");
//    CGSize scrollableSize = CGSizeMake(0, 0);
//    [scroll setContentSize:scrollableSize];
  //  [self centerScrollViewContents];
    NSLog(@"hiiiiiiiiiiiiiiii");
    return self.imageView;
    //return [scrollView childView];
    
}

- (void)scrollViewDidEndZooming:(UIScrollView *)aScrollView withView:(UIView *)view atScale:(float)aScale{
    NSLog(@"zoomed");
    
   // scroll.userInteractionEnabled = NO;
   // scroll.scrollEnabled=YES;
  //  [self centerScrollViewContents];
    
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"i am here");
    imageView.center=CGPointMake(CGRectGetMidX(scroll.bounds), CGRectGetMidY(scroll.bounds));
}
/*************************************************************************************************/

//ADDING EFFECTS ON IMAGES


- (void)displayEditorForImage:(UIImage *)imageToEdit
{
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    [self presentModalViewController:editorController animated:YES];
}



- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here
      NSLog(@"i am here in photoEditor");
    
    //Save image in photo library
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    if(effectCounter)
    {
        imageView.image=image;
    }
    else{
        imageViewTatoo.image=image;
    }
    //Dismis the present controller
    [self dismissModalViewControllerAnimated:YES];
    
      
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Handle cancelation here
    [self dismissModalViewControllerAnimated:YES];
}




//IMage drag
/**************************************************************************************************/

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{

    if(imageView.image)
    {
        
        
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            
        {
            
            
            
            NSLog(@"ipad");
            CGPoint translation = [panRecognizer translationInView:self.view];
            // CGPoint translation=[panRecognizer translationInView:imageView];
            
            // NSLog(@"here i am ...Image height is %f and its width is %f",imageView.image.size.height, imageView.image.size.width);
            
            CGPoint tattooPosition = scrollTattoo.center;
            tattooPosition.x += translation.x;
            tattooPosition.y += translation.y;
            
            // CGSize viewSize = scrollTattoo.frame.size;
            
            [imageViewTatoo setAlpha:0.3];
            
            
            //   CGPoint viewPosition = scrollTattoo.frame.origin;
            //   float firstX=viewPosition.x;
            //   float firstY=viewPosition.y;
            
            // NSLog(@"firstX = %f and firstY = %f",firstX,firstY);
            
            
            //   x=firstX;
            //   y=firstY;
            
            
            x=tattooPosition.x-60;
            y=tattooPosition.y-85;
            
            
            scrollTattoo.center = tattooPosition;
            [panRecognizer setTranslation:CGPointZero inView:self.view];
        }
        else
        {
            NSLog(@"Iphone");
            CGPoint translation = [panRecognizer translationInView:self.view];
            // CGPoint translation=[panRecognizer translationInView:imageView];
            
            // NSLog(@"here i am ...Image height is %f and its width is %f",imageView.image.size.height, imageView.image.size.width);
            
            CGPoint tattooPosition = scrollTattoo.center;
            tattooPosition.x += translation.x;
            tattooPosition.y += translation.y;
            
            // CGSize viewSize = scrollTattoo.frame.size;
            
            [imageViewTatoo setAlpha:0.3];
            
            
            //   CGPoint viewPosition = scrollTattoo.frame.origin;
            //   float firstX=viewPosition.x;
            //   float firstY=viewPosition.y;
            
            // NSLog(@"firstX = %f and firstY = %f",firstX,firstY);
            
            
            //   x=firstX;
            //   y=firstY;
            
            
            x=tattooPosition.x;
            y=tattooPosition.y;
            
            
            scrollTattoo.center = tattooPosition;
            [panRecognizer setTranslation:CGPointZero inView:self.view];
        }

            
    }
        
        
#endif
    
  }
//UIScrollView
- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    
    NSLog(@"pinchDetected");
    
        //imageViewTatoo.frame=scrollTattoo.frame;
   // self.imageViewTatoo.transform = CGAffineTransformScale(self.imageViewTatoo.transform, scale, scale);
    //imageViewTatoo.transform=CGAffineTransformScale(scrollTattoo.transform, 1.0, 1.0);
    
    
    scrollTattoo.transform=CGAffineTransformScale(scrollTattoo.transform,scale, scale);
    //[scrollTattoo automaticContentOffsetAdjustmentDisabled];
    
    
   
    
//    CGFloat delta = scrollTattoo.frame.size.height/2 - imageViewTatoo.frame.size.height/2;
//    scrollTattoo.contentInset = UIEdgeInsetsMake(delta, 0, delta, 0);
    //scrollTattoo.contentInset = UIEdgeInsetsZero;
    //scrollTattoo.isZoomBouncing=NO;
     imageViewTatoo.center=CGPointMake(CGRectGetMidX(scrollTattoo.bounds), CGRectGetMidY(scrollTattoo.bounds));
    scrollTattoo.contentMode=UIViewContentModeScaleAspectFit;
    imageViewTatoo.contentMode= UIViewContentModeScaleAspectFit;

    pinchRecognizer.scale = 1.0;
    
   
}

- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
  /*  CGFloat angle = rotationRecognizer.rotation;
    self.imageViewTatoo.transform = CGAffineTransformRotate(self.imageViewTatoo.transform, angle);
    rotationRecognizer.rotation = 0.0;
   */
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        NSLog(@"ipad");
        [self forIpadTattoPosition];
    }
    else
    {
        NSLog(@"Iphone");
        [self forIphoneTattoPosition];
        
    }
    
    
#endif
    
}


-(void)forIphoneTattoPosition
{
    CGPoint vPosition = scrollTattoo.frame.origin;
    float firstX=vPosition.x;
    float firstY=vPosition.y;
    NSLog(@"double tap");
    
    // scroll.userInteractionEnabled = NO;
    /***********/
    ///////////////////////                                        For saving image
    //  NSLog(@"zoomscale=%f", scroll.zoomScale);
    
    
    NSLog(@"tattoo zoom scale %f",scrollTattoo.zoomScale);
    
    
    float sHeight=scrollTattoo.frame.size.height;
    float sWidth=scrollTattoo.frame.size.width;
    
    if(ssheight==sHeight && sswidth==sWidth)
    {
        if(scroll.zoomScale>1.0 )
        {
            if(scroll.zoomScale!=1.5)
            {
                scroll.zoomScale=1.5;
            }
            CGRect visibleRect;
            
            float scale = 1.0f/scroll.zoomScale;
            
            NSLog(@"zoomscale is %f and scale is %f",scroll.zoomScale , scale);
            
            visibleRect.origin.x = scroll.contentOffset.x * scale;
            visibleRect.origin.y = scroll.contentOffset.y * scale;
            visibleRect.size.width = scroll.bounds.size.width * scale;
            visibleRect.size.height = scroll.bounds.size.height * scale;
            
            
            //[self centerScrollViewContents];
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            // [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            
            
            [imageViewTatoo.image drawInRect:CGRectMake((firstX*scale)+10,(firstY*scale)+10,100,100) blendMode:kCGBlendModeDarken alpha:0.4];
            
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            // scroll.zoomScale=1.000000;
            
            // [self centerScrollViewContents];
        }
        else
        {
            
            
            scroll.zoomScale=1.000000;
            
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageViewTatoo.image drawInRect:CGRectMake((x-60),(y-60),100,100) blendMode:kCGBlendModeDarken alpha:0.4];
            
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            
            
            
        }
    }
    else{
        
        if(scroll.zoomScale>1.0 )
        {
            if(scroll.zoomScale!=1.5)
            {
                scroll.zoomScale=1.5;
            }
            CGRect visibleRect;
            
            float scale = 1.0f/scroll.zoomScale;
            
            NSLog(@"zoomscale is %f and scale is %f",scroll.zoomScale , scale);
            
            visibleRect.origin.x = scroll.contentOffset.x * scale;
            visibleRect.origin.y = scroll.contentOffset.y * scale;
            visibleRect.size.width = scroll.bounds.size.width * scale;
            visibleRect.size.height = scroll.bounds.size.height * scale;
            
            
            
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            
            
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            
            
            CGPoint tattooPosition = scrollTattoo.frame.origin;
            x = tattooPosition.x;
            y = tattooPosition.y;
            NSLog(@"%f   %f",x,y);
            
            // x=x*s;
            // y=y*s;
            
            NSLog(@"%f   %f",x*scroll.zoomScale,y*scroll.zoomScale);
            
            x=x*scroll.zoomScale;
            y=y*scroll.zoomScale;
            if(x<1 || y<1)
            {
                //  x=x*-scroll.zoomScale;
                //  y=y*-scroll.zoomScale;
            }
            else
            {
                
            }
            
            
            [imageViewTatoo.image drawInRect:CGRectMake((firstX*scale)+10,(firstY*scale)+10,scrollTattoo.frame.size.width-30,scrollTattoo.frame.size.height-30) blendMode:kCGBlendModeDarken alpha:0.4];
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.image= fullScreenshot;
            
            
        }
        else
        {
            
            ////////////////////                                        end here
            
            
            scroll.zoomScale=1.000000;
            //[self centerScrollViewContents];
            CGSize newSize = CGSizeMake(190, 190);
            
            
            
            // CGSize newSizeTattoo = CGSizeMake(tI, 190);
            
            UIGraphicsBeginImageContext( newSize );
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            
            UIImage *tImage =[self resizeImage:(UIImage*)imageViewTatoo.image newSize:scrollTattoo.frame.size];
            
            
            
            NSString *transStr= NSStringFromCGAffineTransform(scrollTattoo.transform);
            
            
            
            CGPoint tattooPosition = scrollTattoo.frame.origin;
            x = tattooPosition.x;
            y = tattooPosition.y;
            
            
            
            float s=[[transStr substringWithRange:NSMakeRange(1, 7)] floatValue];
            
            NSLog(@"%f",s);
            
            
            NSLog(@"%f   %f",(imageViewTatoo.frame.size.width),(imageViewTatoo.frame.size.height));
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            NSLog(@"%f   %f",(tImage.size.width),(tImage.size.height));
            
            
            NSLog(@"%f   %f",imageViewTatoo.image.size.height,imageViewTatoo.image.size.width);
            
            
            //float scale = 1.0f/s;
            
            
            
            
            if(ssheight < sHeight || sswidth < sWidth)
            {
                [imageViewTatoo.image drawInRect:CGRectMake(x-5,y+5,scrollTattoo.frame.size.width-10,scrollTattoo.frame.size.height-30) blendMode:kCGBlendModeDarken alpha:0.4];
                
                
            }
            else
            {
                [imageViewTatoo.image drawInRect:CGRectMake(x-10,y-5,scrollTattoo.frame.size.width,scrollTattoo.frame.size.height-20) blendMode:kCGBlendModeDarken alpha:0.4];
                
            }
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            // imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            
            
        }
        
        
    }
    
    
    
    
    /********************/
    
    
    CGPoint viewPosition = scroll.frame.origin;
    
    // int widthImage=imageView.image.size.width;
    // int heightImage=imageView.image.size.height;
    
    int width=scroll.frame.size.width;
    
    int height=scroll.frame.size.width;
    
    int newX=viewPosition.x;
    int newY=viewPosition.y;
    
    
    // NSLog(@"newX is = %d and newY is = %d",newX,newY);
    // NSLog(@"width is = %d and height is = %d",width,height);
    
    //  NSLog(@"value of x is %f and volue of y is %f",x,y);
    
    if(!imageView.image)
    {
        if(x>newX-20 && x<newX+width && y>newY-20 &&y<newY+height-50)
        {
            //CGSize newSize = CGSizeMake(widthImage, heightImage);
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            // [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageViewTatoo.image drawInRect:CGRectMake(x-70,y-70,100,100) blendMode:kCGBlendModeDarken alpha:0.4];//(x+20,y-20,100,100)
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            self.imageView.image=newImage;
            //imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            
        }
    }
    else
    {
    }
    
    [scrollTattoo removeFromSuperview];
    
    
    
    CGRect frame4 = CGRectMake(210,50,100,100);
    scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
    scrollTattoo.transform = transOrig;
    //scrollTattoo.contentSize = CGSizeMake(150, 150);
    scrollTattoo.showsHorizontalScrollIndicator = NO;
    scrollTattoo.showsVerticalScrollIndicator = NO;
    
    imageViewTatoo.frame = CGRectMake(0,0,100,100);///////change by me
    [scrollTattoo addSubview:imageViewTatoo];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    scrollTattoo.minimumZoomScale = 1.0;
    scrollTattoo.maximumZoomScale = 1.5;
    scrollTattoo.delegate=self;
    
    ssheight=scrollTattoo.frame.size.height;
    sswidth=scrollTattoo.frame.size.width;
    
    
    [self.view addSubview:scrollTattoo];
    
    
    
    
    [imageViewTatoo setAlpha:0.9];
    
    [viewForUploadPicker removeFromSuperview];
    [self.view addSubview:viewForUploadPicker];

}


-(void)forIpadTattoPosition
{
    CGPoint vPosition = scrollTattoo.frame.origin;
    float firstX=vPosition.x;
    float firstY=vPosition.y;
    NSLog(@"double tap");
    
    // scroll.userInteractionEnabled = NO;
    /***********/
    ///////////////////////                                        For saving image
    //  NSLog(@"zoomscale=%f", scroll.zoomScale);
    
    
    NSLog(@"tattoo zoom scale %f",scrollTattoo.zoomScale);
    
    
    float sHeight=scrollTattoo.frame.size.height;
    float sWidth=scrollTattoo.frame.size.width;
    
    if(ssheight==sHeight && sswidth==sWidth)
    {
        if(scroll.zoomScale>1.0 )
        {
            if(scroll.zoomScale!=1.5)
            {
                scroll.zoomScale=1.5;
            }
            CGRect visibleRect;
            
            float scale = 1.0f/scroll.zoomScale;
            
            NSLog(@"zoomscale is %f and scale is %f",scroll.zoomScale , scale);
            
            visibleRect.origin.x = scroll.contentOffset.x * scale;
            visibleRect.origin.y = scroll.contentOffset.y * scale;
            visibleRect.size.width = scroll.bounds.size.width * scale;
            visibleRect.size.height = scroll.bounds.size.height * scale;
            
            
            //[self centerScrollViewContents];
            CGSize newSize = CGSizeMake(500, 600);
            UIGraphicsBeginImageContext( newSize );
            
            // [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            
            
            [imageViewTatoo.image drawInRect:CGRectMake((firstX*scale)+10,(firstY*scale)+10,200,200) blendMode:kCGBlendModeDarken alpha:0.4];
            
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            // scroll.zoomScale=1.000000;
            
            // [self centerScrollViewContents];
        }
        else
        {
            
            
            scroll.zoomScale=1.000000;
            
            CGSize newSize = CGSizeMake(500, 600);
            UIGraphicsBeginImageContext( newSize );
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageViewTatoo.image drawInRect:CGRectMake((x-60),(y-60),200,200) blendMode:kCGBlendModeDarken alpha:0.4];
            
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            
            
            
        }
    }
    else{
        
        if(scroll.zoomScale>1.0 )
        {
            if(scroll.zoomScale!=1.5)
            {
                scroll.zoomScale=1.5;
            }
            CGRect visibleRect;
            
            float scale = 1.0f/scroll.zoomScale;
            
            NSLog(@"zoomscale is %f and scale is %f",scroll.zoomScale , scale);
            
            visibleRect.origin.x = scroll.contentOffset.x * scale;
            visibleRect.origin.y = scroll.contentOffset.y * scale;
            visibleRect.size.width = scroll.bounds.size.width * scale;
            visibleRect.size.height = scroll.bounds.size.height * scale;
            
            
            
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            
            
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            
            
            CGPoint tattooPosition = scrollTattoo.frame.origin;
            x = tattooPosition.x;
            y = tattooPosition.y;
            NSLog(@"%f   %f",x,y);
            
            // x=x*s;
            // y=y*s;
            
            NSLog(@"%f   %f",x*scroll.zoomScale,y*scroll.zoomScale);
            
            x=x*scroll.zoomScale;
            y=y*scroll.zoomScale;
            if(x<1 || y<1)
            {
                //  x=x*-scroll.zoomScale;
                //  y=y*-scroll.zoomScale;
            }
            else
            {
                
            }
            
            
            [imageViewTatoo.image drawInRect:CGRectMake((firstX*scale)+10,(firstY*scale)+10,scrollTattoo.frame.size.width-30,scrollTattoo.frame.size.height-30) blendMode:kCGBlendModeDarken alpha:0.4];
            
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            imageView.image= fullScreenshot;
            
            
        }
        else
        {
            
            ////////////////////                                        end here
            
            
            scroll.zoomScale=1.000000;
            //[self centerScrollViewContents];
            CGSize newSize = CGSizeMake(500, 600);
            
            
            
            // CGSize newSizeTattoo = CGSizeMake(tI, 190);
            
            UIGraphicsBeginImageContext( newSize );
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            
            UIImage *tImage =[self resizeImage:(UIImage*)imageViewTatoo.image newSize:scrollTattoo.frame.size];
            
            
            
            NSString *transStr= NSStringFromCGAffineTransform(scrollTattoo.transform);
            
            
            
            CGPoint tattooPosition = scrollTattoo.frame.origin;
            x = tattooPosition.x;
            y = tattooPosition.y;
            
            
            
            float s=[[transStr substringWithRange:NSMakeRange(1, 7)] floatValue];
            
            NSLog(@"%f",s);
            
            
            NSLog(@"%f   %f",(imageViewTatoo.frame.size.width),(imageViewTatoo.frame.size.height));
            NSLog(@"%f   %f",(scrollTattoo.frame.size.width),(scrollTattoo.frame.size.height));
            NSLog(@"%f   %f",(tImage.size.width),(tImage.size.height));
            
            
            NSLog(@"%f   %f",imageViewTatoo.image.size.height,imageViewTatoo.image.size.width);
            
            
            //float scale = 1.0f/s;
            
            
            
            
            if(ssheight < sHeight || sswidth < sWidth)
            {
                [imageViewTatoo.image drawInRect:CGRectMake(x-25,y-25,scrollTattoo.frame.size.width-10,scrollTattoo.frame.size.height-30) blendMode:kCGBlendModeDarken alpha:0.4];
                
                
            }
            else
            {
                [imageViewTatoo.image drawInRect:CGRectMake(x-20,y-40,scrollTattoo.frame.size.width,scrollTattoo.frame.size.height-20) blendMode:kCGBlendModeDarken alpha:0.4];
                
            }
            UIImage *fullScreenshot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            
            // imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            imageView.image= fullScreenshot;
            
            
            
        }
        
        
    }
    
    
    
    
    /********************/
    
    
    CGPoint viewPosition = scroll.frame.origin;
    
    // int widthImage=imageView.image.size.width;
    // int heightImage=imageView.image.size.height;
    
    int width=scroll.frame.size.width;
    
    int height=scroll.frame.size.width;
    
    int newX=viewPosition.x;
    int newY=viewPosition.y;
    
    
    // NSLog(@"newX is = %d and newY is = %d",newX,newY);
    // NSLog(@"width is = %d and height is = %d",width,height);
    
    //  NSLog(@"value of x is %f and volue of y is %f",x,y);
    
    if(!imageView.image)
    {
        if(x>newX-20 && x<newX+width && y>newY-20 &&y<newY+height-50)
        {
            //CGSize newSize = CGSizeMake(widthImage, heightImage);
            CGSize newSize = CGSizeMake(190, 190);
            UIGraphicsBeginImageContext( newSize );
            
            // [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageView.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
            
            [imageViewTatoo.image drawInRect:CGRectMake(x-70,y-70,100,100) blendMode:kCGBlendModeDarken alpha:0.4];//(x+20,y-20,100,100)
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            self.imageView.image=newImage;
            //imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.contentMode =UIViewContentModeScaleAspectFit;
            
            
            
            
        }
    }
    else
    {
    }
    
    [scrollTattoo removeFromSuperview];
    
    /*
     
     
     CGRect frame4 = CGRectMake(540,250,200,200);
     scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
     //scrollTattoo.contentSize = CGSizeMake(150, 150);
     scrollTattoo.showsHorizontalScrollIndicator = NO;
     scrollTattoo.showsVerticalScrollIndicator = NO;
     
     imageViewTatoo.frame = CGRectMake(0,0,200,200);///////change by me
     [scrollTattoo addSubview:imageViewTatoo];
     
     scrollTattoo.backgroundColor=[UIColor blueColor];
     
     scrollTattoo.minimumZoomScale = 1.0;
     scrollTattoo.maximumZoomScale = 1.5;
     scrollTattoo.delegate=self;
     
     ssheight=scrollTattoo.frame.size.height;
     sswidth=scrollTattoo.frame.size.width;

     
     */
    
    CGRect frame4 = CGRectMake(540,250,200,200);
    scrollTattoo = [[UIScrollView alloc] initWithFrame:frame4];
    scrollTattoo.transform = transOrig;
    //scrollTattoo.contentSize = CGSizeMake(150, 150);
    scrollTattoo.showsHorizontalScrollIndicator = NO;
    scrollTattoo.showsVerticalScrollIndicator = NO;
    
    imageViewTatoo.frame = CGRectMake(0,0,200,200);///////change by me
    [scrollTattoo addSubview:imageViewTatoo];
    
    //scrollTattoo.backgroundColor=[UIColor blueColor];
    
    scrollTattoo.minimumZoomScale = 1.0;
    scrollTattoo.maximumZoomScale = 1.5;
    scrollTattoo.delegate=self;
    
    ssheight=scrollTattoo.frame.size.height;
    sswidth=scrollTattoo.frame.size.width;
    
    
    [self.view addSubview:scrollTattoo];
    
    
    
    
    [imageViewTatoo setAlpha:0.9];
    
    
    
}



- (void)centerScrollViewContents {
    
    
    CGSize boundsSize = scroll.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
    
    //scroll.scrollEnabled=NO;
}

- (void)centerScrollViewContentsTattoo {
    
    
    CGSize boundsSize = scrollTattoo.bounds.size;
    CGRect contentsFrame = self.imageViewTatoo.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageViewTatoo.frame = contentsFrame;
    
    //scroll.scrollEnabled=NO;
}


/*************************************************************************************************/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//   self.tphoto=nil;
//    self.tphotoFromLibrary=nil;
//    self.tphotoFromFacebook=nil;
//    self.tphotoFromTwitter=nil;
//    self.tphotoSelf=nil;
//    self.tphotoTatoo=nil;
    
  //  [self.adView cancelAd];
   // self.adView.delegate = nil;
   // self.adView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*************************************************************************************************************************************/

//make the class singlton:-
+(RootViewController*)sharedFirstViewController
{
	@synchronized([RootViewController class])
	{
		if (!_sharedFirstViewController)
			[[self alloc] init];
        
		return _sharedFirstViewController;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([RootViewController class])
	{
		NSAssert(_sharedFirstViewController == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedFirstViewController = [super alloc];
		return _sharedFirstViewController;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
    
	return self;
}

////Resizing image

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
