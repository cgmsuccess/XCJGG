//
//  XC_EmojiTabarCollectionViewCell.h
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XC_EmojiTabarCollectionViewCell : UICollectionViewCell

/**   底视图      ****/
@property (nonatomic,weak)UIView *backView;

/**    图片      ****/
@property (nonatomic,weak)UIImageView *backImageView;

/**    图片的名字      ****/
@property (nonatomic,copy)NSString *imageName;

@end
