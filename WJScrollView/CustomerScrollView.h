//
//  CustomerScrollView.h
//  colloctionViewTest
//
//  Created by jerry on 16/12/15.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomerScrollView : UIView
/// 按钮数据源
@property (nonatomic,strong) NSArray * dataArr;
/// 按钮宽高，默认（65，65）
@property (nonatomic,assign) CGSize viewSize;
/// 一页可容纳的最多按钮数 默认 8
@property (nonatomic,assign) NSInteger numberOfSinglePage;
/// 按钮之间纵向间距 默认25
@property (nonatomic,assign) CGFloat viewGap;
/// 按钮的内边距 默认20
@property (nonatomic,assign) CGFloat viewMargin;

@end
