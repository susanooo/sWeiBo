//
//  MainViewController.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface MainViewController : UITabBarController<SinaWeiboDelegate>{
    UIView *_tabbarVirw;
}

@property (nonatomic,retain)UIView *tabbarView;
@end
