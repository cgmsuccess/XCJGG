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
            [self.delegate cilckEmotionsTabbar:self AndcilckIndex:self.defaultEmtionType];
        }else{
            [self.delegate cilckEmotionsTabbar:self AndcilckIndex:0];
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

-(void)switchemotion:(XC_EmojikeyTabbarCilckType)emtiontype
{
    self.defaultEmtionType = emtiontype ;
    [self.collectionView reloadData];
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
    //默认未选中的颜色
    cell.backView.backgroundColor = EmtionTabarncheckColor;
    NSString *imageString = _dataSource[indexPath.row];
    cell.imageName = imageString ;
   
    //设置选中的颜色
    if (self.defaultEmtionType) {
        if (indexPath.row == self.defaultEmtionType) {
            customcell = cell ;
            customcell.backView.backgroundColor = EmtionTabarSelectColor;
            return customcell;
        }
    }else if(indexPath.row == 0){
        customcell = cell ;
        customcell.backView.backgroundColor = EmtionTabarSelectColor;
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
    cell.backView.backgroundColor = EmtionTabarncheckColor;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    customcell.backView.backgroundColor = EmtionTabarncheckColor;
    
    XC_EmojiTabarCollectionViewCell *cell = (XC_EmojiTabarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backView.backgroundColor = EmtionTabarSelectColor;

    if ([self.delegate respondsToSelector:@selector(cilckEmotionsTabbar:AndcilckIndex:)]) {
        [self.delegate cilckEmotionsTabbar:self AndcilckIndex:indexPath.row];
    }
}
#pragma makr 绘制顶部直线

-(void)drawRect:(CGRect)rect
{
    //1 , 获取上下文 以后获取上下文直接用 UIGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2 , 设置绘图信息（拼接路径）
    UIBezierPath *path = [UIBezierPath bezierPath];
    //3 , 设置起点
    [path moveToPoint:CGPointMake(0, 0)];
    //添加一条线到某个点
    [path addLineToPoint:CGPointMake(self.size.width, 0)];
    //    [path addLineToPoint:CGPointMake(100, 180)];
    [[UIColor lightGrayColor] setStroke];
    
    //4 ,把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //5 , 渲染上下文 stroke描边
    CGContextStrokePath(ctx);
}

@end
