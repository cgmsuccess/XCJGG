//
//  XCEmotionModel.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCEmotionModel : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;


-(instancetype)initWithDic:(NSDictionary *)dic;


@end
