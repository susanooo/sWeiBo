//
//  NewThemeViewController.h
//  sWeiBo
//
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "BaseViewController.h"

@interface NewThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray *themes;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
