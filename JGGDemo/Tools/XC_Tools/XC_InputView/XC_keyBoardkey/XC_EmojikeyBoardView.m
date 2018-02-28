//
//  XC_EmojikeyBoardView.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmojikeyBoardView.h"
#import "XC_EmojikeyTabbar.h" // 表情 tabbar
#import "XC_EmotionListView.h" //表情展示view
#import "XCEmotionTool.h"

@interface XC_EmojikeyBoardView()<XCEmotionTabBarDelegate,UIScrollViewDelegate>

/** 当前显示listView */
@property (nonatomic, weak) XC_EmojikeyTabbar *showingListView;

/**    表情切换tabbar      ****/
@property (nonatomic,strong)XC_EmojikeyTabbar *emojiTabar;

/**    最近使用表情内容      ****/
@property (nonatomic,strong)XC_EmotionListView *recentListView ;

/**    默认表情内容      ****/
@property (nonatomic,strong)XC_EmotionListView *defaultListView ;

/**    浪小花表情内容      ****/
@property (nonatomic,strong)XC_EmotionListView *lxhListView ;

/**    QQ表情内容      ****/
@property (nonatomic,strong)XC_EmotionListView *qqListView ;

/**   表情父视图  */
@property (nonatomic, weak) UIScrollView *scrollView;


@end

@implementation XC_EmojikeyBoardView

//code
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setConfiger];
    }
    return self;
}

//xib
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setConfiger];
    }
    return self;
}

/**  最近使用的表情内容   */
-(XC_EmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[XC_EmotionListView alloc] init];
    }
    return _recentListView ;
}

/*   切换表情的 tababr  **/
-(XC_EmojikeyTabbar *)emojiTabar
{
    if (!_emojiTabar) {
        _emojiTabar = [[XC_EmojikeyTabbar alloc] init];
    }
    return _emojiTabar;
}

/*  默认表情   **/
-(XC_EmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[XC_EmotionListView alloc] init];
        _defaultListView.EmotionArrs = [XCEmotionTool defaultEmotions];
    }
    return _defaultListView;
}


#warning DOTO 这里设置了异步读取图片数据，有几率照常，键盘的图片为空
/**   浪小花表情  */
-(XC_EmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[XC_EmotionListView alloc] init];
        _lxhListView.EmotionArrs = [XCEmotionTool lxhEmtions];

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        });
    }
    return _lxhListView;
}

/**  qq默认表情   */
-(XC_EmotionListView *)qqListView
{
    if (!_qqListView) {
        _qqListView = [[XC_EmotionListView alloc] init];
        _qqListView.EmotionArrs = [XCEmotionTool qqEmtions];

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        });
    }
    return _qqListView;
}

/*  配置UI   **/
-(void)setConfiger
{
    //装载表情的父视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    // 去除水平方向的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 去除垂直方向的滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO ; //关闭弹簧
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollView];

    
    self.emojiTabar.backgroundColor = [UIColor clearColor];
    self.emojiTabar.delegate = self;
   
    //设置tabbar的展示图片
    self.emojiTabar.dataSource = [NSMutableArray arrayWithArray:@[@"w_taiyang.png",@"d_haha.png",@"lxh_xiaohaha.png",@"[15].png"]];
    //设置默认选中第二个表情图
    self.emojiTabar.defaultEmtionType = XC_EmojikeyTabbarCilckTypeDefault ;
    [self addSubview:_emojiTabar];
  
    [self.scrollView addSubview:self.recentListView];
    self.recentListView.backgroundColor = [UIColor clearColor];
    
    [self.scrollView addSubview:self.defaultListView];
    self.defaultListView.backgroundColor = [UIColor clearColor];
    
    [self.scrollView addSubview:self.lxhListView];
    self.lxhListView.backgroundColor = [UIColor clearColor];
    
    [self.scrollView addSubview:self.qqListView];
    self.qqListView.backgroundColor = [UIColor clearColor];
}

#pragma mark - scrollViewDelegate 动态切换tabbar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    [self.emojiTabar switchemotion:(int)(pageNo + 0.5)];
}

#pragma mark XCEmotionTabBarDelegate  点击tabbar 的表情
-(void)cilckEmotionsTabbar:(XC_EmojikeyTabbar *)emotionsTabbarView AndcilckIndex:(XC_EmojikeyTabbarCilckType)emotionTabbarType
{
    
    switch (emotionTabbarType) { //最近使用的表情
        case XC_EmojikeyTabbarCilckTypeRecent:
            [self.scrollView setContentOffset:CGPointMake(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeRecent, 0)];
            break;
            
        case XC_EmojikeyTabbarCilckTypeDefault: //默认表情
            [self.scrollView setContentOffset:CGPointMake(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeDefault, 0)];
            break;
            
        case XC_EmojikeyTabbarCilckTypeLxh: //浪小花
            [self.scrollView setContentOffset:CGPointMake(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeLxh, 0)];
            break;
        case XC_EmojikeyTabbarCilckTypeQQ:
            [self.scrollView setContentOffset:CGPointMake(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeQQ, 0)];
            break;
            
        default:
            break;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //tabbar 
    [self.emojiTabar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(37);
    }];
    
    //scorllview
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.equalTo(self.emojiTabar.mas_top).offset(0);
    }];
    
    //默认的表情内容
    [self.defaultListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeDefault);
        make.bottom.equalTo(self.emojiTabar.mas_top).offset(0);
        make.width.mas_equalTo(KmainScreenWidth);
    }];
    
    //lxh 表情
    [self.lxhListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeLxh);
        make.bottom.equalTo(self.emojiTabar.mas_top).offset(0);
        make.width.mas_equalTo(KmainScreenWidth);
    }];
    
    //qq 默认表情
    [self.qqListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(KmainScreenWidth * XC_EmojikeyTabbarCilckTypeQQ);
        make.bottom.equalTo(self.emojiTabar.mas_top).offset(0);
        make.width.mas_equalTo(KmainScreenWidth);
    }];
    
    
    self.scrollView.contentSize = CGSizeMake(self.emojiTabar.dataSource.count  * KmainScreenWidth, 0);
}

@end
