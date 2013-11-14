//
//  ThemeButton.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-13.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

//只要添加了通知就必须要移除 否则有崩溃隐患
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName
{
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highlightedImageName = highlightedImageName;
    }
    return self;
    
    
}
- (id)initWithImage:(NSString *)backgroundImageName backgroundHighlightedImageName:(NSString *)backgroundHighlightedImageName
{
    self = [self init];
    if (self) {
        self.backgroundImageName = backgroundImageName;
        self.backgroundHighlightedImageName = backgroundHighlightedImageName;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNofication object:nil];
    }
    return self;
    
}



- (void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
}


- (void)loadThemeImage
{
    //取得图片
    ThemeManager *themeManager = [ThemeManager shareInstance];
    UIImage *image = [themeManager getThemeImage:_imageName];
    UIImage *hightedImage = [themeManager getThemeImage:_highlightedImageName];
    
    //添加相对应的状态和图片
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:hightedImage forState:UIControlStateHighlighted];
    
    UIImage *backgroundImage = [themeManager getThemeImage:_backgroundImageName];
    UIImage *backgroundHighlightedImage = [themeManager getThemeImage:_backgroundHighlightedImageName];
    
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [self setBackgroundImage:backgroundHighlightedImage forState:UIControlStateHighlighted];
}


#pragma mark - setter  设置图片名后，重新加载该图片名对应的图片
- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = [imageName copy];
    }
    //重新加载图片
    [self loadThemeImage];
}

- (void)setHighligtImageName:(NSString *)highligtImageName {
    if (_highlightedImageName != highligtImageName) {
        _highlightedImageName = [highligtImageName copy];
    }
    
    //重新加载图片
    [self loadThemeImage];
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName {
    if (_backgroundImageName != backgroundImageName) {
        _backgroundImageName = [backgroundImageName copy];
    }
    
    //重新加载图片
    [self loadThemeImage];
}

- (void)setBackgroundHighligtImageName:(NSString *)backgroundHighligtImageName {
    if (_backgroundHighlightedImageName != backgroundHighligtImageName) {
        _backgroundHighlightedImageName = [backgroundHighligtImageName copy];
    }
    
    //重新加载图片
    [self loadThemeImage];
}

@end
