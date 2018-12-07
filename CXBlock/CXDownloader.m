//
//  CXDownloader.m
//  CXBlock
//
//  Created by 陈晓辉 on 2018/12/7.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXDownloader.h"

@interface CXDownloader()

@property (nonatomic, copy) void (^completion)(UIImage *image);

@end

@implementation CXDownloader

+ (instancetype)shareDownloader {
    static CXDownloader *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CXDownloader new];
    });
    return instance;
}

- (void)requestBigImageWithUrl:(NSString *)url completion:(void (^)(UIImage *image))completion {
    self.completion = completion;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //模拟弱网需要3秒下载
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImage *bigImg = [UIImage imageNamed:url];
            if(completion) completion(bigImg);
        });
    });
}

@end
