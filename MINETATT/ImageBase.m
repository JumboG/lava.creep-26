//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.
//

#import "ImageBase.h"
#import "RootViewController.h"

@implementation ImageBase
@synthesize imageViewBase,imageViewTatooBase;
@synthesize label;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
   // NSString * imageName = [NSString stringWithFormat:@"%@.png","photo2"];
	//[self.fruitImageView setImage:[UIImage imageNamed:imageName]];
    
    ///try  UIImage *small = [UIImage imageWithCGImage:original.CGImage scale:0.25 orientation:original.imageOrientation];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
        
    self.label.text=@"Image effect label";
    
    
  /*  
    ImageMove* imageMove = [[ImageMove alloc] initWithImage:[UIImage imageNamed:@"photo2.jpg"]];
    
    [imageMove setFrame:CGRectMake(110, 60, [imageMove frame].size.width,[imageMove frame].size.height)];
    [[self view] addSubview:imageMove];
   // [imageMove release];
    
    
    ImageMove* imageMove1 = [[ImageMove alloc] initWithImage:[UIImage imageNamed:@"photo3.jpg"]];
    [imageMove1 setFrame:CGRectMake(110, 200, [imageMove1 frame].size.width,[imageMove1 frame].size.height)];
    [[self view] addSubview:imageMove1];
   // [imageMove1 release];
   
   */
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
