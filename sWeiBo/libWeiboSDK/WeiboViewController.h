//
//  WeiboViewController.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-12.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface WeiboViewController : UIViewController<WeiboSDKDelegate>

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request;
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response;

@end
