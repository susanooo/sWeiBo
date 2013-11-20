//
//  WeiboView.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-20.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    
    return self;
}

- (void)_initView {
    _textLabel = [[RTLabel alloc]initWithFrame:CGRectZero];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"blue" forKey:@"color"];
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];

    [self addSubview:_textLabel];
    
    _image = [[UIImageView alloc]initWithFrame:CGRectZero];
    //设置默认图片
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    [self addSubview:_image];
    
    _repostBackgroundView = [UIFactory createImageView:@"timeline_retweet"];
    //拉伸图片 规定从哪里开始拉伸 距左多少距离 距顶端多少距离
    UIImage *image = [_repostBackgroundView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    
    _repostBackgroundView.image = image;
    _repostBackgroundView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroundView atIndex:0];
    
    //创建转发视图
}

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        [self addSubview:_repostView];
    }
}
//展示数据，设置子视图布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //------------微博内容 _textLabel子视图---------------
    _textLabel.frame = CGRectMake(0, 0, self.width , 20);
    if (self.isRepost == YES) {
        _textLabel.frame = CGRectMake(10, 10, self.width-20 , 0);
    }
    _textLabel.text = _weiboModel.text;
    CGSize textSize = _textLabel.optimumSize;
    _textLabel.height =textSize.height;
    
    //------------转发微博视图_repostView子视图 ---------------
    WeiboModel *repostWeibo =  _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.weiboModel = repostWeibo;
#warning 高度待定
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width , 0);
    }
    else{
        _repostView.hidden = YES;
    }
    //------------微博图片 ---------------
    NSString *thumbnailImage = _weiboModel.thumbnailImage;
    if (thumbnailImage != nil && [@"" isEqualToString:thumbnailImage]) {
        _image.hidden = NO;
        _image.frame = CGRectMake(10, _textLabel.bottom, 70, 80);
        
        //加载网络图片数据
        [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
    }else{
        _image.hidden = YES;
    }
    
    //--------------转发的微博视图背景------------------
    if (self.isRepost) {
        _repostBackgroundView.frame = self.bounds;
        _repostBackgroundView.hidden = NO;
    }
    else{
        _repostBackgroundView.hidden = YES;
    }
    
}

//计算微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost{
    return 0;
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
}

@end
