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

@interface XC_EmojikeyBoardView()<XCEmotionTabBarDelegate>

/** 当前显示listView */
@property (nonatomic, weak) XC_EmojikeyTabbar *showingListView;

/**    表情切换tabbar      ****/
@property (nonatomic,strong)XC_EmojikeyTabbar *emojiTabar;

/**    表情内容      ****/
@property (nonatomic,strong)XC_EmotionListView *defaultListView ;


@end

@implementation XC_EmojikeyBoardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setConfiger];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setConfiger];
    }
    return self;
}

/*   切换表情的 tababr  **/
-(XC_EmojikeyTabbar *)emojiTabar
{
    if (!_emojiTabar) {
        _emojiTabar = [[XC_EmojikeyTabbar alloc] init];
    }
    return _emojiTabar;
}

/*  默认标上去   **/
-(XC_EmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[XC_EmotionListView alloc] init];
    }
    return _defaultListView;
}


/*  配置UI   **/
-(void)setConfiger
{
    self.backgroundColor = [UIColor redColor];
    self.emojiTabar.backgroundColor = [UIColor blueColor];
    self.emojiTabar.dataSource = [NSMutableArray arrayWithArray:@[@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted"]];
    [self addSubview:_emojiTabar];
    
    [self addSubview:self.defaultListView];
    self.defaultListView.EmotionArrs = [XCEmotionTool defaultEmotions];
    self.defaultListView.backgroundColor = [UIColor cyanColor];
    
}



#pragma mark XCEmotionTabBarDelegate  点击tabbar 的表情
-(void)cilckEmotionsTabbar:(XC_EmojikeyTabbar *)emotionsTabbarView AndcilckIndex:(XC_EmojikeyTabbarCilckType)emotionTabbarType
{
    switch (emotionTabbarType) {
        case XC_EmojikeyTabbarCilckTypeRecent:
            
            break;
        case XC_EmojikeyTabbarCilckTypeDefault:
            
            break;
            
        case XC_EmojikeyTabbarCilckTypeLxh:
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
    
    //表情内容
    [self.defaultListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.equalTo(self.emojiTabar.mas_top).offset(0);
    }];
    

}

@end
