//
//  ViewController.m
//  CXBlock
//
//  Created by 陈晓辉 on 2018/12/7.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "ViewController.h"
#import "CXShowImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 100, 40);
    [btn setTitle:@"Present" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}
- (void)btnClick {
    
    [self presentViewController:[CXShowImageViewController new] animated:YES completion:nil];
}
/*
 block代码块在开发中常用于异步开发，例如GCD就是提供block的异步块，同时在使用block的时候往往需要注意避免循环引用，而消除block循环引用就是靠__weak来实现，比如：
 
 __weak typeof(self) weakSelf = self;
 
 然后在 block 块中使用 __weak 的 weakSelf 这样就避免了循环引用的问题。
 同时为了保证在 block 块中 self 不被释放掉，往往在 block 块中添加 __strong 修饰的引用
 
 __strong typeof(_self) strongSelf = weakSelf;
 
 这样既避免了循环引用，同时也保障了block块中使用self的时候不被意外释放掉
 
 __weak typeof(self) weakSelf = self;
 [self xxxfunciotnCompletion:^(void){
 
    //使用self不会存在循环引用了
    __strong typeof(_self) strongSelf = weakSelf;
 }];
 */

/** 注意:
 
 同时还应该注意另外一个细节问题，如果在异步的 Completion: 块还没有执行前 self 就被释放的问题, 因为 block 块在执行前是并没有强引用 self, 此时 self 是可能被释放的；如果此时再使用 self 就应该注意 nil 可能引起的崩溃。
 因为 __strong typeof(_self) strongSelf = weakSelf; 只能保障如果此时 self 没有被释放那么在 block 块中使用 self 期间不会被释放, 这只是暂时性的强引用 self, 随着 block 块的结束而释放。
 */

/** 示例:
 
 present 一个控制器 CXShowImageViewController，CXShowImageViewController 加载后去下载一张大图片，然后动态的添加这个图片到视图，并给图片添加约束
 在图片加载出来之前 dismiss 关闭页面, 会出现崩溃
 
 崩溃原因:
 为创建约束时的first layout item不能为null, 而在此例中的first layout item即为self.view，也就是说self.view为nil了，因为我们在图片下载完成前就dismiss了也就被销毁了，所以self.view自然为nil了导致崩溃。
 
 解决
 在使用block解决循环引用别忘记判断self是否为空。
 
 __weak typeof(self) weakSelf = self;
 [self xxxfunciotnCompletion:^(void){
 
    //使用self不会存在循环引用了
    __strong typeof(_self) strongSelf = weakSelf;
    if(!strongSelf) return;
 }];
 */

@end
