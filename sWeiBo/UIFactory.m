//
//  UIFactory.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc]initWithImage:imageName highlightedImage:highlightedName];
    return button;
}
+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName backgroundHighlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc]initWithImage:backgroundImageName backgroundHighlightedImageName:highlightedName];
    return button;
}

+ (ThemeImageView *)createImageView:(NSString *)imageName
{
    ThemeImageView *themeImage = [[ThemeImageView alloc]initWithImageName:imageName];;
    return themeImage;
}

+ (ThemeLabel *)createLabel:(NSString *)colorName
{
    ThemeLabel *themeLabel = [[ThemeLabel alloc]initWithColorName:colorName];
    return themeLabel;
}

@end
