//
//  XCEmotionModel.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XCEmotionModel.h"

@implementation XCEmotionModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.chs = dic[@"chs"];
        self.png = dic[@"png"];
    }
    return self;
}

@end
