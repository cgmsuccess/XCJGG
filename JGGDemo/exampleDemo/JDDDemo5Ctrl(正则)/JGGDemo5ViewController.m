//
//  JGGDemo5ViewController.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JGGDemo5ViewController.h"
#import "RegexKitLite.h"
#import "XCWordChangeTool.h"
#import "XC_touchTextview.h"
@interface JGGDemo5ViewController ()<XC_touchTextviewDelegate>
{
    XC_touchTextview *showLabel ;
}
@end

@implementation JGGDemo5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
    [self emtionshow];
    
    
}

-(void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    showLabel  = [[XC_touchTextview alloc] initWithFrame:CGRectMake(0, 100, KmainScreenWidth, 100)];
    showLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:showLabel];
    showLabel.cilckHightColor = [UIColor lightGrayColor]; //点击时高亮颜色
}




//富文本显示表情
-(void)emtionshow
{
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    NSString *test = @"ffwfsfds[吃惊]fgood@小米:产品不错，[晕]我喜欢。#小米产品#fsfsfdgoodfs[大笑]fsdfnknkgoodfsfs[晕]#妈妈再也不用担心我的学习#";
    showLabel.attributedText = [XCWordChangeTool attributedTextWithText:test] ;
    showLabel.cilckdelegate = self ;

}

-(void)cilckOption:(NSString *)cilckString
{
    XCLog(@"cilckString = %@" , cilckString);
}


/**  如何字符串显示表情  --------------------》基础    */
-(void)showEmtion
{
    NSString *test = @"ffwfsfds[吃惊]fgood@小米:产品不错，[晕]我喜欢。#小米产品#fsfsfdgoodfs[大笑]fsdfnknkgoodfsfs[晕]#妈妈再也不用担心我的学习#";
    /**  普通文字创建属性属性文字   */
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:test];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"d_baibai"];
    attch.bounds = CGRectMake(0, -3, 15, 15);
    
    [attributedText insertAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attch] atIndex:0];
    
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attributedText.length)];
    
    showLabel.attributedText = attributedText ;
}


/**  6.  简单的图文混排  --- 》 普通文字转换成属性文字  */
-(void)imageAndWordLayout
{
    NSString *test = @"ffwfsfds[吃惊]fgood@小米:产品不错，[晕]我喜欢。#小米产品#fsfsfdgoodfs[大笑]fsdfnknkgoodfsfs[晕]#妈妈再也不用担心我的学习#";
    
    /**  普通文字创建属性属性文字   */
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:test];
    
        NSString *pattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";  //表情规则
        NSString *pattern1 = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";  //@规则
        NSString *pattern2 = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";  //#话题规则
    
        //3种规则合并在一起
        NSString *patterns = [NSString stringWithFormat:@"%@|%@|%@",pattern,pattern1,pattern2];
    
    //获取符合  表情     规则的特殊字符串
    [test enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        XCLog(@"获取符合规则的字符串  %@  %@" , *capturedStrings ,NSStringFromRange(*capturedRanges));
        //给便利出来的字符串，特殊的颜色
        //NSFontAttributeName 设置字体大小
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:*capturedRanges];
    
    }];
    
    //获取符合@规则的特殊字符串
    [test enumerateStringsMatchedByRegex:pattern1 usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        XCLog(@"获取符合规则的字符串  %@  %@" , *capturedStrings ,NSStringFromRange(*capturedRanges));
        //给便利出来的字符串，特殊的颜色
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
    }];
    
    //获取符合#话题#规则的特殊字符串
    [test enumerateStringsMatchedByRegex:pattern2 usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        XCLog(@"获取符合规则的字符串  %@  %@" , *capturedStrings ,NSStringFromRange(*capturedRanges));
        //给便利出来的字符串，特殊的颜色
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:*capturedRanges];
    }];
    
    //设置属性文字大小
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attributedText.length)];
    
    showLabel.attributedText = attributedText;
}


/** 5. RegexKitLite的使用，注意他是mrc，和记载 动态库，添加liccucore */
-(void)regexkit
{
    NSString *test = @"ffwfsfds[泪奔]fgood@小米:产品不错，我喜欢。#小米产品#fsfsfdgoodfs[大笑]fsdfnknkgoodfsfs[哈哈]#妈妈再也不用担心我的学习#";
    
    NSString *patterns = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]|@[0-9a-zA-Z\\u4e00-\\u9fa5]+|#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";

    NSArray *results = [test componentsMatchedByRegex:patterns];
    
    XCLog(@"results = %@" ,results) ;
    
    
    //获取符合规则的特殊字符串
    [test enumerateStringsMatchedByRegex:patterns usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        XCLog(@"获取符合规则的字符串  %@  %@" , *capturedStrings ,NSStringFromRange(*capturedRanges));
        
    }];
    
    
    
    //获取规则意外的非特殊的所有字符串，
    [test enumerateStringsSeparatedByRegex:patterns usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        XCLog(@"获取规则以外的所有字符串 %@  %@" , *capturedStrings ,NSStringFromRange(*capturedRanges));

    }];
    
    
    
    
    
    
}



/** 4 😄 表情规则  @ 的规则 #话题规则#*/
-(void)emtionsPattern
{
    NSString *test = @"ffwfsfds[泪奔]fgood@小米:产品不错，我喜欢。#小米产品#fsfsfdgoodfs[大笑]fsdfnknkgoodfsfs[哈哈]#妈妈再也不用担心我的学习#";
    
    // 1 ，创建正则表达式
//    NSString *pattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";  //表情规则
    
//    NSString *pattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";  //@规则

//    NSString *pattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";  //#话题规则

    NSString *patterns = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]|@[0-9a-zA-Z\\u4e00-\\u9fa5]+|#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:patterns options:0 error:nil]; //创建正则对象
    // 2,测试字符串
    NSArray *results = [regex matchesInString:test options:0 range:NSMakeRange(0, test.length)];
    
    //3，便利结果
    for (NSTextCheckingResult  *result in results) {
        NSLog(@"range = %@ ,sting = %@",NSStringFromRange(result.range) , [test substringWithRange:result.range]) ;//打印所有找到good的范围
    }
    
//    NSLog(@"对应数字的字符串位置%@     \n  有多少个数字%lu",results ,(unsigned long)results.count);
}



/** 3.  寻找字符串中特定规则的字符串  */
-(void)findPatternRangeMake
{
    
    NSString *test = @"ffwfsfdsfgoodfsfsfdgoodfsfsdfnknkgoodfsfs";
    
    // 1 ，创建正则表达式
    NSString *pattern = @"good";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil]; //创建正则对象
    // 2,测试字符串
    NSArray *results = [regex matchesInString:test options:0 range:NSMakeRange(0, test.length)];
    
    //3，便利结果
    for (NSTextCheckingResult  *result in results) {
        NSLog(@"range = %@ ,sting = %@",NSStringFromRange(result.range) , [test substringWithRange:result.range]) ;//打印所有找到good的范围
    }
    
    NSLog(@"对应数字的字符串位置%@     \n  有多少个数字%lu",results ,(unsigned long)results.count);
    
}


/** 2.  正则表达式，基本用法，检测QQ  */
-(void)detectionQQ
{
    /*
     1,定义规则
     2，使用规则
     */
    
    NSString *qq = @"100988";
    
    // 1 ，创建正则表达式
    NSString *pattern = @"^[1-9]\\d{5,11}$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil]; //创建正则对象
    // 2,测试字符串
    NSArray *results = [regex matchesInString:qq options:0 range:NSMakeRange(0, qq.length)];
    
    NSLog(@"对应数字的字符串位置%@     \n  有多少个数字%lu",results ,(unsigned long)results.count);
    
}


/**  1.  正则表达式，基本用法，检测纯数字  */
-(void)detectionNum
{
    /*
     1,定义规则
     2，使用规则
     */
    
    NSString *test = @"324njkbkj8909890";
    
    // 1 ，创建正则表达式
    NSString *pattern = @"^\\d[0-9a-zA-Z]*\\d$"; //规则数字开始，数字结束，中间任意大小写和数字，位数不变
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil]; //创建正则对象
    // 2,测试字符串
    NSArray *results = [regex matchesInString:test options:0 range:NSMakeRange(0, test.length)];
    
    NSLog(@"对应数字的字符串位置%@     \n  有多少个数字%lu",results ,(unsigned long)results.count);

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
