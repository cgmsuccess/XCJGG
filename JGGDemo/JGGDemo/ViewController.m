//
//  ViewController.m
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XC_JGGView.h"
#import "UIView+Frame.h"
#import "testTableViewCell.h"

//颜色
#define randomColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define backColor [UIColor colorWithRed:66/255.0 green:124/255.0 blue:145/255.0 alpha:1]

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define MyrandomColor [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0f]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableview;

/** 这个属性是：数据源****/
@property (nonatomic,strong)NSMutableArray *dataSource ;

@end

@implementation ViewController

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

    for (int i =0; i< 20; i ++) {
        NSMutableArray *arr = [NSMutableArray new];
        int j = arc4random() % 8 +1 ;
       
        for (int n = 0; n<j; n++) {
            [arr addObject:@"1.png"];
        }
        [self.dataSource addObject:arr];
    }
    
    NSLog(@"%@",self.dataSource);
    
    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO ;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"testTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.width = 320 ;
    cell.jggview.dataSource = self.dataSource[indexPath.row];
    cell.jggview.backgroundColor = MyrandomColor ;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = self.dataSource[indexPath.row];
    
    NSLog(@"arr.count= %d",arr.count );
    testTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

     CGSize size = [cell.jggview setDtasouce:arr.count];
    
    return size.height ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
