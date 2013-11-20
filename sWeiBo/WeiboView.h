//
//  WeiboView.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-20.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@class ThemeImageView;
@class WeiboModel;

#define kWeibo_width_List (320-60) //微博在列表中的宽度
#define kWeibo_Width_Detail  300  //微博在详情中宽度

@interface WeiboView : UIView<RTLabelDelegate>
{
    @private
    RTLabel *_textLabel;   //微博内容
    UIImageView *_image;   //微博图片
    ThemeImageView *_repostBackgroundView;   //转发的微博视图背景
    WeiboView *_repostView;   //转发的微博视图
    NSMutableString *_parseText;
}

@property(nonatomic, retain)WeiboModel *weiboModel;

@property(nonatomic,assign)BOOL isRepost;  //是否是转发的微博视图
//是否显示在微博详情
@property(nonatomic,assign)BOOL isDetail;  //是否是转发的微博视图

+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetail;
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost;
@end
