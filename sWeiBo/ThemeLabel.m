//
//  ThemeLabel.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-15.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

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
- (id)initWithColorName:(NSString *)colorName
{
    self = [self init];
    if (self != nil) {
        self.colorName = colorName;
    }
    return self;

}
- (void)setColorName:(NSString *)colorName
{
    if (_colorName != colorName) {
        _colorName = [colorName copy];
    }
    [self setColor];
}


- (void)setColor
{
    UIColor *textColor = [[ThemeManager shareInstance] getColorWithName:_colorName];
    self.textColor = textColor;
}

//主题切换的通知
#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    
    [self setColor];
}
@end
