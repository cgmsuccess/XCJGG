//
//  XC_EmotionToolTabbar.h
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//  借鉴小码哥的。这里自己写一下，当做学习

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XCTababrComposeToolbarType) {
    XCTababrComposeToolbarButtonTypeCamera, // 拍照
    XCTababrComposeToolbarButtonTypePicture, // 相册
    XCTababrComposeToolbarButtonTypeMention, // @
    XCTababrComposeToolbarButtonTypeTrend, // #
    XCTababrComposeToolbarButtonTypeEmotion // 表情
};


@class XC_EmotionToolTabbar;

@protocol xc_emotionTooltababrDelegate<NSObject>

@optional
//点击按钮的协议
- (void)composeToolbar:(XC_EmotionToolTabbar *)toolbar didClickButton:(XCTababrComposeToolbarType)buttonType;

@end

@interface XC_EmotionToolTabbar : UIView


@property (nonatomic, weak) id<xc_emotionTooltababrDelegate> delegate;

/**   快速创建。  */
+(instancetype)shareCreatToolTababr;




@end
