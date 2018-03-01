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


//插入图片模型到UItextView 并显示
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

- (NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    // 遍历所有的属性文字（图片、emoji、普通文字）
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        // 如果是图片表情
        XC_NSTextEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) { // 图片
            [fullText appendString:attch.emotionModel.chs];
        } else { // emoji、普通文本
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}


@end
