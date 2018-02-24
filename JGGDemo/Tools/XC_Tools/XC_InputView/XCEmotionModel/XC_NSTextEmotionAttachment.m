//
//  XC_NSTextEmotionAttachment.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_NSTextEmotionAttachment.h"
#import "XCEmotionTool.h"
@implementation XC_NSTextEmotionAttachment

-(void)setEmotionModel:(XCEmotionModel *)emotionModel
{
    _emotionModel = emotionModel;
    
    self.image = [XCEmotionTool getSelectEmtionImage:emotionModel];
}

@end
