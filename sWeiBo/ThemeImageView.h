//
//  ThemeImageView.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic,copy)NSString *imageName;

- (id)initWithImageName:(NSString *)imageName;
@end
