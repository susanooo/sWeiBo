//
//  ThemeManager.h
//  sWeiBo
//  主题管理类
//  Created by Susanoo on 13-11-12.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//  管理类一般都是单例

#import <Foundation/Foundation.h>



@interface ThemeManager : NSObject

@property(nonatomic, retain)NSString *themeName;//当前使用的主题名称
@property(nonatomic, retain)NSDictionary *themesPlist;
@property(nonatomic, retain)NSDictionary *fontColorPlist;

+ (ThemeManager *)shareInstance;
// 返回当前主题下，图片名对应的图片
- (UIImage *)getThemeImage:(NSString *)imageName;
// 根据名称返回颜色
- (UIColor *)getColorWithName:(NSString *)name;


@end
