//
//  WJScrollButtonView.h
//  WJScrollView
//
//  Created by JerryWang on 2018/4/23.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WJScrollButtonBlock)(UIButton *btn);

@interface WJScrollButtonView : UIView

/**
 背景色，默认：[UIColor lightGrayColor];
 */
@property (nonatomic,strong) UIColor *backgroundColor;

/**
 ScrollButton 数据源，请按照此格式进行填充数据：(也可以写入plist文件，本地加载)
 self.btnDataSource = @[
                         @{
                         @"title" : @"标题",
                         @"image" : @"图片"   // 注意：如果是本地图片，填写图片名称。如果是网络图片请填写图片的url字符串
                         }
                        ];
 */

@property (nonatomic,strong) NSArray *btnDataSource;

/**
 scrollButton 按钮的大小，默认：65x65
 */
@property (nonatomic,assign) CGSize btnSize;

/**
 顶部边距，上面一行按钮的最顶部距WJScrollButtonView的最顶端的距离。默认：
 */
@property (nonatomic,assign) CGFloat topMargin;         // 上下外边距--

/**
 左右边距，按钮的最左端到WJScrollButtonView的最左端的距离，右边距同理，只需要设置一次即可。默认：
 */
@property (nonatomic,assign) CGFloat leftRightMargin;   // 左右外边距--

/**
 行间距，上下间隙,两排按钮水平方向之间的距离，默认：25
 */
@property (nonatomic,assign) CGFloat LineSpacing;

/**
 列间距，左右间隙,上下按钮垂直方向之间的距离，默认：25*WIDTH_RATE，WIDTH_RATE = SCREEN_WIDTH/375
 */
@property (nonatomic,assign) CGFloat columnsSpacing;

/**
 按钮的点击回调
 */
@property (nonatomic,copy) WJScrollButtonBlock didClickBtn;


#pragma mark - pageControl

@property (nonatomic,assign,readonly) NSInteger currentPage;
@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;

/**
 初始化方法

 @param frame frame
 @param dataSource scrollButton数据源，需按照上述格式拼装数据，最多只支持2行4列按钮
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;
/**
 初始化方法
 
 @param frame frame
 @param dataSource scrollButton数据源，需按照上述格式拼装数据，最多只支持2行4列按钮
 @param size 按钮的大小
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource btnSize:(CGSize)size;


/**
 便利初始化方法，大小使用默认的frame，宽度等于屏幕的宽度，高度为：225, 并且使用默认的按钮大小
 
 @param dataSource scrollButton数据源，需按照上述格式拼装数据，最多只支持2行4列按钮
 @return 实例对象
 */
+ (instancetype)scrollButtonViewWithDataSource:(NSArray *)dataSource;

/**
 便利初始化方法，大小使用默认的frame，宽度等于屏幕的宽度，高度为：225

 @param dataSource scrollButton数据源，需按照上述格式拼装数据，最多只支持2行4列按钮
 @param size 按钮大小
 @return 实例对象
 */
+ (instancetype)scrollButtonViewWithDataSource:(NSArray *)dataSource btnSize:(CGSize)size;

@end
