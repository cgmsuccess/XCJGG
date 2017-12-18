//
//  JGGDemoViewController.m
//  JGGDemo
//
//  Created by apple on 17/12/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JGGDemoViewController.h"
#import "XC_JGGView.h"
#import "testTableViewCell.h"

@interface JGGDemoViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 这个属性是：数据源****/
@property (nonatomic,strong)NSMutableArray *dataSource ;

@end

@implementation JGGDemoViewController


-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setUI];

    //url 数据源
    [self getUrlData];
    
    //字符串数据源
    //[self getStringData];
    
    
}

-(void)setUI
{
    self.navigationController.title = self.title ;
    self.automaticallyAdjustsScrollViewInsets = YES  ; //自动偏移
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"testTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(void)getStringData
{
    for (int i =0; i< 20; i ++) {
        NSMutableArray *arr = [NSMutableArray new];
        int j = arc4random() % 7 + 1 ;
        
        for (int n = 0; n<j; n++) {
            [arr addObject:[NSString stringWithFormat:@"%d.png",arc4random() % 4 + 1]];
        }
        
        [self.dataSource addObject:arr];
    }
}


-(void)getUrlData
{
    // url  数据源
    NSArray *urlarr = @[@"https://www.nkbjx.com/cn_xc_news/news/getImage?imagePath=201712151105172850.png",
                        @"https://www.nkbjx.com/cn_xc_news/news/getImage?imagePath=201712151105172850.png",
                        @"http://d.hiphotos.baidu.com/image/h%3D300/sign=5bd487e5adefce1bf52bceca9f51f3e8/d000baa1cd11728b8c2b4831c2fcc3cec3fd2c9b.jpg",
                        @"http://a.hiphotos.baidu.com/image/h%3D300/sign=c422b5f010d8bc3ed90800cab289a6c8/e7cd7b899e510fb3a787775dd033c895d0430c59.jpg",
                        @"http://img2.imgtn.bdimg.com/it/u=3444993638,2265221608&fm=27&gp=0.jpg",
                        @"http://g.hiphotos.baidu.com/image/h%3D300/sign=94562fcdde3f8794ccff4e2ee21b0ead/728da9773912b31bb642015c8c18367adab4e19d.jpg",
                        @"http://h.hiphotos.baidu.com/image/h%3D300/sign=24aad742f7039245beb5e70fb795a4a8/b8014a90f603738d4e132dadb81bb051f919ece0.jpg",
                        @"http://c.hiphotos.baidu.com/image/h%3D300/sign=0f766644b9fb4316051f7c7a10a54642/ac345982b2b7d0a23eef0212c0ef76094b369a1e.jpg",
                        @"http://g.hiphotos.baidu.com/image/h%3D300/sign=1a98b52bafc27d1eba263dc42bd4adaf/3812b31bb051f81948bf04c5d1b44aed2f73e7a3.jpg"];
    NSMutableArray *urlArrs = [NSMutableArray array];
    
    
    //转成url
    for (NSString *strUrl  in urlarr) {
        NSURL *url = [NSURL URLWithString:strUrl];
        [urlArrs addObject:url];
    }
    
    
    for (int i =0; i< 20; i ++) {
        NSMutableArray *arr = [NSMutableArray new];
        int j = arc4random() % 8 +1 ;
        
        for (int n = 0; n<j; n++) {
            [arr addObject:urlArrs[n]];
        }
        [self.dataSource addObject:arr];
    }
    
}


#pragma maek UitableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = NO ;
    
    //设置单个图片的时候的图片宽度
    cell.jggview.OnlyOneOptionalWH = 120 ;
    
    //设置底图
    cell.jggview.placeholderImage = [UIImage imageNamed:@"2.png"];
    
    
    
    cell.jggview.cilckhandle = ^(NSInteger index ,NSMutableArray *dataSource){
        XCLog(@"index = %ld ,option = %@" ,index ,dataSource[index]);
    };
    
    
    cell.jggview.dataSource = self.dataSource[indexPath.row];
    cell.jggview.backgroundColor = MyrandomColor ;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = self.dataSource[indexPath.row];
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //设置单个图片的时候的图片宽度,如果设置了单个图片的宽度，那么这个不能少
    cell.jggview.OnlyOneOptionalWH = 120 ;
    
    CGSize size = [cell.jggview setDtasouce:arr.count];
    
    return size.height + 10  ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
