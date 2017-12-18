//
//  XC_JGGView.h
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XCPhotoWH 70 //每个图片大小
#define XCPhotoMargin 10  //间隔
#define XCPhotoMaxCol(count) (count==1?1:(count==4)?2:3)  

@interface XC_JGGView : UIView

/** 这个属性是：图片的数据源****/
@property (nonatomic,strong)NSMutableArray *dataSource ;

/** 这个属性是：有且只有一个选项的时候，设置选项的宽高 ****/
@property (nonatomic,assign)NSInteger OnlyOneOptionalWH;

/** 这个属性是：底图****/
@property (nonatomic,strong)UIImage *placeholderImage;

/** 这个属性是：点击选项回调 ****/
@property (nonatomic,copy)void(^cilckhandle)(NSInteger index ,NSMutableArray *dataSource) ;


/**
 根据图片个数返回尺寸 

 @param optionsCount 图片个数
 @return 尺寸
 */
-(CGSize)setDtasouce:(NSInteger )optionsCount;



@end
