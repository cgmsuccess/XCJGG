//
//  XC_EmotionsView.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmotionsView.h"
#import "XC_EmojikeyBoardView.h"
#import "XC_EmotionTextView.h"



@interface XC_EmotionsView()<xc_emotionTooltababrDelegate,UITextViewDelegate>

/**      tabbar    ****/
@property (nonatomic,strong)XC_EmotionToolTabbar *topTababrView;

/**     表情键盘     ****/
@property (nonatomic,strong)XC_EmojikeyBoardView *emotionKeyBoardview;

/**     输入框     ****/
@property (nonatomic,strong)XC_EmotionTextView *emotionTextview;

/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;

@end

@implementation XC_EmotionsView

/**  自定义键盘   */
-(XC_EmojikeyBoardView *)emotionKeyBoardview
{
    if (!_emotionKeyBoardview) {
        _emotionKeyBoardview = [XC_EmojikeyBoardView shareKeyBoardManager];
        // 键盘的宽度
        _emotionKeyBoardview.width = KmainScreenWidth;
        _emotionKeyBoardview.height = keyboardHeight;
        _emotionKeyBoardview.backgroundColor = [UIColor whiteColor];
    }
    return _emotionKeyBoardview;
}

/**  富文本输入框   */
-(XC_EmotionTextView *)emotionTextview
{
    if (!_emotionTextview) {
        _emotionTextview = [[XC_EmotionTextView alloc] init];
        _emotionTextview.placeholderString = @"请输入";
        _emotionTextview.placeholderColor = [UIColor grayColor];
        _emotionTextview.placeHolderOffsetY = 5;
        _emotionTextview.delegate = self ;
    }
    return _emotionTextview;
}

-(XC_EmotionToolTabbar *)topTababrView
{
    if (!_topTababrView) {
        _topTababrView = [XC_EmotionToolTabbar shareCreatToolTababr];
        _topTababrView.delegate = self ;
    }
    return _topTababrView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setRectFrame:(CGRect)rectFrame
{

    self.frame = rectFrame ;
    self.emotionTextview.frame = self.bounds ;
    XCLog(@"-----%@" ,NSStringFromCGRect(self.frame));

}

-(void)setUI
{
    
    /**   监听表情被选中  */
    [XCNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:XC_EmotionDidSelectNotification object:nil];
    
    /**  键盘弹出   */
    [XCNotificationCenter  addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    /**   键盘隐藏  */
    [XCNotificationCenter  addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /**   监听删除按钮  */
    [XCNotificationCenter  addObserver:self selector:@selector(emotionDelete) name:XC_EmotionDidDeleteNotification object:nil];
    
    //tatabar 高度
    self.topTababrView.y = KmainScreenHeiht ;
    
    self.emotionTextview.frame = self.bounds ;
    XCLog(@"-----%@" ,NSStringFromCGRect(self.emotionTextview.frame));
    [self addSubview:self.emotionTextview];
    self.emotionTextview.inputTextHandle = ^(NSString * _Nullable inputString) {
      
    };
}


/**  键盘弹出   */
- (void)keyboardWillShow:(NSNotification *)notification {
    
    //把toptabbar 加载到键盘的Windows 上面
//    UIWindow *window =  [[UIApplication sharedApplication].windows lastObject];
//    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window] ;
    
    [window addSubview:self.topTababrView];
    
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
    
    self.topTababrView.y  = KmainScreenHeiht - self.topTababrView.height - keyBoardHeight ;
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
        self.topTababrView.y = KmainScreenHeiht ;
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window] ;
        [window removeFromSuperview];
    }
    
}

/**  表情被选中了   */
- (void)emotionDidSelect:(NSNotification *)notification
{
    XCEmotionModel *emotion = notification.userInfo[XC_SelectEmotionKey];
    //    XCLog(@"emotion.chs = %@" ,emotion.chs);
    [self.emotionTextview insertEmotion:emotion];
}

/**   删除  */
-(void)emotionDelete
{
    [self.emotionTextview deleteBackward];
}

-(NSString *)getInputWord
{
    //富文本转普通字符串
    return [self.emotionTextview fullText];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

//切换键盘
-(void)switchKeyboard
{
    // _xc_textView.inputView == nil : 使用的是系统自带的键盘
    if (self.emotionTextview.inputView == nil) { // 切换为自定义的表情键盘
        self.emotionTextview.inputView = self.emotionKeyBoardview;

    } else { // 切换为系统自带的键盘
    
        self.emotionTextview.inputView = nil;
    }

    // 开始切换键盘
    self.switchingKeybaord = YES;

    // 退出键盘
    [self endEditing:YES];

    // 结束切换键盘
    self.switchingKeybaord = NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.emotionTextview becomeFirstResponder];
    });
}

- (void)composeToolbar:(XC_EmotionToolTabbar *)toolbar didClickButton:(XCTababrComposeToolbarType)buttonType
{
    switch (buttonType) {
        case XCTababrComposeToolbarButtonTypeCamera: //拍照
            
            break;
        case XCTababrComposeToolbarButtonTypePicture: // 相册
            
            break;
         case XCTababrComposeToolbarButtonTypeMention: //@
            
            break;
            
        case  XCTababrComposeToolbarButtonTypeTrend: // #
            break;
            
        case  XCTababrComposeToolbarButtonTypeEmotion:// 表情:
            XCLog(@"表情");
            [self switchKeyboard];
            break;
        default:
            break;
    }
}

- (void)dealloc{
    
    [XCNotificationCenter removeObserver:self name:XC_EmotionDidSelectNotification object:nil];
    [XCNotificationCenter removeObserver:self name:XC_EmotionDidDeleteNotification object:nil];
    [XCNotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [XCNotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



@end

