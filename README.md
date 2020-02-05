# WJScrollButtonView

### 简介

**WJScrollButtonView**是一个类似即时通讯工具栏的可滑动小组件，可以根据传递的数据源，自动创建`scrollButton`，并能自动根据btn的数量来确定`pageControl`分页显示，以及按钮点击事件的回调处理。

### 安装

直接拖动Demo中`WJScrollButtonView`文件夹中的内容到Xcode相应的文件夹即可。

### 使用

```objc
CGFloat ViewH = 225;
CGRect frame = CGRectMake(0, SCREEN_HEIGHT-ViewH, SCREEN_WIDTH, ViewH);

_scrollBtnView = [[WJScrollButtonView alloc] initWithFrame:frame dataSource:self.dataSource];
    
_scrollBtnView.LineSpacing = 10;		// 设置行间距
_scrollBtnView.columnsSpacing = 10;		// 设置列间距
    
_scrollBtnView.didClickBtn = ^(UIButton *btn) {	// 回调block
    NSLog(@"click:%ld",btn.tag);
};
    
[self.view addSubview:_scrollBtnView];
```

### 功能图示

![example](https://github.com/jerrywangjing/WJScrollView/raw/master/screenShots/example.gif)

### 交流学习/欢迎issues

- 邮箱：wangjing268@163.com
- Blog: wjerry.com
- [简书](http://www.jianshu.com/u/187fc23bc390)
