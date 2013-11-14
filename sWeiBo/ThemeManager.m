//
//  ThemeManager.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-12.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "ThemeManager.h"
#import "CONSTS.h"


static ThemeManager *sigleton = nil;

@implementation ThemeManager

+ (ThemeManager *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[ThemeManager alloc] init];
        }
    }
    return sigleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle]pathForResource:@"Theme" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        
        //默认为空
        self.themeName =nil;
    }
    return self;
}



//切换主题时，会调用此方法设置主题名称
- (void)setThemeName:(NSString *)themeName {
    if (_themeName != themeName) {
        _themeName = [themeName copy];
    }
    
    //切换主题，重新加载当前主题下的字体配置文件
    NSString *themeDir = [self getThemePath];
    NSString *filePath = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
}



- (NSString *)getThemePath
{
    if (self.themeName == nil) {
        //根目录的路径
        NSString *themePath = [[NSBundle mainBundle]resourcePath];
        return themePath;
    }
    
    //主题相对路径
    NSString *subThemePath = [self.themesPlist objectForKey:_themeName];
    //程序包根路径
    NSString *mainPath = [[NSBundle mainBundle]resourcePath];
    
    //追加在一起
    NSString *themePath = [mainPath stringByAppendingPathComponent:subThemePath];
    
    return themePath;
    
}

- (UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return nil;
    }
    //获取主题目录
    NSString *themePath = [self getThemePath];
    
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

- (UIColor *)getColorWithName:(NSString *)name {
    if (name.length == 0) {
        return nil;
    }
    
    //返回三色值，如：24,35,60
    NSString *rgb = [_fontColorPlist objectForKey:name];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    if (rgbs.count == 3) {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = Color(r, g, b, 1);
        return color;
    }
    
    return nil;
}


//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}


@end
