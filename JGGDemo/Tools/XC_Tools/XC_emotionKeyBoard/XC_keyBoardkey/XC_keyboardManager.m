//
//  XC_ keyboardTopTools.m
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
//



#import "XC_keyboardManager.h"

@interface XC_keyboardManager()

/**    XC_EmotionInputView    默认的表情键盘输入  ****/
@property (nonatomic,strong)XC_EmotionInputView  *defaultInputView;


@end

@implementation XC_keyboardManager


+(instancetype)singLationMananger
{
    static dispatch_once_t onceToken;
    static XC_keyboardManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager ;
}

-(XC_EmotionInputView *)defaultInputView
{
    if (!_defaultInputView) {
        _defaultInputView = [[XC_EmotionInputView alloc] init];
    }
    return _defaultInputView ;
}

-(XC_EmotionInputView *)getXC_EmotionInputView
{
    return self.defaultInputView;
}

@end

