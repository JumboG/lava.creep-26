//  Tatt Dat App
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>
#import "ImageMove.h"

@interface ImageBase : UIViewController
{
    UIImageView *imageViewBase;
    UIImageView *imageViewTatooBase;
    UILabel *label;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageViewBase;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTatooBase;
@property(strong,nonatomic)IBOutlet UILabel *label;


@end
