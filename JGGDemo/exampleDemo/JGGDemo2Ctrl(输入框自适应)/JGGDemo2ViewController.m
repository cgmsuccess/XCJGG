//
//  JGGDemo2ViewController.m
//  JGGDemo
//
//  Created by 陈桂民 on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JGGDemo2ViewController.h"
#import "XC_TextView.h"
#import "XC_AutoTextView.h"
@interface JGGDemo2ViewController ()<UITextViewDelegate>
{
    CGFloat textviewHeight ;
    CGFloat startHeight ;
}
@property (nonatomic,strong)XC_TextView *codeTextView ;

@end

@implementation JGGDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    
    XC_AutoTextView *view =  [[XC_AutoTextView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake(0, 300, KmainScreenWidth, 44);
    [self.view addSubview:view];
    
    
    
    [self setUI];
}

-(void)setUI
{
    self.codeTextView = [[XC_TextView alloc] init];
    [self.view addSubview:self.codeTextView];
    self.codeTextView.backgroundColor = [UIColor greenColor];
    self.codeTextView.placeholderString = @"code 创建,请输入，最多10位";
    self.codeTextView.text = @"没毛病";
    textviewHeight = 35 ; //初始高度
    startHeight = [NSString autoHeightWithString:@"初始高度" Width:KmainScreenWidth Font:self.codeTextView.textViewFont];

    self.codeTextView.cursorColor = [UIColor blackColor];
    self.codeTextView.textViewFont = 14 ;
    self.codeTextView.layer.masksToBounds = YES ;
    self.codeTextView.layer.cornerRadius = 15 ;
    self.codeTextView.layer.borderWidth = 1.0f;
    self.codeTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.codeTextView.delegate = self ;
    self.codeTextView.inputTextHandle = ^(NSString * _Nullable inputString) {
        NSLog(@"inputString = %@" ,inputString) ;
    };
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    XCLog(@"textView的高度 = %lf" ,textviewHeight) ;
    [UIView animateWithDuration:0.1f animations:^{
        self.codeTextView.frame = CGRectMake(0, 100, KmainScreenWidth, textviewHeight);
    }];
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self.view setNeedsLayout];
//    XCLog(@"textView的高度 = %lf" ,textviewHeight) ;
    textviewHeight = [NSString autoHeightWithString:textView.text Width:KmainScreenWidth Font:self.codeTextView.textViewFont];
    textviewHeight = textviewHeight > 60 ?startHeight * 3: textviewHeight;
    textviewHeight = textviewHeight > 35 ?textviewHeight:35;
   
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
