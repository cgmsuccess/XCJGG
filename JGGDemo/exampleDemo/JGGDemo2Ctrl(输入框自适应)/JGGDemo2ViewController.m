//
//  JGGDemo2ViewController.m
//  JGGDemo
//
//  Created by 陈桂民 on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JGGDemo2ViewController.h"
#import "XC_TextView.h"
#import "XC_keyboardManager.h"
#import "XC_EmojikeyBoardView.h"
#import "XCEmotionTool.h"

@interface JGGDemo2ViewController ()<UITextViewDelegate,XCComposeToolbarTopDelegate>
{
    XC_TextView *_xc_textView;
}
/**    输入框      ****/
@property (nonatomic,strong)XC_keyboardManager *topTools;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;

/**     表情键盘   ****/
@property (nonatomic,strong)XC_EmojikeyBoardView *emotionKeyboard;

@end


@implementation JGGDemo2ViewController

-(XC_EmojikeyBoardView *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[XC_EmojikeyBoardView alloc] init];
        // 键盘的宽度
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
        self.emotionKeyboard.backgroundColor = [UIColor whiteColor];
    }
    return _emotionKeyboard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    
    [self setUI];
}



-(void)setUI
{
    
    self.topTools = [[XC_keyboardManager alloc] initWithFrame:CGRectMake(0, KmainScreenHeiht - 106, KmainScreenWidth, 106)];
    self.topTools.showKeyboardButton = YES ;
    self.topTools.delegate = self ;
    self.topTools.backgroundColor = [UIColor yellowColor];
    self.topTools.stringAndHeightHandle = ^(NSString *inputString, CGFloat height) {
        
    };
    [self.view addSubview:self.topTools];
    
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    [XCNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.topTools.y = self.view.height - self.topTools.height;
        } else {
            self.topTools.y = keyboardF.origin.y - self.topTools.height;
        }
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{


    [self.view endEditing:YES];
}

#pragma mark XCComposeToolbarTopDelegate

-(void)composeToolbar:(XC_keyboardManager *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XC_ComposeToolbarButtonTypeEmotion:
            //表情
            [self switchKeyboard];
            break;
        case XC_ComposeToolbarButtonTypeMention:
            //@
            [self.view endEditing:YES];

            break;
        case XC_ComposeToolbarButtonTypeSend:
            //发送
            [self.view endEditing:YES];

            break;
        default:
            break;
    }
}

//切换键盘
-(void)switchKeyboard
{
    // _xc_textView.inputView == nil : 使用的是系统自带的键盘
    if (_xc_textView.inputView == nil) { // 切换为自定义的表情键盘
        _xc_textView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.topTools.showKeyboardButton = YES;
    } else { // 切换为系统自带的键盘
        _xc_textView.inputView = nil;
        
        // 显示表情按钮
        self.topTools.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [_xc_textView endEditing:YES];
    
    // 结束切换键盘
    self.switchingKeybaord = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        _xc_textView = [self.topTools showXCKeyboard];
        
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
