//
//  WJScrollButtonView.m
//  WJScrollView
//
//  Created by JerryWang on 2018/4/23.
//  Copyright © 2018年 JerryWang. All rights reserved.
//

#import "WJScrollButtonView.h"
#import "NSString+WJExtension.h"
#import "UIView+WJExtension.h"
#import "UIButton+WebCache.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define WIDTH_RATE (SCREEN_WIDTH/375)   // 屏幕宽度系数（以4.7英寸为基准）
#define HEIGHT_RATE (SCREEN_HEIGHT/667)

#define BGColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]


static const CGFloat WJ_DEFAULT_HEIGHT = 225;           // 默认的view高度
static const CGFloat WJ_DEFAULT_BTN_WH = 65;            // 默认的按钮宽高
static const NSUInteger WJ_NUMBEROFSINGLE_PAGE = 8;     // 一个页面中放置的按钮数
static const NSUInteger MAX_COL = 4;                    // 最大的列数
static const NSUInteger MAX_ROW = 2;                    // 最大的行数

@interface WJScrollButtonView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * contentScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;

@property (nonatomic,strong) NSMutableArray *scrollBtns;
@end

@implementation WJScrollButtonView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    
    return [self initWithFrame:frame dataSource:nil btnSize:CGSizeMake(WJ_DEFAULT_BTN_WH, WJ_DEFAULT_BTN_WH)];
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource{
    return [self initWithFrame:frame dataSource:dataSource btnSize:CGSizeMake(WJ_DEFAULT_BTN_WH, WJ_DEFAULT_BTN_WH)];
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource btnSize:(CGSize)size{

    if (self = [super initWithFrame:frame]) {
        
        // init value
        
        _backgroundColor = BGColor;
        _btnDataSource = dataSource;
        _btnSize = size;
        _LineSpacing = 25;
        _columnsSpacing = 25*WIDTH_RATE;
        
        // setup btns
        [self setupContentScrollView];
    }
    return self;
}

+ (instancetype)scrollButtonViewWithDataSource:(NSArray *)dataSource{
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT-WJ_DEFAULT_HEIGHT, SCREEN_WIDTH, WJ_DEFAULT_HEIGHT);
    CGSize size = CGSizeMake(WJ_DEFAULT_BTN_WH, WJ_DEFAULT_BTN_WH);
    
    return [[self alloc] initWithFrame:frame dataSource:dataSource btnSize:size];
}

+ (instancetype)scrollButtonViewWithDataSource:(NSArray *)dataSource btnSize:(CGSize)size{
    
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT-WJ_DEFAULT_HEIGHT, SCREEN_WIDTH, WJ_DEFAULT_HEIGHT);
    return [[self alloc] initWithFrame:frame dataSource:dataSource btnSize:size];
}

#pragma mark - setup subviews

- (void)setupContentScrollView{
    
    if (!_btnDataSource || _btnDataSource.count == 0) {
        NSLog(@"数据源不能为空");
        return;
    }
    
    // page control
    
    NSInteger pageCount = _btnDataSource.count / WJ_NUMBEROFSINGLE_PAGE;
    
    if (_btnDataSource.count % WJ_NUMBEROFSINGLE_PAGE > 0) {
        pageCount += 1;
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.height-20, 0, 0)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.numberOfPages = pageCount;
    
    [self addSubview:_pageControl];
    
    
    // content scrollView
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _contentScrollView.delegate = self;
    _contentScrollView.backgroundColor = self.backgroundColor;
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, self.height);
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:_contentScrollView];
    [self bringSubviewToFront:_pageControl];
    
    // add btns
    
    
    
    for (int i = 0; i < pageCount; i++) {
        [self setupScrollBtnsForPage:i];
    }
}

- (void)setupScrollBtnsForPage:(NSInteger)page{
    
    // 准备数据
    
    CGFloat btnW = self.btnSize.width * WIDTH_RATE;
    CGFloat btnH = self.btnSize.height * HEIGHT_RATE;
    
    CGFloat leftRightMargin = (self.width - (MAX_COL * btnW + (MAX_COL-1) * _columnsSpacing))/2;      // 左右内边距;
    CGFloat topBottomMargin = (self.height - (MAX_ROW * btnH + (_LineSpacing+30)))/2;                // 上下内边距
    
    NSInteger count = self.btnDataSource.count - (page * WJ_NUMBEROFSINGLE_PAGE);
    
    NSInteger indexCount;
    if (count > 0 && count <= WJ_NUMBEROFSINGLE_PAGE) {
        
        indexCount = count;
    }else if(count > WJ_NUMBEROFSINGLE_PAGE){
        
        indexCount = WJ_NUMBEROFSINGLE_PAGE;
    }else{
        
        return;
    }
    
    // 创建按钮
    
    for (int i = 0; i<indexCount; i++) {
        UIButton  * btn = [[UIButton alloc] init];
        
        int col = i % MAX_COL;
        int row = i / MAX_COL;
        NSInteger index = i + page * WJ_NUMBEROFSINGLE_PAGE;
        NSDictionary * btnDic = self.btnDataSource[index];
        
        // 设置图片内容（使图片和文字水平居中显示）
        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [btn setTitle:btnDic[@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        NSString *imageName = btnDic[@"image"];
        
        if ([imageName hasPrefix:@"http://"] || [imageName hasPrefix:@"https://"]) {
            [btn sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        }
        
        // 设置图片frame
        
        btn.x = col * (btnW + _columnsSpacing) + leftRightMargin + page * self.width;
        btn.y = row * (btnH + _LineSpacing) + topBottomMargin;
        
        btn.width = btnW;
        btn.height = btnH;
        btn.tag = index;
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+20 ,-btn.imageView.frame.size.width, 0,0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.width - btn.imageView.width)/2 ,0 ,0)];//图片距离右边框距离减少图片的宽度，其它不变
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentScrollView addSubview:btn];
        [self.scrollBtns addObject:btn];
    }
}

#pragma mark - actions

// 按钮点击事件

-(void)btnClick:(UIButton *)btn{
    if (_didClickBtn) {
        _didClickBtn(btn);
    }
}

#pragma mark - scroll delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger correntCount = (scrollView.contentOffset.x + self.width/2)/self.width;
    self.pageControl.currentPage = correntCount;
}

#pragma mark - getter

- (NSMutableArray *)scrollBtns{
    if (!_scrollBtns) {
        _scrollBtns = [NSMutableArray array];
    }
    return _scrollBtns;
}

- (NSInteger)currentPage{
    return self.pageControl.currentPage;
}


#pragma mark - setter

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    self.contentScrollView.backgroundColor = backgroundColor;
}

- (void)setBtnDataSource:(NSArray *)btnDataSource{
    _btnDataSource = btnDataSource;
    [self setupContentScrollView];
}
- (void)setBtnSize:(CGSize)btnSize{
    _btnSize = btnSize;
    [self updateBtnsSize];
}

- (void)setLineSpacing:(CGFloat)LineSpacing{
    _LineSpacing = LineSpacing;
    [self updateBtnsSize];
}

- (void)setColumnsSpacing:(CGFloat)columnsSpacing{
    _columnsSpacing = columnsSpacing * WIDTH_RATE;
    [self updateBtnsSize];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

#pragma mark - private

- (void)updateBtnsSize{
    
    CGFloat btnW = self.btnSize.width * WIDTH_RATE;
    CGFloat btnH = self.btnSize.height * HEIGHT_RATE;
    
    CGFloat leftRightMargin = (self.width - (MAX_COL * btnW + (MAX_COL-1) * _columnsSpacing))/2;      // 左右内边距;
    CGFloat topBottomMargin = (self.height - (MAX_ROW * btnH + (_LineSpacing+30)))/2;                // 上下内边距
    
    for (NSInteger i = 0; i < self.scrollBtns.count; i++) {
        
        UIButton *btn = self.scrollBtns[i];
        
        NSInteger page =  i / WJ_NUMBEROFSINGLE_PAGE;
        
        NSInteger col = i % MAX_COL;
        NSInteger row = (i-page*WJ_NUMBEROFSINGLE_PAGE) / MAX_COL;
        NSLog(@"row:%ld",row);
        
        CGFloat btnX = col * (btnW + _columnsSpacing) + leftRightMargin + page * self.width;
        CGFloat btnY = row * (btnH + _LineSpacing) + topBottomMargin;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

@end
