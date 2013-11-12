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
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //leftButton = [[UIButton alloc]init];
    //leftButton.titleLabel.text = @"注销";
    
    //rightButton = [[UIButton alloc]init];
    //rightButton.titleLabel.text = @"绑定账号";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"绑定账号" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    
    //self.navigationController.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout
{
    
}

- (void)login
{
    
}
@end
