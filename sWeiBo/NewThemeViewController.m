//
//  NewThemeViewController.m
//  sWeiBo
//
//  Created by Susanoo on 13-11-14.
//  Copyright (c) 2013年 Susanoo. All rights reserved.
//

#import "NewThemeViewController.h"
#import "ThemeManager.h"
#import "UIFactory.h"
#import "CONSTS.h"

@interface NewThemeViewController ()

@end

@implementation NewThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        themes = [[ThemeManager shareInstance].themesPlist allKeys];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return themes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"themeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UILabel *textLabel = [UIFactory createLabel:kNavigationBarTitleLabel];
        textLabel.frame = CGRectMake(10, 10, 200, 30);
        textLabel.font = [UIFont boldSystemFontOfSize:16.f];
        textLabel.tag =2013;
        [cell.contentView addSubview:textLabel];
    }
    //cell.textLabel.text = themes[indexPath.row];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2013];
    NSString *name = themes[indexPath.row];
    textLabel.text = themes[indexPath.row];
    
    NSString *themeName = [ThemeManager shareInstance].themeName;
    
    if (themeName == nil) {
        themeName = @"默认";
    }
    if ([themeName isEqualToString:name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
//切换主题
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *themeName = themes[indexPath.row];
    if ([themeName isEqualToString:@"默认"]) {
        themeName = nil;
    }
    //保存用户默认选项
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [ThemeManager shareInstance].themeName = themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:KThemeDidChangeNofication object:themeName];
    
    [tableView reloadData];
}

@end
