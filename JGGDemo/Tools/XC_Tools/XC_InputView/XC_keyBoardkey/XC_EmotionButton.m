//
//  XC_EmotionButton.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmotionButton.h"

@implementation XC_EmotionButton

/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
    // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
    //    self.adjustsImageWhenDisabled
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)setEmotionModel:(XCEmotionModel *)emotionModel
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"XEmotionIcons" ofType:@"bundle"];
    NSString * path;

    switch (emotionModel.xcemotionType) {
        case XCentionModelTypeDefault: //默认表情
            path = [NSString stringWithFormat:@"%@/default",bundlePath];
            break;
        case XCentionModelTypeLxh:
            path = [NSString stringWithFormat:@"%@/lxh",bundlePath];
            break;
        case XCentionModelTypeQQ:
            path = [NSString stringWithFormat:@"%@/QQEmotion",bundlePath];

            break;
        default:
            break;
    }
    
    UIImage *img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,emotionModel.png]];

    [self setImage:img forState:UIControlStateNormal];
}

@end
