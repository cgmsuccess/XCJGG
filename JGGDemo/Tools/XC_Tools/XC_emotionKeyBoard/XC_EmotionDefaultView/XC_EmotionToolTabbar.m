//
//  XC_EmotionToolTabbar.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmotionToolTabbar.h"
#import "XCEmotionDefine.h"
@interface XC_EmotionToolTabbar()

@property (nonatomic, weak) UIButton *emotionButton;


@end

@implementation XC_EmotionToolTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

+(instancetype)shareCreatToolTababr
{
    XC_EmotionToolTabbar *topTababr = [[XC_EmotionToolTabbar alloc] init];
    topTababr.width = KmainScreenWidth ;
    topTababr.height = 44;
    return topTababr;
}

-(void)setUI
{
    UIImage *compose_toolbar_background = GETNSbunldINImage(@"XEmotionIcons", @"entionTabarImage", @"compose_toolbar_background");

    self.backgroundColor = [UIColor colorWithPatternImage:compose_toolbar_background];
    
    // 初始化按钮
    [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:XCTababrComposeToolbarButtonTypeCamera Andtitle:@""];
    
    [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:XCTababrComposeToolbarButtonTypePicture Andtitle:@""];
    
    [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:XCTababrComposeToolbarButtonTypeMention Andtitle:@""];
    
    [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:XCTababrComposeToolbarButtonTypeTrend Andtitle:@""];
    
    self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:XCTababrComposeToolbarButtonTypeEmotion Andtitle:@""];
    
    
    

    // 显示键盘图标
    NSString *   image = @"compose_keyboardbutton_background";
    NSString *    highImage = @"compose_keyboardbutton_background_highlighted";
    
    //选择状态下的普通状态
    UIImage *_image = GETNSbunldINImage(@"XEmotionIcons", @"entionTabarImage", image);
   //选择状态下的高亮状态
    UIImage *_highImage = GETNSbunldINImage(@"XEmotionIcons", @"entionTabarImage", highImage);


    [self.emotionButton setImage:_image forState:UIControlStateSelected];
    [self.emotionButton setImage:_highImage forState:UIControlStateHighlighted];
 
}




/**
 * 创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(XCTababrComposeToolbarType)type Andtitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    
    UIImage *_image = GETNSbunldINImage(@"XEmotionIcons", @"entionTabarImage", image);
    UIImage *_highImage = GETNSbunldINImage(@"XEmotionIcons", @"entionTabarImage", highImage);
    
    [btn setImage:_image forState:UIControlStateNormal];
    [btn setImage:_highImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}



//点击按钮 触发代理
- (void)btnClick:(UIButton *)btn
{

    //事件代理出去，
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
    
    if (btn.tag == XCTababrComposeToolbarButtonTypeEmotion) {
        btn.selected =! btn.selected ;
    }
}


@end
