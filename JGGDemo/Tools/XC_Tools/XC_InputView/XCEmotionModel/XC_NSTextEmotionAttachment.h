//
//  XC_NSTextEmotionAttachment.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/24.
//  Copyright © 2018年 apple. All rights reserved.
/*
 继承 NSTextAttachment  ，给他绑定个模型
 为了把图片和  富文本 联系起来进行传值
*/


#import <UIKit/UIKit.h>

#import "XCEmotionModel.h"

@interface XC_NSTextEmotionAttachment : NSTextAttachment

@property (nonatomic, strong) XCEmotionModel *emotionModel;


@end
