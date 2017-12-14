//
//  XC_JGGView.h
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XC_JGGView : UIView

/** 这个属性是：图片的数据源****/
@property (nonatomic,strong)NSMutableArray *dataSource ;

/** 这个属性是：有且只有一个选项的时候，设置选项的宽高 ****/
@property (nonatomic,assign)NSInteger OnlyOneOptionalWH;

/**
 根据图片个数返回尺寸

 @param optionsCount 图片个数
 @return 尺寸
 */
-(CGSize)setDtasouce:(NSInteger )optionsCount;

@end
