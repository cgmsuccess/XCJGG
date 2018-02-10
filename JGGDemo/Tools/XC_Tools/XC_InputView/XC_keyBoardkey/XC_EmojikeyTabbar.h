//
//  XC_EmojikeyToobar.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,XC_EmojikeyTabbarCilckType) {
    XC_EmojikeyTabbarCilckTypeRecent,//最近
    XC_EmojikeyTabbarCilckTypeDefault,//默认
    XC_EmojikeyTabbarCilckTypeLxh //浪小花
};


@class XC_EmojikeyTabbar;
@protocol XCEmotionTabBarDelegate <NSObject>

@required

/**
 点击表情底部tababar,按钮。代理

 @param emotionsTabbarView XC_EmojikeyTabbar
 @param emotionTabbarType XC_EmojikeyTabbarCilckType具体哪个
 */
-(void)cilckEmotionsTabbar:(XC_EmojikeyTabbar *)emotionsTabbarView AndcilckIndex:(XC_EmojikeyTabbarCilckType)emotionTabbarType;


@end

@interface XC_EmojikeyTabbar : UIView

/**    默认选择哪个表情      ****/
@property (nonatomic,assign)XC_EmojikeyTabbarCilckType defaultEmtionType ;

/**    tabar选项的图片数据      ****/
@property (nonatomic,copy)NSMutableArray *dataSource;

/**          ****/
@property (nonatomic,weak)id <XCEmotionTabBarDelegate> delegate;



@end
