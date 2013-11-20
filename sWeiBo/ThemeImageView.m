//
//  ThemeImageView.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

//只要添加了通知就必须要移除 否则有崩溃隐患
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//使用xib初始化时调用这个方法 不经过init
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNofication object:nil];
    
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:KThemeDidChangeNofication object:nil];
    }

    return self;
}

- (id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self != nil) {
        self.imageName = imageName;
    }
    return self;
}


- (void)setImageName:(NSString *)imageName
{
    if (_imageName !=imageName) {
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
    
}

- (void)loadThemeImage
{
    if (self.imageName == nil) {
        return;
    }
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:_imageName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    self.image = image;
}
//主题切换的通知
#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    
    [self loadThemeImage];
}

@end
