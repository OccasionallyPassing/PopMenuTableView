//
//  YFlabel.m
//  PopMenuTableView
//
//  Created by apple on 16/12/14.
//  Copyright © 2016年 孔繁武. All rights reserved.
//

#import "YFlabel.h"

@implementation YFlabel
- (void)awakeFromNib
{
    [super awakeFromNib];
    // 给Label添加手机
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        // 给Label添加手机
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
    }
    return self;
}

- (void)labelClick
{
    // 让label成为第一响应者
    [self becomeFirstResponder];
    
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容，显示中文，所以要手动设置app支持中文
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 菜单最终显示的位置
    [menu setTargetRect:self.bounds inView:self];
    
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuController相关
/**
 * 让Label具备成为第一响应者的资格
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ( (action == @selector(copy:) && self.text) // 需要有文字才能支持复制
        || (action == @selector(cut:) && self.text) // 需要有文字才能支持剪切
        || action == @selector(paste:)
        || action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)
        || (action == @selector(select:) && self.text)
        || (action == @selector(selectAll:) && self.text)){
        return YES;
    }
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
- (void)cut:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    // 清空文字
    self.text = nil;
}

- (void)copy:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    self.text = [UIPasteboard generalPasteboard].string;
}

- (void)select:(id)sender{
    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)selectAll:(id)sender{
    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)ding:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"%s %@", __func__, menu);
}


@end
