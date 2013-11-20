//
//  WeiboCell.h
//  sWeiBo
//  自定义微博cell
//  Created by Susanoo on 13-11-20.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@class WeiboView;
@interface WeiboCell : UITableViewCell{
    UIImageView *_userImage;  //用户头像视图
    UILabel *_nickLabel;      //昵称
    UILabel *_repostCountLabel; //转发数
    UILabel *_commentLabel;     //评论数
    UILabel *_sourceLabel;      //来源
    UILabel *_createLabel;      //创建时间
}

//微博数据模型对象
@property(nonatomic, retain)WeiboModel *weiboModel;
//微博视图
@property(nonatomic, retain)WeiboView *weiboView;

@end
