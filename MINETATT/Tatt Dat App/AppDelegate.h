//  MINETATT
//
//  Created by BAAD Productions, LLC on 7/5/2013.
//  Copyright (c) 2013 BAAD Productions, LLC. All rights reserved.

#import <UIKit/UIKit.h>

#define APP_ID @"fabbe266237e46b98d068e0525b0b49b"

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     UINavigationController *navigationController;
}
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UIWindow *window;

@end
