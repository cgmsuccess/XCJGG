//
//  XCEmotionModel.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,XCentionModelType){
    XCentionModelTypeDefault, //默认表情
    XCentionModelTypeLxh,//浪小花
    XCentionModelTypeQQ//qq表情
};

@interface XCEmotionModel : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;

/** 表情包的属性     ****/
@property (nonatomic,assign)XCentionModelType xcemotionType;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
