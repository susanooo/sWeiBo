//
//  ThemeLabel.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-15.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;


@end
