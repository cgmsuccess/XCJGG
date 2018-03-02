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

/**      已经处理好了的表情键盘输入     ****/
@property (nonatomic,strong)XC_EmotionsView *emotionsStyletwo;

@end

@implementation XC_keyboardManager


-(XC_EmotionInputView *)defaultInputView
{
    if (!_defaultInputView) {
        _defaultInputView = [[XC_EmotionInputView alloc] init];
    }
    return _defaultInputView ;
}

-(XC_EmotionsView *)emotionsStyletwo
{
    if (!_emotionsStyletwo) {
        _emotionsStyletwo = [[XC_EmotionsView alloc] init];
    }
    return _emotionsStyletwo;
}

-(XC_EmotionInputView *)getXC_EmotionInputView
{
    return self.defaultInputView;
}

-(XC_EmotionsView *)getXC_emotionsView
{
    return self.emotionsStyletwo;
}

@end

