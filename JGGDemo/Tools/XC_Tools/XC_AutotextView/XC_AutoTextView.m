//
//  XC_AutoTextView.m
//  JGGDemo
//
//  Created by 陈桂民 on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XC_AutoTextView.h"

@interface XC_AutoTextView()

@property (nonatomic,strong)XC_TextView *xcTextView;

@end

@implementation XC_AutoTextView

#pragma mark Lazy
-(XC_TextView *)xcTextView
{
    if (!_xcTextView) {
        _xcTextView = [[XC_TextView alloc] init];
        _xcTextView.layer.masksToBounds = YES ;
        _xcTextView.layer.cornerRadius = 6;
        _xcTextView.layer.borderWidth = 0.1;
        _xcTextView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _xcTextView;
}


+(instancetype)showAutopinputTextView
{
    XC_AutoTextView *autotextView = [[XC_AutoTextView alloc] init];
    
    return autotextView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.xcTextView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
