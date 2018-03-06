//
//  XC_touchTextview.h
//  JGGDemo
//
//  Created by gao bin on 2018/3/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XCSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;

@end




@protocol XC_touchTextviewDelegate <NSObject>

@optional


/**   点击选项的字符串  */
-(void)cilckOption:(NSString *)cilckString;

@end

@interface XC_touchTextview : UITextView

/** 所有的特殊字符串 */
@property (nonatomic, strong) NSArray *specials;

/**    点击时高亮颜色      ****/
@property (nonatomic)UIColor *cilckHightColor;

/**     点击选项     ****/
@property (nonatomic,weak)id<XC_touchTextviewDelegate> cilckdelegate ;



@end
