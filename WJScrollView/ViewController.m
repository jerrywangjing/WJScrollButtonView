//
//  ViewController.m
//  WJScrollView
//
//  Created by JerryWang on 2016/12/20.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "ViewController.h"
#import "CustomerScrollView.h"
#import "UIView+WJExtension.h"

#define ViewH 225

@interface ViewController ()

@property (nonatomic,strong) CustomerScrollView * btnScrollView;
@property (nonatomic,strong) NSArray * dataArr;
@end

@implementation ViewController

-(NSArray *)dataArr{
    
    if (!_dataArr) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
        _dataArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArr;
}

-(CustomerScrollView *)btnScrollView{
    
    if (!_btnScrollView) {
        _btnScrollView = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, self.view.height-ViewH, self.view.width, ViewH)];
        
    }
    return _btnScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btnScrollView];
}

@end
