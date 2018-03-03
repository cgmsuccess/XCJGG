//
//  JGGDemo3ViewController.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JGGDemo3ViewController.h"
#import "XC_keyboardManager.h"

@interface JGGDemo3ViewController ()<XC_emotionViewDelegate>
{
    XC_EmotionsView *inputEmtion;
    UILabel *label;
}
@end

@implementation JGGDemo3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    inputEmtion = [[XC_keyboardManager new] getXC_emotionsView];
    //一定要设置
    inputEmtion.rectFrame = CGRectMake(0, 0, KmainScreenWidth, 200);
    //设置为第一响应者
    [inputEmtion XC_emotionBecomeFirstResponder];
    inputEmtion.delegate = self;
    
    [self.view addSubview:inputEmtion];
    
    
    label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 100, KmainScreenWidth, 100);
    label.hidden = YES ;
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"124324242424242424242";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
}

-(void)send
{
    NSString *text = [inputEmtion getInputWord];
    XCLog(@"%@" ,text);
    label.hidden = NO ;
    label.attributedText = [XCWordChangeTool attributedTextWithText:text];
    
}



-(void)composeToolbarCilck:(XC_EmotionToolTabbar *)toolbar didClickButton:(XCTababrComposeToolbarType)buttonType
{
    switch (buttonType) {
        case XCTababrComposeToolbarButtonTypeCamera: //拍照
            XCLog(@"拍照");
            break;
        case XCTababrComposeToolbarButtonTypePicture: // 相册
            XCLog(@"相册");
            break;
        case XCTababrComposeToolbarButtonTypeMention: //@
            XCLog(@"@");
            break;
            
        case  XCTababrComposeToolbarButtonTypeTrend: // #
            XCLog(@"#");
            break;
            
        case  XCTababrComposeToolbarButtonTypeEmotion:// 表情:
            XCLog(@"表情");
            break;
        default:
            break;
    }

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
