//
//  XC_touchTextview.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_touchTextview.h"
#import "XCEmotionDefine.h"
#define HWStatusTextViewCoverTag 999


@implementation XCSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end

@interface XC_touchTextview()

@end

@implementation XC_touchTextview


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动, 让文字完全显示出来
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)setCilckHightColor:(UIColor *)cilckHightColor
{
    _cilckHightColor = cilckHightColor;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 触摸对象
    UITouch *touch = [touches anyObject];
    // 触摸点
    CGPoint point = [touch locationInView:self];    
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    BOOL contains = NO;
    XCLog(@"specials = %@" ,specials);
    
    for (XCSpecial *special in specials) {
        self.selectedRange = special.range;
        // self.selectedRange --影响--> self.selectedTextRange
        // 获得选中范围的矩形框
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
      
            if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串
                contains = YES;
                break;
            }
        }
        if (contains) {
            for (UITextSelectionRect *selectionRect in rects) {
                CGRect rect = selectionRect.rect;
                if (rect.size.width == 0 || rect.size.height == 0) continue;
                UIView *cover = [[UIView alloc] init];
                if (_cilckHightColor) {
                    cover.backgroundColor = _cilckHightColor ;
                }else{
                    cover.backgroundColor = [UIColor greenColor];
                }
                cover.frame = rect;
                cover.tag = HWStatusTextViewCoverTag;
                cover.layer.cornerRadius = 5;
                [self insertSubview:cover atIndex:0];
            }
            
            if ([self.cilckdelegate respondsToSelector:@selector(cilckOption:)]) {
                [self.cilckdelegate cilckOption:special.text];
            }
            XCLog(@"special = %@" ,special.text);
            break;
        }
    }
    // 在被触摸的特殊字符串后面显示一段高亮的背景
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 去掉特殊字符串后面的高亮背景
    for (UIView *child in self.subviews) {
        if (child.tag == HWStatusTextViewCoverTag) [child removeFromSuperview];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

@end
