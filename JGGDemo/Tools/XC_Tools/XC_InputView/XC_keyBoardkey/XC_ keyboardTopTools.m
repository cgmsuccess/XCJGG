//
//  XC_ keyboardTopTools.m
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


#import "XC_ keyboardTopTools.h"

CGFloat inputHeight = 34 ;//输入框的默认高度

@interface XC__keyboardTopTools()

@property (nonatomic, weak) UIButton *emotionButton;

/**    输入框的默认高度      ****/
@property (nonatomic,assign)CGFloat inputTextHeight ;

@end

@implementation XC__keyboardTopTools



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:XC_ComposeToolbarButtonTypeEmotion Andtitle:@""] ;
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:XC_ComposeToolbarButtonTypeMention Andtitle:@""];
        
        
        [self setupBtn:@"nil" highImage:@"nil" type:XC_ComposeToolbarButtonTypeSend Andtitle:@"发送"];
        
        XC_TextView *inputTextView = [[XC_TextView alloc] init];
        inputTextView.tag = XC_ComposeToolbarButtonTypeInputView ;
        [inputTextView addBorder:[UIColor lightGrayColor] Andcircular:15];
        self.inputTextHeight = inputHeight ; //默认输入框高度为 34
        
        [self addSubview:inputTextView];
    }
    return self;
}


/**
 * 创建一个按钮
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(XC_ComposeToolbarButtonType)type Andtitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

- (void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    // 设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}

-(void)layoutSubviews
{
    NSArray *arr = self.subviews;
    //emoji
    UIButton *emojiBtn = arr[XC_ComposeToolbarButtonTypeEmotion];
    [emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.bottom.offset(-10);
        make.height.mas_offset(24);
        make.width.mas_offset(48);
        
    }];
    
    /*   @  **/
    UIButton *MentionBtn = arr[XC_ComposeToolbarButtonTypeMention];
    [MentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(emojiBtn.mas_left).offset(-60);
        make.height.mas_offset(24);
        make.width.mas_offset(48);
    }];
    
    /*  发送   **/
    UIButton *SendBtn = arr[XC_ComposeToolbarButtonTypeSend];
    [SendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    SendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [SendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-44);
        make.right.offset(-10);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(24);
    }];
    
    /*   输入框  **/
    XC_TextView *inputTextView = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    inputTextView.maxInputWord = 100; //最大输入100.默认不限
    inputTextView.placeholderString = @"请输入";
    [inputTextView setPlaceHolderOffsetY:8];
    
    [inputTextView setPlaceholderColor:[UIColor lightGrayColor]];
    [inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(SendBtn.mas_bottom).offset(0);
        make.right.equalTo(SendBtn.mas_left).offset(-8);
        make.left.offset(10);
        make.top.offset(10);
    }];
    
    WS(weakSelf);
    //输入字的实时回调
    inputTextView.inputTextHandle = ^(NSString *inputString) {
        
        CGFloat textViewHeight = [weakSelf autoHeightWithString:inputString Width:KmainScreenWidth - 48 - 10 - 10 - 8 Font:14];
        XCLog(@"textViewHeight = %lf" ,textViewHeight) ;
        weakSelf.stringAndHeightHandle(inputString, textViewHeight);
    };
}

-(XC_TextView *)showXCKeyboard
{
    XC_TextView *textview = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    [textview becomeFirstResponder];
    return textview;
}


/*   计算高度  **/
- (CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(NSInteger)font {
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.height;
}

//点击按钮 触发代理
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
       
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}



-(void)drawRect:(CGRect)rect
{
    [self drawLine];
}

//画顶部直线
-(void)drawLine
{
    //1 , 获取上下文 以后获取上下文直接用 UIGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2 , 设置绘图信息（拼接路径）
    UIBezierPath *path = [UIBezierPath bezierPath];
    //3 , 设置起点
    [path moveToPoint:CGPointMake(0, 0)];
    //添加一条线到某个点
    [path addLineToPoint:CGPointMake(self.size.width, 0)];
    //    [path addLineToPoint:CGPointMake(100, 180)];
    [[UIColor lightGrayColor] setStroke];

    //4 ,把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //5 , 渲染上下文 stroke描边
    CGContextStrokePath(ctx);
}

@end

