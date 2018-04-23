//
//  ViewController.m
//  WJScrollView
//
//  Created by JerryWang on 2016/12/20.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "ViewController.h"
#import "WJScrollButtonView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ViewH 225

@interface ViewController ()

@property (nonatomic,strong) WJScrollButtonView * scrollBtnView;
@property (nonatomic,strong) NSArray * dataSource;

@end

@implementation ViewController

-(NSArray *)dataSource{
    
    if (!_dataSource) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
        _dataSource = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scroll btn view
    
    CGRect frame = CGRectMake(0, SCREEN_HEIGHT-ViewH, SCREEN_WIDTH, ViewH);
    
    _scrollBtnView = [[WJScrollButtonView alloc] initWithFrame:frame dataSource:self.dataSource];
//    _scrollBtnView.LineSpacing = 10;
//    _scrollBtnView.columnsSpacing = 10;
    
    _scrollBtnView.didClickBtn = ^(UIButton *btn) {
        NSLog(@"click:%ld",btn.tag);
    };
    
    [self.view addSubview:_scrollBtnView];
}



@end
