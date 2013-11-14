//
//  HomeViewController.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"微博";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    
    //self.navigationController.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    if (self.sinaweibo.isAuthValid) {
        //加载微博列表数据
        [self loadWeiboData];
    }
    
}


- (void)loadWeiboData
{
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithObject:@"5" forKey:@"count"];
    [self.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:parms httpMethod:@"GET" delegate:self];
}

- (void)logout
{
    [self.sinaweibo logOut];
    NSLog(@"注销");
}

- (void)login
{
    [self.sinaweibo logIn];
    NSLog(@"登陆");
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"网络加载失败%@",error);
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"网络加载完成");
}

#pragma mark - Memory Manager
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
