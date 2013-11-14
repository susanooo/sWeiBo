//
//  UIFactory.h
//  sWeiBo
//  工厂模式 控制所有button
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"

@interface UIFactory : NSObject

+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName;
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)highlightedName;

+ (ThemeImageView *)createImageView:(NSString *)imageName;
@end
