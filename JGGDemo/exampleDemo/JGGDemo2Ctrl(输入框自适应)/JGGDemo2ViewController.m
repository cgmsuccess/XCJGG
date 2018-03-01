//
//  JGGDemo2ViewController.m
//  JGGDemo
//
//  Created by 陈桂民 on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JGGDemo2ViewController.h"
#import "XC_TextView.h"
#import "XC_keyboardManager.h"
#import "XC_EmojikeyBoardView.h"
#import "XCEmotionTool.h"
#import "XCWordChangeTool.h"


@interface JGGDemo2ViewController ()<UITextViewDelegate,XCComposeToolbarTopDelegate,UITableViewDataSource,UITableViewDelegate>

/**   键盘     ****/
@property (nonatomic,strong)XC_keyboardManager *keyBaord;

/**     UITableView     ****/
@property (nonatomic,strong)UITableView *tableView ;

/**     DataSource     ****/
@property (nonatomic,strong)NSMutableArray *DataSource;

@end


@implementation JGGDemo2ViewController

-(NSMutableArray *)DataSource
{
    if (!_DataSource) {
        _DataSource = [NSMutableArray new];
        [_DataSource addObject:@"刚刚好！你说我是有的只是想起以前一样是[爱你][爱你][哈哈][馋嘴][馋嘴][哈哈]ddfggg[爱你][爱你][爱你][爱你][爱你][挖鼻屎][挖鼻屎][挖鼻屎]"];
    }
    return _DataSource ;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self ;
    }
    return _tableView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
    [self.keyBaord showXCKeyboard];
}



-(void)setUI
{
    
    self.keyBaord = [[XC_keyboardManager alloc] initWithFrame:CGRectMake(0, KmainScreenHeiht,  KmainScreenWidth, 106)];
    
    self.keyBaord.showKeyboardButton = YES ;
    self.keyBaord.delegate = self ;
    self.keyBaord.backgroundColor = [UIColor yellowColor];
    self.keyBaord.stringAndHeightHandle = ^(NSString *inputString, CGFloat height) {
        
    };
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBaord];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark XCComposeToolbarTopDelegate

-(void)composeToolbar:(XC_keyboardManager *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XC_ComposeToolbarButtonTypeMention:
            //@
            [self.view endEditing:YES];

            break;
        case XC_ComposeToolbarButtonTypeSend:
            //发送
            [self sendMassge:toolbar];
            break;
        default:
            break;
    }
}

/**  发送消息   */
-(void)sendMassge:(XC_keyboardManager *)keyboardView
{
    XC_EmotionTextView *emtionsTextView = [keyboardView viewWithTag:XC_ComposeToolbarButtonTypeInputView];
    XCLog(@"emtionsTextView.text = %@" , [emtionsTextView fullText]);
    [self.DataSource addObject:[emtionsTextView fullText]];
  
    
    //插入列表中
    NSMutableArray *indexPaths = [[NSMutableArray alloc]init];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.DataSource.count - 1 inSection:0];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:self.DataSource.count - 1 inSection:0];
    [indexPaths addObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}



#pragma mark UItableViewDelegate UItaleViewDataSorce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *cellText = self.DataSource[indexPath.row];

    cell.textLabel.attributedText = [XCWordChangeTool attributedTextWithText:cellText] ;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0 ;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = self.DataSource[indexPath.row];
   
    CGFloat rowHeight = [XCWordChangeTool autoHeightWithAttrebutString:[XCWordChangeTool attributedTextWithText:cellText]  AndscreenWidth:KmainScreenWidth - 32 ];
    
    return rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //唤起键盘。
    [self.keyBaord showXCKeyboard];

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
