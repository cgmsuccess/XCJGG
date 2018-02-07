//
//  XC_EmojiTabarCollectionViewCell.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmojiTabarCollectionViewCell.h"

@implementation XC_EmojiTabarCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    UIView *backView = [UIView new];
    self.backView = backView;
    [self addSubview:backView];
    
    UIImageView *imageview = [[UIImageView  alloc] init];
    self.backImageView = imageview;
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.clipsToBounds = YES;
    
    [self.backView addSubview:self.backImageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.right.offset(-5);
        make.top.offset(5);
        make.bottom.offset(-5);
    }];

}

@end
