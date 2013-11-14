//
//  AppDelegate.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SinaWeibo;
@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SinaWeibo *sinaweibo;
@property(nonatomic, retain)MainViewController *mainController;

@end
