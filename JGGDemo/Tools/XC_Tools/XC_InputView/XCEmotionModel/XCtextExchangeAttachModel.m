//
//  XCtextExchangeAttachModel.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XCtextExchangeAttachModel.h"

@implementation XCtextExchangeAttachModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}

@end
