//
//  XC_InputView.h
//  JGGDemo
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XC_TextViewDelegate <NSObject>



@end

@interface XC_TextView : UITextView

/** 这个属性是： 设置占位文字  ****/
@property (null_resettable,nonatomic,strong)NSString * placeholderString;

/** 这个属性是： 设置占位文字颜色****/
@property(null_resettable, nonatomic,strong)UIColor * placeholderColor;

/** 这个属性是： 占位字的大小 默认 14 ****/
@property (nonatomic,assign)NSInteger placeholderLabelFont;

/** 这个属性是： 设置占位文字的X偏移量****/
@property (nonatomic, assign) CGFloat placeHolderOffsetX;

/** 这个属性是： 设置占位文字的Y偏移量****/
@property (nonatomic, assign) CGFloat placeHolderOffsetY;

/** 这个属性是： 设置textView的字体显示的大小 ,默认为 14 ****/
@property (nonatomic, assign) CGFloat textViewFont ;

/** 这个属性是： 光标的颜色 ****/
@property(null_resettable, nonatomic,strong)UIColor * cursorColor;

/** 这个属性是： 最多输入多少个字 ，默认无数个 ****/
@property (nonatomic,assign)NSInteger maxInputWord ;

/**    已经输入了多少字回调      ****/
@property (nonatomic,copy)void(^inputTextHandle)(NSString * _Nullable inputString);


/**
 设置边框。以及边框的颜色，和弧度
 
 @param borderColore 边框色
 @param circular 弧度大小
 */
-(void)addBorder:(UIColor *_Nonnull)borderColore Andcircular:(CGFloat)circular;


@end
