//
//  XC_ keyboardTopTools.h
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XC_EmotionInputView.h"


@interface XC_keyboardManager : NSObject

+(instancetype)singLationMananger;


/**  获取已经处理好了的UI键盘   */
-(XC_EmotionInputView *)getXC_EmotionInputView;



@end
