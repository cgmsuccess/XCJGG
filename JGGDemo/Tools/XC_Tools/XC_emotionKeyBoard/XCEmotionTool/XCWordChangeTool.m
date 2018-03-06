//
//  XCWordChangeTool.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XCWordChangeTool.h"
#import "RegexKitLite.h"  //正则框架
#import "XCtextExchangeAttachModel.h"
#import "XCEmotionTool.h"
#import "XCEmotionModel.h"
#import "XC_touchTextview.h"


NSInteger labelFont = 15;

@implementation XCWordChangeTool

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
+(NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    /**
     这里替换表情。时间上是，用正则把特殊的和非特殊的字符串取出来，然后根据  loaction 位置进行排序。在重新拼接成为
     一个新的属性字符串。这样 不会因为替换表情等，导致实际长度的不准确，
     **/
    

    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    NSMutableArray *specials = [NSMutableArray array];

    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XCtextExchangeAttachModel *part = [[XCtextExchangeAttachModel alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XCtextExchangeAttachModel *part = [[XCtextExchangeAttachModel alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(XCtextExchangeAttachModel *part1, XCtextExchangeAttachModel *part2) {
        // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
        // 返回NSOrderedSame:两个一样大
        // NSOrderedAscending(升序):part2>part1
        // NSOrderedDescending(降序):part1>part2
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2
        // part1放前面, part2放后面
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:labelFont];
    // 按顺序拼接每一段文字
    for (XCtextExchangeAttachModel *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            //根据匹配的特殊字符串，找到对应图片名字
            XCEmotionModel *emotionsModel = [XCEmotionTool emotionWithChs:part.text];
            NSString *name = emotionsModel.png;

            if (name) { // 能找到对应的图片
                
                attch.image = [XCEmotionTool getSelectEmtionImage:emotionsModel];
                
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
          
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor redColor]                                                                                       }];

            
                                                                                       
           // 创建特殊对象
           XCSpecial *s = [[XCSpecial alloc] init];
           s.text = part.text;
           NSUInteger loc = attributedText.length;
           NSUInteger len = part.text.length;
           s.range = NSMakeRange(loc, len);
           [specials addObject:s];
                                                                                       
                                                                                       
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];

    return attributedText;
}


/*  普通文字 计算高度  **/
+(CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(NSInteger)font {
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.height ;
}

/**  富文本计算高度   */
+(CGFloat )autoHeightWithAttrebutString:(NSAttributedString *)attributStr AndscreenWidth:(CGFloat)screenWidth
{
    CGSize contentSize = [attributStr boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return contentSize.height + 21 ;
}



@end
