//
//  WeiboView.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-20.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@class WeiboModel;

@interface WeiboView : UIView<RTLabelDelegate>
{
    @private
    RTLabel *_textLabel;   //微博内容
    UIImageView *_image;   //微博图片
    UIImageView *_repostBackgroundView;   //转发的微博视图背景
}

@property(nonatomic, retain)WeiboModel *weiboModel;
//转发的微博视图
@property(nonatomic, retain)WeiboView *repostView;

@property(nonatomic,assign)BOOL isRepost;  //是否是转发的微博视图

+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost;

@end
