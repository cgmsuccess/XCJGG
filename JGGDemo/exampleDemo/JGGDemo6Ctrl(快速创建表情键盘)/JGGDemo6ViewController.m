//
//  JGGDemo6ViewController.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JGGDemo6ViewController.h"
#import "XC_keyboardManager.h"

@interface JGGDemo6ViewController ()<XCComposeToolbarTopDelegate>

/**  显示输入内容   */
@property (nonatomic, nonatomic) XC_touchTextview *touchLabel;

@property (nonatomic,strong)XC_keyboardManager *keyBoardManager;

@end

@implementation JGGDemo6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.touchLabel = [[XC_touchTextview alloc] initWithFrame:CGRectMake(0, 64, KmainScreenWidth, 100)];
    [self.view addSubview:self.touchLabel];
    
    
    //键盘
    self.view.backgroundColor = [UIColor whiteColor];
    XC_keyboardManager *manager  = [[XC_keyboardManager alloc] init];
    self.keyBoardManager = manager ;
    XC_EmotionInputView *emtionsInputView = [manager getXC_EmotionInputView];
    emtionsInputView.stringAndHeightHandle = ^(NSString *inputString, CGFloat height) {
        
    };
    emtionsInputView.backgroundColor = [UIColor whiteColor];
    emtionsInputView.frame =  CGRectMake(0, KmainScreenHeiht,  KmainScreenWidth, 106);
    emtionsInputView.keyBoardY = KmainScreenHeiht ;
    emtionsInputView.delegate = self;
    [self.view addSubview:emtionsInputView];
    
    
    
    [self.keyBoardManager.getXC_EmotionInputView showXCKeyboard];
}

#pragma mark XCComposeToolbarTopDelegate
-(void)composeToolbar:(XC_EmotionInputView *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XC_ComposeToolbarButtonTypeMention:
            //@
            XCLog(@"点击了@");
            
            break;
        case XC_ComposeToolbarButtonTypeSend:
            //发送
            [self sendMassge:toolbar];
            break;
        default:
            break;
    }
}

-(void)sendMassge:(XC_EmotionInputView *)keyboardView
{
    //获取到输入框
    XC_EmotionTextView *emtionsTextView = [keyboardView viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    
    XCLog(@"emtionsTextView.text = %@" , [emtionsTextView fullText]);
    
    self.touchLabel.attributedText = [XCWordChangeTool attributedTextWithText:[emtionsTextView fullText]] ;
    
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
