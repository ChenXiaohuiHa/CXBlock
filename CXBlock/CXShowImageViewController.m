//
//  CXShowImageViewController.m
//  CXBlock
//
//  Created by 陈晓辉 on 2018/12/7.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXShowImageViewController.h"
#import "CXDownloader.h"
@interface CXShowImageViewController ()

@end

@implementation CXShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self showImage];
}

#pragma mark ---------- UI ----------
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------- 加载大图,并显示 ----------
- (void)showImage {
    
    __weak typeof(self) weakSelf = self;
    [[CXDownloader shareDownloader] requestBigImageWithUrl:@"BigImg" completion:^(UIImage * _Nonnull image) {
        //在此之前如果点击了dissmiss按钮 BViewController将j会被释放， self = nil;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        //如果没有这个 if 判断, 可能出现崩溃
//        if (!strongSelf) {
//            return;
//        }
        
        
        //创建一个UIImageView显示, 并添加水平居中约束
        UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 200, 200)];
        bigImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:bigImageView];
        bigImageView.image = image;
        
        //创建约束
        [NSLayoutConstraint constraintWithItem:strongSelf.view
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:bigImageView
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.0f
                                      constant:0.0f].active = YES;
        
        [NSLayoutConstraint constraintWithItem:strongSelf.topLayoutGuide
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:bigImageView
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0f
                                      constant:-80.0f].active = YES;
    }];
}



@end
