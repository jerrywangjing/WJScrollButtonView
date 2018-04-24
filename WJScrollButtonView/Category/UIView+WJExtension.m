//
//  UIView+WJExtension.m
//
//  Created by JerryWang on 16/5/21.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "UIView+WJExtension.h"

@implementation UIView (WJExtension)

/**
 *  setter方法
 */
-(void)setX:(CGFloat)x{

    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y{

    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setSize:(CGSize)size{

    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setOrigin:(CGPoint)origin{

    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(void)setCenterX:(CGFloat)centerX{

    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX{

    return self.center.x;
}
-(void)setCenterY:(CGFloat)centerY{

    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY{

    return self.center.y;
}
/**
 *  getter方法
 */
-(CGFloat)x{

    return  self.frame.origin.x;
}

-(CGFloat)y{

    return self.frame.origin.y;
}

-(CGFloat)width{

    return self.frame.size.width;
}

-(CGFloat)height{

    return self.frame.size.height;
}

-(CGSize)size{

    return self.frame.size;
}

-(CGPoint)origin{

    return self.frame.origin;
}
@end
