//
//  BaseNavigationController.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNofication object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadThemeImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
    
}
- (void)loadThemeImage
{
    
    //-----------判断版本的两种方法---------------------
    
    //-----------第一种判断版本 如果小于5.0 切换方法
    float version = WXHLOSVersion();
    if (version >= 5.0) {
        UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }else{
        //系统会异步的调用drawRect方法
        [self.navigationBar setNeedsDisplay];
    }
    
    //-----------第二种判断这个方法在当前版本是否可用------------
	//if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {;}
}

@end
