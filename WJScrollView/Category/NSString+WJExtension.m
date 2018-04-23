//
//  NSString+WJExtension.m
//
//  Created by JerryWang on 16/4/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "NSString+WJExtension.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (WJExtension)

-(NSInteger)calculateFileSize{
    
    // 创建文件管理器
    NSFileManager * mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO; // 是否为文件夹
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exists == NO) {
        return 0; // 文件夹不存在
    }
    if (dir) { // self 是一个文件夹路径
        // 遍历文件夹里面的所有内容
        NSArray * subPaths = [mgr subpathsAtPath:self];
        NSInteger totleBytesSize  = 0 ;// 存放总字节大小
        for (NSString * subPath in subPaths) {
            // 获取全路径
            NSString * fullSubPath = [self stringByAppendingPathComponent:subPath];
            // 判断是否为文件
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (dir == NO) { // 是文件
                totleBytesSize += [[mgr attributesOfItemAtPath:fullSubPath error:nil][NSFileSize] integerValue];
            }
            //[subPath hasSuffix:@".mp4"]; // 判断文件路径后缀名是否是.mp4
        }
        return totleBytesSize;
    }else{ // self 是一个文件
        
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

-(CGSize)sizeWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize{
    
    // 计算聊天内容文本的大小
    CGSize tmpSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
    return tmpSize;
}

// MD5 加密
+ (NSString *)Md5StringWithString:(NSString *)str{
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

// 统计字符数
+ (int)countWord:(NSString *)str
{
    int i,n=(int)[str length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[str characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}
@end
