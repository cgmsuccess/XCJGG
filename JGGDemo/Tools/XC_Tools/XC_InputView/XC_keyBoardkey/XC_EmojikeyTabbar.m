//
//  XC_EmojikeyToobar.m
//  JGGDemo
//
//  Created by gao bin on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XC_EmojikeyTabbar.h"
#import "XC_EmojiTabarCollectionViewCell.h"

NSString *xc_emojitabbarCell = @"xc_emojitabbarCell";

@interface XC_EmojikeyTabbar()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    XC_EmojiTabarCollectionViewCell *customcell ;
}

@property (nonatomic,strong)UICollectionView *collectionView ;


@end

@implementation XC_EmojikeyTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.top.offset(0);
    }];
    
    if ([self.delegate respondsToSelector:@selector(cilckEmotionsTabbar:AndcilckIndex:)]) {
        if (self.defaultEmtionType) {
            [self.delegate cilckEmotionsTabbar:self AndcilckIndex:0];
        }else{
            [self.delegate cilckEmotionsTabbar:self AndcilckIndex:self.defaultEmtionType];
        }
    }
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource ;
}

-(void)defaultSelectOptionsCell:(void(^)(XC_EmojiTabarCollectionViewCell *cell))selectBlock
{
    customcell.backView.backgroundColor = [UIColor whiteColor];
    selectBlock(customcell);
}


#pragma mark - UICollectionViewDataSource UICollectionViewDelegateFlowLayout
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        
        //collectionview 左右滑动还是上下滑动 。默认上下
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds   collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.frame = self.bounds;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.showsHorizontalScrollIndicator = NO ;
        // 注册cell
        [_collectionView registerClass:[XC_EmojiTabarCollectionViewCell class] forCellWithReuseIdentifier:xc_emojitabbarCell];
    }
    
    return _collectionView ;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XC_EmojiTabarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:xc_emojitabbarCell forIndexPath:indexPath];
    cell.backView.backgroundColor = [UIColor grayColor];
    NSString *imageString = _dataSource[indexPath.row];
    cell.backImageView.image = [UIImage imageNamed:imageString];
    
    if (self.defaultEmtionType) {
        if (indexPath.row == self.defaultEmtionType) {
            customcell = cell ;
            customcell.backView.backgroundColor = [UIColor whiteColor];
            return customcell;
        }
    }else if(indexPath.row == 0){
        customcell = cell ;
        customcell.backView.backgroundColor = [UIColor whiteColor];
        return customcell;
    }
    
    return cell;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.height, self.height);
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XC_EmojiTabarCollectionViewCell *cell = (XC_EmojiTabarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backView.backgroundColor = [UIColor grayColor];

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    customcell.backView.backgroundColor = [UIColor grayColor];
    
    XC_EmojiTabarCollectionViewCell *cell = (XC_EmojiTabarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backView.backgroundColor = [UIColor whiteColor];

    if ([self.delegate respondsToSelector:@selector(cilckEmotionsTabbar:AndcilckIndex:)]) {
        [self.delegate cilckEmotionsTabbar:self AndcilckIndex:indexPath.row];
    }
}

@end
