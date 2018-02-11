//
//  XC_pageShowemotionView.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_pageShowemotionView.h"

@interface XC_pageShowemotionView()

/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation XC_pageShowemotionView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    // 1.删除按钮
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
    
    // 2.添加长按手势
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
}


-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions ;
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        XC_EmotionButton *btn = [[XC_EmotionButton alloc] init];
        [self addSubview:btn];
        XCEmotionModel *model = emotions[i];
        // 设置表情数据
        btn.emotionModel = model ;
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / XC_EmotionMaxCols;
    CGFloat btnH = (self.height - inset) / XC_EmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%XC_EmotionMaxCols) * btnW;
        btn.y = inset + (i/XC_EmotionMaxCols) * btnH;
    }
    
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
    
}


/**
 *  监听删除按钮点击
 */
- (void)deleteClick
{
    [XCNotificationCenter postNotificationName:XC_EmotionDidDeleteNotification object:nil];
}
/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
- (void)btnClick:(XC_EmotionButton *)btn
{
    XCLog(@"%@",btn.emotionModel);
    
    // 发出通知
    [self selectEmotion:btn.emotionModel];
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
- (void)selectEmotion:(XCEmotionModel *)emotion
{
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[XC_SelectEmotionKey] = emotion;

    XCLog(@"userInfo = %@ , emotion = %@" ,userInfo ,emotion);
    
    [XCNotificationCenter postNotificationName:XC_EmotionDidSelectNotification object:nil userInfo:userInfo];
}


@end
