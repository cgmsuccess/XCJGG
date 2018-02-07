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
}

-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource ;
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
    return cell;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.height, self.height);
}

@end
