//
//  XC_JGGView.m
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XC_JGGView.h"

#define XCPhotoWH (self.bounds.size.width - XCPhotoMargin * 4)/3 //每个图片大小
#define XCPhotoMargin 10  //间隔
#define XCPhotoMaxCol(count) (count==1?1:(count==4)?2:3)  //列数

@implementation XC_JGGView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    return self ;
}


-(void)setOnlyOneOptionalWH:(NSInteger)OnlyOneOptionalWH
{
    _OnlyOneOptionalWH = OnlyOneOptionalWH;
    [self layoutIfNeeded];
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource ;
    [self setUI];
}

/**  设置UI   */
-(void)setUI
{

    for (int i = 0; i < _dataSource.count; i ++ ) {
        UIImageView *optionsImageView = [[UIImageView alloc] init];
        optionsImageView.image = [UIImage imageNamed:_dataSource[i]];
        [self addSubview:optionsImageView];
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    int i = 0 ;
    // 最大列数（一行最多有多少列）
    int maxCols = XCPhotoMaxCol(self.subviews.count);

    switch (self.subviews.count) {
        ///只有一张图片的时候
        case 1:{
           UIImageView * imageView  = self.subviews.firstObject;
           ///设置了一张图片的长宽的时候
            if (_OnlyOneOptionalWH) {
                ///适配，设置长宽大于jggview 的长宽的时候。限制大小
                if (_OnlyOneOptionalWH > self.bounds.size.width - 2 * XCPhotoMargin) {
                    _OnlyOneOptionalWH = self.bounds.size.width - 2 * XCPhotoMargin ;
                }
            
                imageView.frame = CGRectMake(XCPhotoMargin + i % maxCols *(XCPhotoWH + XCPhotoMargin), i / maxCols *(XCPhotoMargin + XCPhotoWH) + XCPhotoMargin, _OnlyOneOptionalWH, _OnlyOneOptionalWH);
                
            }else{
                ///默认一张图片的时候
                imageView.frame = CGRectMake(XCPhotoMargin + i % maxCols *(XCPhotoWH + XCPhotoMargin), i / maxCols *(XCPhotoMargin + XCPhotoWH) + XCPhotoMargin, XCPhotoWH, XCPhotoWH);
            }
        }
            break;
            
        default:
            
            ///默认情况下
            for (UIImageView *imageView  in self.subviews) {
                imageView.frame = CGRectMake(XCPhotoMargin + i % maxCols *(XCPhotoWH + XCPhotoMargin), i / maxCols *(XCPhotoMargin + XCPhotoWH) + XCPhotoMargin, XCPhotoWH, XCPhotoWH);
                i++ ;
            }
            
            break;
    }
    
    
}








@end
