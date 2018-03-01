//
//  XC_ keyboardTopTools.m
//  zhutong
//
//  Created by gao bin on 2018/2/6.
//  Copyright © 2018年 com.xc.zhutong. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


#import "XC_keyboardManager.h"
#import "XCEmotionModel.h"
#import "XC_EmojikeyBoardView.h"


CGFloat inputHeight = 34 ;//输入框的默认高度
CGFloat keyboardHeight = 216 ; //默认的键盘的高度

@interface XC_keyboardManager()

@property (nonatomic, weak) UIButton *emotionButton;

/**     表情键盘   ****/
@property (nonatomic,strong)XC_EmojikeyBoardView *emotionKeyboard;

/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;

/**    记录初始化的时候y 值      ****/
@property (nonatomic,assign)CGFloat keyBoardY ;

@end

@implementation XC_keyboardManager

+(instancetype)singLationKeyBoardManager
{
    static XC_keyboardManager* keyBoard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       keyBoard = [[XC_keyboardManager alloc] init];
    });
    return keyBoard ;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}


-(XC_EmojikeyBoardView *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[XC_EmojikeyBoardView alloc] init];
        // 键盘的宽度
        self.emotionKeyboard.width = KmainScreenWidth;
        self.emotionKeyboard.height = keyboardHeight;
        self.emotionKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _emotionKeyboard;
}


-(void)setUI
{
    //创建切换键盘
    self.emotionButton = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:XC_ComposeToolbarButtonTypeEmotion Andtitle:@""] ;
    
    //创建@
    [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:XC_ComposeToolbarButtonTypeMention Andtitle:@""];
   
    //创建发送
    [self setupBtn:@"nil" highImage:@"nil" type:XC_ComposeToolbarButtonTypeSend Andtitle:@"发送"];
    
    XC_EmotionTextView *inputTextView = [[XC_EmotionTextView alloc] init];
    inputTextView.tag = XC_ComposeToolbarButtonTypeInputView ;
    [inputTextView addBorder:[UIColor lightGrayColor] Andcircular:15];

   
    /**   监听表情被选中  */
    [XCNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:XC_EmotionDidSelectNotification object:nil];
    
    /**  键盘弹出   */
    [XCNotificationCenter  addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   
    /**   键盘隐藏  */
    [XCNotificationCenter  addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /**   监听删除按钮  */
    [XCNotificationCenter  addObserver:self selector:@selector(emotionDelete) name:XC_EmotionDidDeleteNotification object:nil];
    
    _keyBoardY = self.y ;
    
    [self addSubview:inputTextView];

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

/**  键盘弹出   */
- (void)keyboardWillShow:(NSNotification *)notification {
    
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat keyBoardHeight = keyboardRect.size.height ; //键盘高度
    self.y = KmainScreenHeiht - self.height - keyBoardHeight ;
    
}

/**  键盘隐藏   */
- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    if (!self.switchingKeybaord) {
        self.y = _keyBoardY ;
    }
}

/**  表情被选中了   */
- (void)emotionDidSelect:(NSNotification *)notification
{
    XCEmotionModel *emotion = notification.userInfo[XC_SelectEmotionKey];
//    XCLog(@"emotion.chs = %@" ,emotion.chs);
    XC_EmotionTextView *inputTextView = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
//    inputTextView.text = [NSString stringWithFormat:@"%@%@",inputTextView.text,emotion.chs];
    [inputTextView insertEmotion:emotion];
}

/**   删除  */
-(void)emotionDelete
{
    XC_EmotionTextView *inputTextView = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    [inputTextView deleteBackward];
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
    XC_EmotionTextView *inputTextView = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
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

-(XC_EmotionTextView *)showXCKeyboard
{
    XC_EmotionTextView *textview = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
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
    XC_EmotionTextView *textview = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];

    //事件代理出去，
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }

    switch (btn.tag) {
        case XC_ComposeToolbarButtonTypeEmotion:
            //表情
            [self switchKeyboard];
            break;
        case XC_ComposeToolbarButtonTypeMention:
            //@
            [self endEditing:YES];
            
            break;
        case XC_ComposeToolbarButtonTypeSend:
            //发送
            textview.text = @"";
            [self endEditing:YES];
            break;
        default:
            break;
    }
}

//切换键盘
-(void)switchKeyboard
{
    XC_EmotionTextView *inputTextView = [self viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    // _xc_textView.inputView == nil : 使用的是系统自带的键盘
    if (inputTextView.inputView == nil) { // 切换为自定义的表情键盘
        inputTextView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.showKeyboardButton = YES;
    } else { // 切换为系统自带的键盘
        inputTextView.inputView = nil;
        // 显示表情按钮
        self.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [inputTextView endEditing:YES];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [inputTextView becomeFirstResponder];
    });
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

- (void)dealloc{
   
    [XCNotificationCenter removeObserver:self name:XC_EmotionDidSelectNotification object:nil];
    [XCNotificationCenter removeObserver:self name:XC_EmotionDidDeleteNotification object:nil];
    [XCNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [XCNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end

