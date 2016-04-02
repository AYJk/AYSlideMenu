# AYSlideMenu
SlideMenu With Drop Animation/带动画的侧边菜单 

[![LICENSE](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/AYJk/AYPageControl/blob/master/License)&nbsp;
[![SUPPORT](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg)](https://en.wikipedia.org/wiki/IOS_7)&nbsp;
[![BLOG](https://img.shields.io/badge/blog-ayjkdev.top-orange.svg)](http://ayjkdev.top/)&nbsp;

侧边动画效果的SlideMenu，效果图如下，也可以去我的博客看详细信息。

![效果图](http://7xrofo.com1.z0.glb.clouddn.com/AYSlideMenu.gif)

## 如何使用
### 导入头文件
```objc
#import "AYSlideMenu.h"
```
### 相关属性
#### 初始化
```objc
self.slideView = [[AYSlideView alloc] initWithMenuWidth:150 menuTitles:titles];
self.slideView.menuColor = [UIColor colorWithRed:125/255.0 green:225/255.0 blue:125/255.0 alpha:1];
self.slideView.titleColor = [UIColor darkGrayColor];
self.slideView.buttonActionBlock = ^(NSInteger index) {
        NSLog(@"click button click %ld",index);
    };
```
#### 调用方法
```objc
[self.slideView showMenu];
```
需要显示的时候调用**showMenu**就行了。
