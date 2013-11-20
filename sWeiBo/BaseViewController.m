//
//  BaseViewController.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIFactory.h"
#import "CONSTS.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *viewContrllers = self.navigationController.viewControllers;
    
    if (viewContrllers.count > 1 && self.isBackButton ) {
        UIButton *button = [UIFactory createButton:@"navigationbar_back.png" highlighted:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    //宽和高自动设置
    //UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    //titleLabel.textColor = [UIColor blackColor];
    
    UILabel *titleLabel = [UIFactory createLabel:kNavigationBarTitleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    //自适应字体大小
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

- (SinaWeibo *)sinaweibo {
    //获取系统的监听
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaweibo;
    return sinaweibo;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
