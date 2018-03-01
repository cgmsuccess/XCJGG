//
//  XC_InputView.m
//  JGGDemo
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
// 限制字数参考： http://www.jianshu.com/p/ff1c7c46e084 感谢

#import "XC_TextView.h"

NSInteger maxInput = MAXFLOAT ;

@interface XC_TextView()

/** 这个属性是：占位文字的Label****/
@property (nonatomic,strong)UILabel *placeholderLabel ;


@end

@implementation XC_TextView


//xib
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUI];
    }
    return self ;
}

//code
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self ;
}

-(void)setUI
{
    [self addSubview:self.placeholderLabel];
    self.alwaysBounceVertical = YES;
    self.tintColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:14.0];
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    //这里一个小坑 object:nil 如果设置为nil。那么会通知每一个 XC_TextView 对象。，所以会出现其他问题
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    self.scrollEnabled = self.hasText ;
    _textViewFont = 14;
    _maxInputWord = maxInput;
}

#pragma mark Other
/**  占位文字颜色   */
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor ;
    self.placeholderLabel.textColor = placeholderColor;
}
/**  占位文字   */
-(void)setPlaceholderString:(NSString *)placeholderString
{
    _placeholderString = placeholderString;
    self.placeholderLabel.text = _placeholderString ;

}
/**  占位文字的x 偏移   */
-(void)setPlaceHolderOffsetX:(CGFloat)placeHolderOffsetX
{
    _placeHolderOffsetX = placeHolderOffsetX ;
    self.placeholderLabel.x = placeHolderOffsetX ;
}

/**  占位文字y的偏移   */
-(void)setPlaceHolderOffsetY:(CGFloat)placeHolderOffsetY
{
    _placeHolderOffsetY = placeHolderOffsetY ;
    self.placeholderLabel.y = placeHolderOffsetY ;
}


/**  占位文字字体的大小 */
-(void)setPlaceholderLabelFont:(NSInteger)placeholderLabelFont
{
    _placeholderLabelFont = placeholderLabelFont ;
}

/** textView 字体的大小   */
-(void)setTextViewFont:(CGFloat)textViewFont
{
    _textViewFont = textViewFont ;
}
/**  光标的颜色   */
-(void)setCursorColor:(UIColor *)cursorColor
{
    _cursorColor = cursorColor;
    self.tintColor = _cursorColor ;
}
/**  最大的输入限制字符的个数   */
-(void)setMaxInputWord:(NSInteger)maxInputWord
{
    _maxInputWord = maxInputWord;
}

/**  文字发生改变   */
- (void)textDidChange
{
    //////////////// 占位符是否显示
    self.placeholderLabel.hidden = self.hasText;
    self.scrollEnabled = self.hasText ;
    
////////////////////////////////////限制长度 ////////////////////////////////////////////////
    // 获取键盘输入模式
    NSString *lang =  [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
    NSString *toBeString = self.text;

    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        
        if (!position) {
            
            if (toBeString.length > _maxInputWord) {                
                // 截取子串
                self.text = [toBeString substringToIndex:_maxInputWord];
                self.inputTextHandle(self.text);
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
            //XCLog(@"11111111111111========      %@",position);
            self.inputTextHandle(self.text);
        }
    } else {
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > _maxInputWord) {
            // 截取子串
            self.text = [toBeString substringToIndex:_maxInputWord];
            self.inputTextHandle(self.text);
        }
    }
}

/**  富文本输入   */
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    //////////////// 占位符是否显示
    self.placeholderLabel.hidden = self.hasText;
    self.scrollEnabled = self.hasText ;
}



/*   加边框  **/
-(void)addBorder:(UIColor *)borderColore Andcircular:(CGFloat)circular
{
    self.layer.masksToBounds = YES ;
    self.layer.cornerRadius = circular ;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = borderColore.CGColor;
}


#pragma mark system
-(void)layoutSubviews
{
    [super layoutSubviews];
   
    
    NSInteger LabelFont = self.placeholderLabelFont?self.placeholderLabelFont:14;
    ///设置字体
    self.placeholderLabel.font = [UIFont systemFontOfSize:LabelFont];
    self.font =  [UIFont systemFontOfSize:_textViewFont];
    ///设置位置
    self.placeholderLabel.x = _placeHolderOffsetX;
    self.placeholderLabel.y = _placeHolderOffsetY;
    self.placeholderLabel.width = self.width - _placeHolderOffsetX ;
    self.placeholderLabel.height = [NSString autoHeightWithString:_placeholderString Width:self.width Font:LabelFont];
    self.placeholderLabel.hidden = self.hasText;

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Lazy
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0 ;
    }
    return _placeholderLabel ;
}



@end
