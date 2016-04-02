//
//  ViewController.m
//  AYSlideMenu
//
//  Created by Andy on 16/3/31.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ViewController.h"
#import "AYSlideMenu.h"
@interface ViewController ()

@property (nonatomic, strong) AYSlideView *slideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.image = [UIImage imageNamed:@"1352885363498"];
    [self.view addSubview:backgroundImageView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blog_large"]];
    _slideView = [[AYSlideView alloc] initWithMenuWidth:150 menuTitles:@[@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7",@"菜单8",@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7",@"菜单8"]];
    _slideView.menuColor = [UIColor colorWithRed:125/255.0 green:225/255.0 blue:125/255.0 alpha:1];
    _slideView.titleColor = [UIColor darkGrayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_slideView showMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
