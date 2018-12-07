//
//  CXDownloader.h
//  CXBlock
//
//  Created by 陈晓辉 on 2018/12/7.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CXDownloader : NSObject

+ (instancetype)shareDownloader;

/**
 模拟在弱网环境下下载一个大图片，耗费超过3秒
 */
- (void)requestBigImageWithUrl:(NSString *)url completion:(void (^)(UIImage *image))completion;

@end

NS_ASSUME_NONNULL_END
