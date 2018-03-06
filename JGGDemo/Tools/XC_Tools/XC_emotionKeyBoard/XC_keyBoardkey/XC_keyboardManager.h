//
//  XC_ keyboardTopTools.h
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
/*
     XC_EmojikeyBoardView 自定义表情键盘。 ---->做成了单例公用
 
     XC_keyboardManager 键盘管理类。
 */

#import <UIKit/UIKit.h>
#import "XC_EmotionInputView.h"
#import "XC_EmotionToolTabbar.h"
#import "XC_EmotionsView.h"
#import "XCWordChangeTool.h"
#import "XCEmotionDefine.h"
#import "XC_touchTextview.h"
@interface XC_keyboardManager : NSObject



/**  获取已经处理好了的UI键盘 ,风格    */
-(XC_EmotionInputView *)getXC_EmotionInputView;


/**   获取已经处理好了的UI键盘 ,风格 1    */
-(XC_EmotionsView *)getXC_emotionsView;

@end
