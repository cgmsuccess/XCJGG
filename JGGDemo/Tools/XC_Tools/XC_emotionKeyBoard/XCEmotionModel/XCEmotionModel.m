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


//归档解档


/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.xcemotionType = [decoder decodeIntegerForKey:@"xcemotionType"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeInteger:self.xcemotionType forKey:@"xcemotionType"];
}

@end
