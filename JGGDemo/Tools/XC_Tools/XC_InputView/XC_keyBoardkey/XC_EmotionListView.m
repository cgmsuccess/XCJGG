//
//  XC_EmotionListView.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmotionListView.h"
#import "XC_pageShowemotionView.h"
@interface XC_EmotionListView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation XC_EmotionListView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}


// 根据emotions，创建对应个数的表情
- (void)setEmotionArrs:(NSArray *)EmotionArrs
{
    _EmotionArrs = EmotionArrs;
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //计算页数
    NSUInteger count = (EmotionArrs.count + XC_EmotionPageSize - 1) / XC_EmotionPageSize;
    // 1.设置页数
    self.pageControl.numberOfPages = count;
    //    self.pageControl.numberOfPages = count > 1? count : 0;
    
    // 2.创建用来显示每一页表情的控件
    for (int i = 0; i<count; i++) {
        XC_pageShowemotionView *pageView = [[XC_pageShowemotionView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * XC_EmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = EmotionArrs.count - range.location;
        if (left >= XC_EmotionPageSize) { // 这一页足够20个
            range.length = XC_EmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        pageView.emotions = [EmotionArrs subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }

    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    // 1.pageControl
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(KmainScreenWidth);
        make.height.mas_equalTo(@25);
        make.left.offset(0);
        make.bottom.offset(0);
    }];

    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - 25;
    self.scrollView.x = self.scrollView.y = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        XC_pageShowemotionView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

@end
