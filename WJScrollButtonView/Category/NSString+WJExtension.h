//
//  NSString+WJExtension.h
//
//  Created by JerryWang on 16/4/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (WJExtension)

/// 计算文件夹下所有文件的大小

-(NSInteger)calculateFileSize;

/// 计算文字宽高
- (CGSize)sizeWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;
/// MD5 加密
+ (NSString *)Md5StringWithString:(NSString *)str;
/// 统计字符串中的字符数
+ (int)countWord:(NSString *)str;
@end
