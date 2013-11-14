//
//  MainViewController.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-11.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "UIFactory.h"
//#import "ThemeButton.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self _initViewController];
    [self _initTabbarView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) _initViewController
{
    HomeViewController *home = [[HomeViewController alloc]init];
    MessageViewController *message = [[MessageViewController alloc]init];
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    MoreViewController *more = [[MoreViewController alloc]init];
    
    NSArray *views = @[home,message,profile,discover,more];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    
    for (UIViewController *viewController in views) {
        BaseNavigationController *navi = [[BaseNavigationController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:navi];
    }
    self.viewControllers = viewControllers;
}

//创建自定义tabbar
- (void) _initTabbarView {
    _tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, 320, 49)];
    //_tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    UIImageView *tabbarBackgroundImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarBackgroundImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarBackgroundImage];
    
    NSArray *background = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *highlightBackground = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i=0; i<background.count; i++) {
        NSString *backImage = background[i];
        NSString *hightImage = highlightBackground[i];
        
        
        //ThemeButton * button = [[ThemeButton alloc]initWithImage:backImage highlightedImage:hightImage];
        UIButton *button = [UIFactory createButton:backImage highlighted:hightImage];
        
        //宽和高对应图片的宽和高 x:320分成5份 64-宽30 除2正好居中 再加上前面button的宽度
        button.frame = CGRectMake((64-30)/2+(i*64), (49-30)/2, 30, 30);
        button.tag = i;
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabbarView addSubview:button];
        
    }
}

- (void)selectedTab:(UIButton *)button
{
    //利用传递tag告诉controller切换界面
    self.selectedIndex = button.tag;
    
}

#pragma mark - SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    //保存认证的数据到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    //移除认证的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo {
    NSLog(@"sinaweiboLogInDidCancel");
}

@end
