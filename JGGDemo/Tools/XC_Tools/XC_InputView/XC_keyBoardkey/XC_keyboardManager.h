//
//  XC_ keyboardTopTools.h
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XC_TextView.h"
#import "XC_EmotionTextView.h"

typedef NS_ENUM(NSInteger,XC_ComposeToolbarButtonType){
    XC_ComposeToolbarButtonTypeEmotion = 0, // 表情
    XC_ComposeToolbarButtonTypeMention, // @
    XC_ComposeToolbarButtonTypeSend, // 发送
    XC_ComposeToolbarButtonTypeInputView //输入框
};


@class XC_keyboardManager;
@protocol XCComposeToolbarTopDelegate <NSObject>


@optional
/*  通过代理传递此view 和点击的按钮   **/
- (void)composeToolbar:(XC_keyboardManager *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType;
@end


@interface XC_keyboardManager : UIView

@property (nonatomic, weak) id<XCComposeToolbarTopDelegate> delegate;


/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

/**    实时回调，输入的文字，和需要的高度      ****/
@property (nonatomic,copy)void(^stringAndHeightHandle)(NSString *inputString,CGFloat height);

/**  单利，创建   */
+(instancetype)singLationKeyBoardManager;

/*  设置为 输入框为第一响应者  ,返回输入框 **/
-(XC_EmotionTextView *)showXCKeyboard;


@end
