//
//  ViewController.m
//  JGGDemo
//
//  Created by apple on 17/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XC_JGGView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    XC_JGGView *jggView = [[XC_JGGView alloc] init];
    jggView.OnlyOneOptionalWH = 200 ;

    jggView.dataSource = (NSMutableArray *)@[@"1.png",@"1.png",@"1.png",@"1.png",@"2.png"];
    jggView.backgroundColor = [UIColor yellowColor];
    jggView.frame = CGRectMake(0, 0, 200 , 200);
    [self.view addSubview:jggView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
