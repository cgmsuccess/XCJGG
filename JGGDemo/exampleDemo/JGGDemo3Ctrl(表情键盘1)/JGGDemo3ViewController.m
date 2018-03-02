//
//  JGGDemo3ViewController.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JGGDemo3ViewController.h"
//#import "XC_EmotionToolTabbar.h"
//#import "XC_EmotionsView.h"
//#import "XCWordChangeTool.h"
#import "XC_keyboardManager.h"

@interface JGGDemo3ViewController ()
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
    inputEmtion.rectFrame = CGRectMake(0, 0, KmainScreenWidth, 200);
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
