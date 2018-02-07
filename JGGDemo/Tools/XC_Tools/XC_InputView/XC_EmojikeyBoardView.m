//
//  XC_EmojikeyBoardView.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmojikeyBoardView.h"
#import "XC_EmojikeyTabbar.h"

@interface XC_EmojikeyBoardView()

/**    tabbar      ****/
@property (nonatomic,strong)XC_EmojikeyTabbar *emojiTabar;

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

-(XC_EmojikeyTabbar *)emojiTabar
{
    if (!_emojiTabar) {
        _emojiTabar = [[XC_EmojikeyTabbar alloc] init];
    }
    return _emojiTabar;
}

-(void)setConfiger
{
    self.backgroundColor = [UIColor redColor];
    self.emojiTabar.backgroundColor = [UIColor blueColor];
    self.emojiTabar.dataSource = [NSMutableArray arrayWithArray:@[@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted",@"compose_mentionbutton_background_highlighted"]];
    [self addSubview:_emojiTabar];
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

}

@end
