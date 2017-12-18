//
//  XC_JGGView.m
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XC_JGGView.h"
#import "UIImageView+WebCache.h"



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
    //避免复用问题
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    [self setUI];
}

/**  设置宽高   */
-(CGSize)setDtasouce:(NSInteger)optionsCount
{
    // 最大列数（一行最多有多少列）
    int maxCols = XCPhotoMaxCol(optionsCount);

    NSUInteger cols = (optionsCount >= maxCols)? maxCols : optionsCount;

    CGFloat photosW ;//宽
    //判断只有一张图的时候，是否设置了宽高
    if (self.OnlyOneOptionalWH && optionsCount == 1) {
         photosW = cols * self.OnlyOneOptionalWH + (cols + 1) * XCPhotoMargin;
    }else{
    //默认情况下，没有设置宽高
         photosW = cols * XCPhotoWH + (cols + 1) * XCPhotoMargin;
    }
    
    // 最大函数 = （总的选项数 + 最大列数 - 1）/ 最大列数
    NSUInteger rows = (optionsCount + maxCols - 1) / maxCols;
    CGFloat photosH;
    if (self.OnlyOneOptionalWH && optionsCount == 1) {
         photosH = rows * self.OnlyOneOptionalWH +(rows + 1)* XCPhotoMargin;
    }else{
        photosH = rows * XCPhotoWH +(rows + 1)* XCPhotoMargin;
    }
    
    return CGSizeMake(photosW, photosH);
}

/**  设置UI   */
-(void)setUI
{
    for (int i = 0; i < _dataSource.count; i ++ ) {
        UIImageView *optionsImageView = [[UIImageView alloc] init];
        optionsImageView.tag = i ;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cilckOptionsImageAction:)];
        optionsImageView.userInteractionEnabled = YES;
        [optionsImageView addGestureRecognizer:tap];
        
        if ([_dataSource[i] isKindOfClass:[UIImage class]]) {
            
            optionsImageView.image = _dataSource[i];
        
        }else if([_dataSource[i] isKindOfClass:[NSString class]]){
          
            optionsImageView.image = [UIImage imageNamed:_dataSource[i]];
            
        }else if([_dataSource[i] isKindOfClass:[NSURL class]]){
            
            [optionsImageView sd_setImageWithURL:_dataSource[i] placeholderImage:self.placeholderImage];
        }
        [self addSubview:optionsImageView];
    }
}

//点击选项回调
-(void)cilckOptionsImageAction:(UITapGestureRecognizer *)tap
{
    self.cilckhandle(tap.view.tag , self.dataSource);
};



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
