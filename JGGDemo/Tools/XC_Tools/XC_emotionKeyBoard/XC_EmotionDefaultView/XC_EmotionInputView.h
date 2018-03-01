//
//  XC_EmotionInputView.h
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XC_EmotionTextView.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

typedef NS_ENUM(NSInteger,XC_ComposeToolbarButtonType){
    XC_ComposeToolbarButtonTypeEmotion = 0, // 表情
    XC_ComposeToolbarButtonTypeMention, // @
    XC_ComposeToolbarButtonTypeSend, // 发送
    XC_ComposeToolbarButtonTypeInputView //输入框
};


@class XC_EmotionInputView;
@protocol XCComposeToolbarTopDelegate <NSObject>


@optional
/*  通过代理传递此view 和点击的按钮   **/
- (void)composeToolbar:(XC_EmotionInputView *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType;
@end

@interface XC_EmotionInputView : UIView

@property (nonatomic, weak) id<XCComposeToolbarTopDelegate> delegate;


/**    设置初始化的时候y 值 ，键盘没有弹出的时候，创建view的Y值，一定要手动设置      ****/
@property (nonatomic,assign)CGFloat keyBoardY ;

/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

/**    实时回调，输入的文字，和需要的高度      ****/
@property (nonatomic,copy)void(^stringAndHeightHandle)(NSString *inputString,CGFloat height);


/*  设置为 输入框为第一响应者  ,返回输入框 **/
-(XC_EmotionTextView *)showXCKeyboard;



@end
