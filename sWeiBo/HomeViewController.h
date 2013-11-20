//
//  HomeViewController.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.

// 个人首页控制器

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIButton *leftButton;
    UIButton *rightButton;
}

@property(nonatomic,retain)NSArray *data;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
