//
//  XC_EmotionsView.h
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XC_EmotionToolTabbar.h"



@protocol XC_emotionViewDelegate<NSObject>

@optional
//点击按钮的协议
- (void)composeToolbarCilck:(XC_EmotionToolTabbar *)toolbar didClickButton:(XCTababrComposeToolbarType)buttonType;


@end

@interface XC_EmotionsView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

/**    设置frame      ****/
@property (nonatomic)CGRect rectFrame;


/**    topTabar 点击协议     ****/
@property (nonatomic,weak)id<XC_emotionViewDelegate> delegate ;

/**  设置为第一响应者   */
-(void)XC_emotionBecomeFirstResponder;

/**  获得输入的文字   */
-(NSString *)getInputWord;

@end
