//
//  XCEmotionTool.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XCEmotionTool.h"
#import "XCEmotionModel.h"

@implementation XCEmotionTool

static NSArray  *_defaultEmotions;


/*  默认表情数据   **/
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"XEmotionIcons" ofType:@"bundle"];
        NSString * path = [NSString stringWithFormat:@"%@/default/info.plist",bundlePath];
        NSArray *emotionArr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *emotionModelArr = [NSMutableArray array];
        for (NSDictionary *dic in emotionArr) {
            XCEmotionModel *emotionModel = [[XCEmotionModel alloc] initWithDic:dic];
            [emotionModelArr addObject:emotionModel];
        }
        _defaultEmotions = (NSArray *)emotionModelArr;
    }
    return _defaultEmotions;
}


@end
