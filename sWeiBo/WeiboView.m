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
#import "ThemeImageView.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"


#define LIST_FONT 14.0f //列表中的内容字体
#define LIST_REPOST_FONT 13.0f //列表中的转发内容字体
#define DETAIL_FONT 18.0f //详情中文本字体
#define DETAIL_REPOST_FONT 17.0f  //详情中转发的文本字体

@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
        _parseText = [[NSMutableString alloc]init];
    }
    
    return self;
}

- (void)_initView {
    //微博内容
    _textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _textLabel.delegate = self;
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    //十进制RGB值：r:69 g:149 b:203
    //十六进制RGB值：4595CB
    //设置链接的颜色
    _textLabel.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    //设置链接高亮的颜色
    _textLabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self addSubview:_textLabel];
    
    //微博图片
    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.backgroundColor = [UIColor clearColor];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    //设置图片的内容显示模式：等比例缩/放（不会被拉伸或压缩）
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_image];
    
    //转发微博视图的背景
    _repostBackgroundView = [UIFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image = [_repostBackgroundView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroundView.image = image;
    _repostBackgroundView.leftCapWidth = 25;
    _repostBackgroundView.topCapHeight = 10;
    _repostBackgroundView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroundView atIndex:0];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc]initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        [self addSubview:_repostView];
    }
    [self parseLink];
}

//解析超链接
- (void)parseLink
{
    [_parseText setString:@""];
    
    NSString *text = _weiboModel.text;
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSArray *matchArray = [text componentsMatchedByRegex:regex];
    for (NSString *linkString in matchArray) {
        //不同形式的超链接
        //<a href='user://@用户'></a>
        //<a href='http://www.baidu.com'>http://www.baidu.com</a>
        //<a href='topic:'>#话题#</a>
        
        NSString *replacing = nil;
        
        if ([linkString hasPrefix:@"@"]) {
            
            replacing = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }
        else if ([linkString hasPrefix:@"http"]){
            //linkString = [linkString URLEncodedString];
            replacing = [NSString stringWithFormat:@"<a href='%@'>%@</a>",linkString,linkString];
        }
        else if ([linkString hasPrefix:@"#"]){
            //linkString = [linkString URLEncodedString];
            replacing = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }
        
        if (replacing != nil) {
            text = [text stringByReplacingOccurrencesOfString:linkString withString:replacing];
        }
        
    }
    
    [_parseText appendString:text];
    
}

//展示数据，设置子视图布局
//layout可能会被调用多次
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    //---------------微博内容_textLabel子视图------------------
    //获取字体大小
    float fontSize = [WeiboView getFontSize:self.isDetail isRepost:self.isRepost];
    _textLabel.font = [UIFont systemFontOfSize:fontSize];
    _textLabel.frame = CGRectMake(0, 0, self.width, 20);
    //判断当前视图是否为转发视图
    if (self.isRepost) {
        _textLabel.frame = CGRectMake(10, 10, self.width-20, 0);
    }
    _textLabel.text = _parseText;
    
    //文本内容尺寸
    CGSize textSize = _textLabel.optimumSize;
    _textLabel.height = textSize.height;
    
    
    //---------------转发的微博视图_repostView------------------
    //转发的微博model
    WeiboModel *repostWeibo = _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.hidden = NO;
        _repostView.weiboModel = repostWeibo;
        
        //计算转发微博视图的高度
        float height = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(0, _textLabel.bottom, self.width, height);
    } else {
        _repostView.hidden = YES;
    }
    
    
    //---------------微博图片视图_image------------------
    NSString *thumbnailImage = _weiboModel.thumbnailImage;
    if (thumbnailImage != nil && ![@"" isEqualToString:thumbnailImage]) {
        _image.hidden = NO;
        _image.frame = CGRectMake(10, _textLabel.bottom+10, 70, 80);
        
        //加载网络图片数据
        [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
    } else {
        _image.hidden = YES;
    }
    
    //----------------转发的微博视图背景_repostBackgroudView---------------
    if (self.isRepost) {
        _repostBackgroundView.frame = self.bounds;
        _repostBackgroundView.hidden = NO;
    } else {
        _repostBackgroundView.hidden = YES;
    }
}

//计算微博视图的高度
+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetail{
    /**
     *   实现思路：计算每个子视图的高度，然后相加。
     **/
    float height = 0;
    
    //--------------------计算微博内容text的高度------------------------
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontsize = [WeiboView getFontSize:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontsize];
    //判断此微博是否显示在详情页面
    if (isDetail) {
        textLabel.width = kWeibo_Width_Detail;
    } else {
        textLabel.width = kWeibo_width_List;
    }
    
    textLabel.text = weiboModel.text;
    
    height += textLabel.optimumSize.height;
    
    //--------------------计算微博图片的高度------------------------
    NSString *thumbnailImage = weiboModel.thumbnailImage;
    if (thumbnailImage != nil && ![@"" isEqualToString:thumbnailImage]) {
        height += (80+10);
    }
    
    //--------------------计算转发微博视图的高度------------------------
    //转发的微博
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo != nil) {
        //转发微博视图的高度
        float repostHeight = [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:isDetail];
        height += (repostHeight);
    }
    
    if (isRepost == YES) {
        height += 30;
    }
    
    return height;
}
//获取字体大小
+ (float)getFontSize:(BOOL)isDetail isRepost:(BOOL)isRepost{
    float fontSize = 14.0f;
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }
    if (!isDetail && isRepost) {
        return LIST_REPOST_FONT;
    }
    if (isDetail && !isRepost) {
        return DETAIL_FONT;
    }
    if (isDetail && isRepost) {
        return DETAIL_REPOST_FONT;
    }
    return fontSize;
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSString *absolu = [url absoluteString];
    if ([absolu hasPrefix:@"user"]) {
        NSString *urlSting = [url host];
        urlSting = [urlSting URLDecodedString];
        NSLog(@"用户：%@",urlSting);
    }else if ([absolu hasPrefix:@"http"]){
        NSLog(@"链接:%@",absolu);
    }
    else if ([absolu hasPrefix:@"topic"]){
        NSString *urlSting = [url host];
        urlSting = [urlSting URLDecodedString];
        NSLog(@"话题：%@",urlSting);
    }
    

}

@end
