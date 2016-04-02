//
//  AYSlideView.m
//  AYSlideMenu
//
//  Created by Andy on 16/3/31.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AYSlideView.h"

@interface AYSlideView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIWindow *keyWindow;
@property (nonatomic, strong) UIView *assistView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) NSArray<NSString *> *menuTitles;
@property (nonatomic, strong) UITableView *buttonTableView;
@end
static NSString *cellID =  @"cellID";
@implementation AYSlideView

- (instancetype)initWithMenuWidth:(CGFloat)menuWidth menuTitles:(NSArray<NSString *> *)titles {

    if (self = [super init]) {
        self.menuColor = [UIColor redColor];
        self.titleColor = [UIColor blackColor];
        self.menuWidth = menuWidth;
        self.menuTitles = titles;
    }
    return self;
}
/**
 *  配置slideView
 */
- (void)configSlideView {
    
    self.keyWindow = [[UIApplication sharedApplication] keyWindow];
    NSAssert(self.keyWindow != nil, @"show menu after 'viewDidLoad'");
    self.frame = CGRectMake(- _menuWidth - 30, 0, self.keyWindow.frame.size.width, self.keyWindow.frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.frame = self.keyWindow.bounds;
    self.visualEffectView.contentView.alpha = 0;
    self.assistView = [[UIView alloc] initWithFrame:CGRectMake(_menuWidth - 100, self.frame.size.height * .5, 10, 10)];
    self.assistView.hidden = YES;
    UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGestureRecongnizer];
    [self.keyWindow addSubview:self];
    [self.keyWindow addSubview:self.assistView];
    [self.keyWindow insertSubview:self.visualEffectView belowSubview:self];
    [self initSlideTableView];
}

- (void)initSlideTableView {
    
    self.buttonTableView = [[UITableView alloc] initWithFrame:CGRectMake(-self.menuWidth, 20, self.menuWidth, self.frame.size.height) style:UITableViewStylePlain];
    self.buttonTableView.backgroundColor = [UIColor clearColor];
    [self.buttonTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    if ([self.buttonTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.buttonTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.buttonTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.buttonTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    self.buttonTableView.tableFooterView = [UIView new];
    self.buttonTableView.delegate = self;
    self.buttonTableView.dataSource = self;
    self.buttonTableView.showsVerticalScrollIndicator = NO;
    self.buttonTableView.showsHorizontalScrollIndicator = NO;
    [self.keyWindow addSubview:self.buttonTableView];
}

- (void)tapAction:(UIGestureRecognizer *)recongnizer {

    [self hideMenu];
}

- (void)showMenu {
    
    self.visualEffectView.frame = self.keyWindow.bounds;
    self.assistView.frame = CGRectMake(_menuWidth - 100, self.frame.size.height * .5, 10, 10);
    self.buttonTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self configSlideView];
    });
    [UIView animateWithDuration:.25 animations:^{
        self.frame = self.bounds;
        self.buttonTableView.frame = CGRectMake(20, 20, self.menuWidth - 40, self.frame.size.height - 20);
    }];
    [self beforeAnimation];
    [UIView animateWithDuration:1 delay:0.0f usingSpringWithDamping:0.2f initialSpringVelocity:5 options:UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.assistView.center = CGPointMake(self.menuWidth, self.keyWindow.frame.size.height * .5);
        self.visualEffectView.contentView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideMenu {
    
    self.visualEffectView.frame = CGRectMake(-self.keyWindow.frame.size.width, 0, self.keyWindow.frame.size.width, self.keyWindow.frame.size.height);
    self.buttonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [UIView animateWithDuration:.25 animations:^{
        self.frame = CGRectMake(- self.keyWindow.frame.size.width, 0, self.keyWindow.frame.size.width, self.keyWindow.frame.size.height);
        self.buttonTableView.frame = CGRectMake(-self.menuWidth, 20, self.menuWidth, self.frame.size.height);
    }];
    [self beforeAnimation];
    [UIView animateWithDuration:1 delay:0.0f usingSpringWithDamping:0.2f initialSpringVelocity:5 options:UIViewAnimationOptionAllowUserInteraction |UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.assistView.frame = CGRectMake((self.menuWidth - 100), self.frame.size.height * .5, 10, 10);
    } completion:^(BOOL finished) {

    }];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, 0)];
    [linePath addLineToPoint:CGPointMake(_menuWidth, 0)];
    [linePath addQuadCurveToPoint:CGPointMake(_menuWidth, self.frame.size.height) controlPoint:CGPointMake(self.offset, self.frame.size.height * .5)];
    [linePath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [linePath closePath];
    CGContextAddPath(contextRef, linePath.CGPath);
    CGContextSetFillColorWithColor(contextRef, self.menuColor.CGColor);
//    [_menuColor set];
    CGContextFillPath(contextRef);
}

- (void)beforeAnimation {
    
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(DisplayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)DisplayLinkAction:(CADisplayLink *)displayLink {
    
    CALayer *assistViewLayer = (CALayer *)[self.assistView.layer presentationLayer];
    CGRect assistRect = assistViewLayer.frame;
    self.offset = assistRect.origin.x;
    if (assistRect.origin.x == self.menuWidth - 5 || assistRect.origin.x == self.assistView.frame.origin.x) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    [self setNeedsDisplay];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.menuTitles[indexPath.row];
    cell.textLabel.textColor = self.titleColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
