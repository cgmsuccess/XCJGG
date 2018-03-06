//
//  JGGDemo4ViewController.m
//  JGGDemo
//
//  Created by gao bin on 2018/3/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "JGGDemo4ViewController.h"
#import "XC_keyboardManager.h"
@interface JGGDemo4ViewController ()<XCComposeToolbarTopDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)XC_keyboardManager *keyBoardManager;

/**    展示回复      ****/
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *DataSource;

/**     键盘弹起来的高度 的 Y 值    ****/
@property (nonatomic,assign)CGFloat showKeyBoardheight;

/**      记录最开始点击cell的 point     ****/
@property (nonatomic)CGPoint historyPoint ;


@end

@implementation JGGDemo4ViewController

-(UITableView *)tableView
{
    if (!_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

-(NSMutableArray *)DataSource
{
    if (!_DataSource) {
        _DataSource = [NSMutableArray new];
        [_DataSource addObject:@"刚刚好！你说我是有的只是想起以前一样是[爱你][爱你][哈哈][馋嘴][馋嘴][哈哈]ddfggg[爱你][爱你][爱你][爱你][爱你][挖鼻屎][挖鼻屎][挖鼻屎]"];
    }
    return _DataSource ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}

-(void)setUI
{
    
    [self.view addSubview:self.tableView];
    
    
    //键盘
    self.view.backgroundColor = [UIColor whiteColor];
    XC_keyboardManager *manager  = [[XC_keyboardManager alloc] init];
    self.keyBoardManager = manager ;
    XC_EmotionInputView *emtionsInputView = [manager getXC_EmotionInputView];
    emtionsInputView.stringAndHeightHandle = ^(NSString *inputString, CGFloat height) {
        
    };
    emtionsInputView.backgroundColor = [UIColor whiteColor];
    emtionsInputView.frame =  CGRectMake(0, KmainScreenHeiht,  KmainScreenWidth, 106);
    emtionsInputView.keyBoardY = KmainScreenHeiht ;
    emtionsInputView.delegate = self;
    [self.view addSubview:emtionsInputView];
    
    
    
    
}

#pragma mark 

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
    [self.keyBoardManager.getXC_EmotionInputView showXCKeyboard];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.historyPoint = cell.frame.origin ;
    
    
    XCLog(@"cell.point = %@" ,NSStringFromCGPoint(cell.frame.origin));
    
    //转换坐标系----> window
    CGRect rect =  [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    XCLog(@"转变坐标系cell.point = %@" ,NSStringFromCGPoint(rect.origin));
    if (rect.origin.y + rect.size.height< self.showKeyBoardheight) {
        //键盘没有遮挡住
        
    }else if(rect.origin.y + rect.size.height  > self.showKeyBoardheight){
        //键盘遮挡住
       
        CGPoint offsetPoint = CGPointMake(cell.frame.origin.x, cell.frame.origin.y - (self.showKeyBoardheight - cell.frame.size.height));
        
        _historyPoint = offsetPoint ;
        XCLog(@"offsetPoint = %@" ,NSStringFromCGPoint(offsetPoint));
        
        [self.tableView setContentOffset:offsetPoint animated:YES];
    }
    
    
}


-(void)dealloc
{
    XCLog(@"%@",NSStringFromClass([self class]));
}


#pragma mark XCComposeToolbarTopDelegate
-(void)composeToolbar:(XC_EmotionInputView *)toolbar didClickButton:(XC_ComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XC_ComposeToolbarButtonTypeMention:
            //@
            XCLog(@"点击了@");
            
            break;
        case XC_ComposeToolbarButtonTypeSend:
            //发送
            [self sendMassge:toolbar];
            break;
        default:
            break;
    }
}

/**  键盘高度   */
-(void)showKwyboradViewHeight:(CGFloat)keyboardHeight
{
    // 键盘的 相对于手机平米的Y 值
    self.showKeyBoardheight = KmainScreenHeiht - keyboardHeight;
    XCLog(@"keyboardHeight = %lf",keyboardHeight);
    
}

/**   隐藏键盘  */
-(void)hideKeyBoardView
{
    
}

#pragma mark Other
/**  发送消息   */
-(void)sendMassge:(XC_EmotionInputView *)keyboardView
{
    //获取到输入框
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

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.keyBoardManager.getXC_EmotionInputView showXCKeyboard];
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
