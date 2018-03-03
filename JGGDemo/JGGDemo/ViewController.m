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


#import "JGGDemoViewController.h"


NSString * const  syscell = @"syscell";

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
    
    //url 数据源
    [self getdata];
 
    
    [self setUI];
}

-(void)setUI
{
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:syscell];
}

-(void)getdata
{
   NSArray *arr = @[@"XC_JGGView的基本使用JGGDemo",@"UITextfile的简单封装JGGDemo1",@"表情键盘JGGDemo2",@"表情键盘JGGDemo3",@"表情键盘JGGDemo4"];
    
    self.dataSource = [NSMutableArray arrayWithArray:arr];
}


#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:syscell];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40  ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = self.dataSource[indexPath.row];
    
    NSRange range = [title rangeOfString:@"JGGDemo"];
    NSString *subTitle = [title substringToIndex:range.location]; //这个角标之前的字符串
    NSString *subTitle1 = [title substringFromIndex:range.location];//这个角标之后的字符串
    XCLog(@"subTitle = %@ subTitle1 = %@ ",subTitle ,subTitle1 );
    
    //字符串创建对象
    NSString *ctrlTitle = [NSString stringWithFormat:@"%@ViewController",subTitle1];
    UIViewController *vc = [NSClassFromString(ctrlTitle) new];
    vc.title = subTitle ;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
