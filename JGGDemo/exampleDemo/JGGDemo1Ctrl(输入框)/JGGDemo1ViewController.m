//
//  JGGDemo1ViewController.m
//  JGGDemo
//
//  Created by apple on 17/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JGGDemo1ViewController.h"
#import "XC_TextView.h"

@interface JGGDemo1ViewController ()<UITextViewDelegate>

/**  xib输入框   */
@property (weak, nonatomic) IBOutlet XC_TextView *inputView;

/**  代码创建 ****/
@property (nonatomic,strong)XC_TextView *codeTextView ;




@end

@implementation JGGDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    CGFloat height = [NSString autoHeightWithString:@"初始高度" Width:KmainScreenWidth Font:14];
//    self.inputViewHeight.constant = height + 20 ;
//    
    //xib 创建 一定要设置这个，不然textView朝下偏移了64 .
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.inputView.delegate = self;
    
    //xib
    [self xibCreatTextView];
    
    //code
    [self codeCreatTextView];
}

//xib 创建的textView
-(void)xibCreatTextView
{
    self.inputView.placeholderString = @"请输入请输入请输入";
    self.inputView.placeHolderOffsetX = 0 ;
    self.inputView.placeHolderOffsetY = 5;
    self.inputView.textViewFont = 17 ;
    self.inputView.cursorColor = [UIColor redColor];
    self.inputView.placeholderColor = [UIColor cyanColor];
    self.inputView.placeholderLabelFont = 15 ;
    self.inputView.inputTextHandle = ^(NSString * _Nullable inputString) {
        XCLog(@"inputString = %@" ,inputString);
    };
}


-(void)codeCreatTextView
{
    self.codeTextView = [[XC_TextView alloc] initWithFrame:CGRectMake(0, 300, KmainScreenWidth, 55)];
    [self.view addSubview:self.codeTextView];
    self.codeTextView.backgroundColor = [UIColor greenColor];
    self.codeTextView.placeholderString = @"code 创建,请输入，最多10位";
    self.codeTextView.cursorColor = [UIColor blackColor];
    self.codeTextView.textViewFont = 17 ;
    self.codeTextView.layer.masksToBounds = YES ;
    self.codeTextView.layer.cornerRadius = 15 ;
    self.codeTextView.layer.borderWidth = 1.0f;
    self.codeTextView.maxInputWord = 10 ;
    self.codeTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.codeTextView.delegate = self ;
    self.codeTextView.inputTextHandle = ^(NSString * _Nullable inputString) {
        XCLog(@"inputString = %@" ,inputString);
    };
}



- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([textView isEqual:self.codeTextView ]) {
        XCLog(@"textView = %@" ,textView.text);

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
