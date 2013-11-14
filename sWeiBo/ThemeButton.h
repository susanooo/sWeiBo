//
//  ThemeButton.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-13.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *highlightedImageName;

@property(nonatomic,copy)NSString *backgroundImageName;
@property(nonatomic,copy)NSString *backgroundHighlightedImageName;;

- (id)initWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName;
- (id)initWithImage:(NSString *)backgroundImageName backgroundHighlightedImageName:(NSString *)backgroundHighlightedImageName;

@end
