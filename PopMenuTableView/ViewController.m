//
//  ViewController.m
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/1.
//  Copyright © 2016年 孔繁武. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"
#import "YFlabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet  YFlabel *label;

@property (nonatomic,strong) MenuView * menuView;
@property (nonatomic,assign) BOOL flag;

@end

@implementation ViewController

- (MenuView *)menuView{
    if (!_menuView) {
        
        /**
         *  这些数据是菜单显示的图片和文字，小弟写在这里，不知合不合理，请各位大牛指教
         *  e-mail : KongPro@163.com
         */
        NSDictionary *dict1 = @{@"imageName" : @"icon_button_affirm",
                                @"itemName" : @"撤回"
                                };
        NSDictionary *dict2 = @{@"imageName" : @"icon_button_recall",
                                @"itemName" : @"确认"
                                };
        //icon_button_record
        NSDictionary *dict3 = @{@"imageName" : @"icon_button_record",
                                @"itemName" : @"记录"
                                };
        NSArray *dataArray = @[dict1,dict2,dict3];
        
        CGFloat x = self.view.bounds.size.width / 3 * 2;
        CGFloat y = 64 - 10;
        CGFloat width = self.view.bounds.size.width * 0.3;
        CGFloat height = dataArray.count * 44;
        __weak __typeof(&*self)weakSelf = self;
        /**
         *  创建menu
         */
        _menuView = [MenuView createMenuWithFrame:CGRectMake(x, y, width, height) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
            
            // do something
            [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
            
        } backViewTap:^{
            // 点击背景遮罩view后的block，可自定义事件
            // 这里的目的是，让rightButton点击，可再次pop出menu
            weakSelf.flag = YES;
            _menuView = nil;
            
        }];
    }
    return _menuView;
}


- (IBAction)popMenu:(id)sender {

    if (self.flag) {
        [self.menuView showMenuWithAnimation:YES];
        self.flag = NO;
    }else{
        [self.menuView showMenuWithAnimation:NO];
        self.flag = YES;
        self.menuView = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = YES;
    
    YFlabel *cutLabel = [[YFlabel alloc]initWithFrame:CGRectMake(100, 100, 200, 44)];
    cutLabel.text = @"叫对方看大家放开点附近的开发及付款方";
    [self.view addSubview:cutLabel];
    cutLabel.userInteractionEnabled = YES;
    
    YFlabel *pasteLabel = [[YFlabel alloc]initWithFrame:CGRectMake(100, 154, 200, 44)];
    pasteLabel.backgroundColor = [UIColor yellowColor];
    pasteLabel.text = @"";
    [self.view addSubview:pasteLabel];
    pasteLabel.userInteractionEnabled = YES;
}

- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag + 1] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UIMenuController
/*
//假如没有图片,使用系统的UIMenuController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIMenuController *menuCon = [UIMenuController sharedMenuController];
    UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"item1" action:@selector(itemClick:)];
    UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"item2" action:@selector(itemClick:)];
    UIMenuItem *item3 = [[UIMenuItem alloc]initWithTitle:@"item3" action:@selector(itemClick:)];
    UIMenuItem *item4= [[UIMenuItem alloc]initWithTitle:@"item4" action:@selector(itemClick:)];
    UIMenuItem *item5 = [[UIMenuItem alloc]initWithTitle:@"item5" action:@selector(itemClick:)];
    menuCon.menuItems = @[item1,item2,item3,item4,item5];
    [menuCon setTargetRect:CGRectMake(50, 100, 100, 100) inView:self.view];
    menuCon.arrowDirection = UIMenuControllerArrowRight;
    [menuCon setMenuVisible:YES animated:YES];
    
}

- (void)itemClick:(UIMenuItem *)item{
    NSLog(@"%@",item);
}
//如果想展示 UIMenuController 必须重写当前类的这个方法，返回 YES。
- (BOOL)canBecomeFirstResponder {
    return YES;
}
 */

- (void)labelClick{
    NSLog(@"dfd ");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
