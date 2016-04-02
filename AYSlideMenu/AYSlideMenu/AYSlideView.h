//
//  AYSlideView.h
//  AYSlideMenu
//
//  Created by Andy on 16/3/31.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYSlideView : UIView

@property (nonatomic, strong) UIColor *menuColor;
@property (nonatomic, strong) UIColor *titleColor;
- (void)showMenu;
- (void)hideMenu;
- (instancetype)initWithMenuWidth:(CGFloat)menuWidth menuTitles:(NSArray<NSString *> *)titles;
@end
