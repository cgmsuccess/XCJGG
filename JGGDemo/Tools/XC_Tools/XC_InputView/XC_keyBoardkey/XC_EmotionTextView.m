//
//  XC_EmotionTextView.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmotionTextView.h"
#import "UITextView+XCextention.h"
#import "XC_NSTextEmotionAttachment.h"

@implementation XC_EmotionTextView


//插入图片模型到UItextFile 并显示
-(void)insertEmotion:(XCEmotionModel *)emotion
{
    XC_NSTextEmotionAttachment *xc_arrach = [[XC_NSTextEmotionAttachment alloc] init];
    xc_arrach.emotionModel = emotion ; //绑定模型
    
    // 设置图片的尺寸
    CGFloat attchWH = self.font.lineHeight;
    xc_arrach.bounds = CGRectMake(0, -4, attchWH, attchWH);
 
    // 根据附件创建一个属性文字
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:xc_arrach];
    
    // 插入属性文字到光标位置
    [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
        // 设置字体
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    }];
}


@end
