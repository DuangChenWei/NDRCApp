//
//  QYQurstionListController.m
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYQurstionListController.h"
#import "QYQuestionListView.h"
#import "QuestionListCell.h"
#import "QuestionMessageController.h"
#import "QuestionEditController.h"
#import "NetWorkManager.h"
#import "QuestionListModel.h"
@interface QYQurstionListController ()<UITableViewDelegate,UITableViewDataSource,QuestionEditControllerDelegate>
@property(nonatomic,strong)QYQuestionListView *myView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *ZRRArray;

@property(nonatomic,strong)NSMutableArray *tempArray;

@property(nonatomic,assign)int menuState;
@end

@implementation QYQurstionListController
-(void)viewWillAppear:(BOOL)animated{
    
    
    NSArray *dataArray = [NSArray array];
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectZero target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        
    }];
   
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [CommonMenuView clearMenu];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.setPopGestureRecognizerOn=YES;
    
    [self initMainTitleBar:@"企业问题汇总"];
    self.backBtn.hidden=YES;
    self.baseLineView.hidden=YES;
    [self.menubtn setImage:[UIImage imageNamed:@"addQuestion.png"] forState:UIControlStateNormal];
    [self.menubtn addTarget:self action:@selector(pushEditMessageAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.myView=[[QYQuestionListView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, k_ScreenWidth, k_ScreenHeight-appNavigationBarHeight)];
    self.myView.tableView.delegate=self;
    self.myView.tableView.dataSource=self;
    [self.myView.personBtn addTarget:self action:@selector(onclickPersionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.myView.typeBtn addTarget:self action:@selector(onclickTypeAction) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:self.myView];
    
     [self getQuestionListMessage];
    
    
    // Do any additional setup after loading the view.
}

-(void)refreshMessage{

    [self getQuestionListMessage];
}
-(void)pushEditMessageAction{

    QuestionEditController *mv=[[QuestionEditController alloc] init];
    mv.delegate=self;
    [self.navigationController pushViewController:mv animated:YES];
    
}
- (void)popMenu:(CGPoint)point{
    //    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
    
    if (self.menuState==101) {
        [self.myView.personBtn setTitle:str forState:UIControlStateNormal];
        [self.myView.typeBtn setTitle:@"全部状态" forState:UIControlStateNormal];
        
        [self changeMenuActionViewWithString:str searchType:@"ZRRName"];
        
    }else if (self.menuState==102){
        [self.myView.personBtn setTitle:@"全部责任人" forState:UIControlStateNormal];
        [self.myView.typeBtn setTitle:str forState:UIControlStateNormal];
        
        if (tag==1) {
            [self.myView.typeBtn setTitle:@"全部状态" forState:UIControlStateNormal];
        }
        
        [self changeMenuActionViewWithString:[NSString stringWithFormat:@"%ld",tag-2] searchType:@"state"];
        
        
        
    }else if (self.menuState==103) {
        
        
    }

    
}

-(void)changeMenuActionViewWithString:(NSString *)str searchType:(NSString *)type{
    
    
    
    if (self.tempArray!= nil) {
        [self.tempArray removeAllObjects];
    }else{
        
        self.tempArray=[NSMutableArray array];
    }
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.%@ CONTAINS[c] %@", type,str];
    //过滤数据
    NSMutableArray *qySearchArray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:preicate]];
    for ( QuestionListModel *model in qySearchArray) {
        [self.tempArray addObject:model];
    }
    
    [self.myView.tableView reloadData];
    
}


-(void)getQuestionListMessage{

    if (self.dataArray==nil) {
        self.dataArray=[NSMutableArray array];
    }
    if (self.ZRRArray==nil) {
        self.ZRRArray=[NSMutableArray array];
    }

    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObject:[NetWorkManager sharedInstance].userInfoModel.qyMessageModel.qyId forKey:@"proID"];

    NSLog(@"+++++%@",dic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_Problem" parameters:dic success:^(id response) {
        NSLog(@"返回%@",response);
        [[ProgressHud shareHud] stopLoading];
        [self.dataArray removeAllObjects];
        [self.ZRRArray removeAllObjects];
        id respon=response[@"AddAndCheckProblem"];
        if ([respon isKindOfClass:[NSArray class]]) {
            NSString *tempStr=@"";
            for (NSDictionary *dic in respon) {
                QuestionListModel *model=[[QuestionListModel alloc] init];
                [model setMessageWithDic:dic];
                [self.dataArray addObject:model];
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                [dic setValue:model.ZRRName forKey:@"itemName"];
                [dic setValue:@"" forKey:@"imageName"];
                
                if (![tempStr isEqualToString:model.ZRRName]&&![model.ZRRName isEqualToString:@""]) {
                    [self.ZRRArray addObject:dic];
                    tempStr=model.ZRRName;
                }

                
            }
            
            
        }else if ([respon isKindOfClass:[NSDictionary class]]){
            QuestionListModel *model=[[QuestionListModel alloc] init];
            [model setMessageWithDic:respon];
            [self.dataArray addObject:model];
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setValue:model.ZRRName forKey:@"itemName"];
            [dic setValue:@"" forKey:@"imageName"];
            
            [self.ZRRArray addObject:dic];
        }else{
        
        }
        NSMutableDictionary *dic0=[NSMutableDictionary dictionary];
        [dic0 setValue:@"全部责任人" forKey:@"itemName"];
        [dic0 setValue:@"" forKey:@"imageName"];
        [self.ZRRArray insertObject:dic0 atIndex:0];
        [self.myView.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
    }];

}


-(void)onclickPersionAction{
    
     self.menuState=101;
    
    [CommonMenuView updateMenuItemsWith:self.ZRRArray];
    
    [self popMenu:CGPointMake(CGRectGetMidX(self.myView.personBtn.frame), CGRectGetMaxY(self.myView.personBtn.frame)-widthOn(30)+appNavigationBarHeight)];
}
-(void)onclickTypeAction{
    
     self.menuState=102;
    
    NSDictionary *dict1 = @{@"imageName" : @"",
                            @"itemName" : @"全部状态"
                            };
    NSDictionary *dict2 = @{@"imageName" : @"",
                            @"itemName" : @"未处理"
                            };
    NSDictionary *dict3 = @{@"imageName" : @"",
                            @"itemName" : @"已处理"
                            };
    NSDictionary *dict4 = @{@"imageName" : @"",
                            @"itemName" : @"已驳回"
                            };
    
    NSArray *dataArray = @[dict1,dict2,dict3,dict4];
    [CommonMenuView updateMenuItemsWith:dataArray];
    
    [self popMenu:CGPointMake(CGRectGetMidX(self.myView.typeBtn.frame), CGRectGetMaxY(self.myView.typeBtn.frame)-widthOn(30)+appNavigationBarHeight)];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.tempArray.count!=0) {
        return self.tempArray.count;
    }
    return self.dataArray.count?self.dataArray.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QuestionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    QuestionListModel *model=self.dataArray[indexPath.row];
    if (self.tempArray.count!=0) {
        
        model=self.tempArray[indexPath.row];
    }

    cell.qyNameLabel.text=model.QYName;
    cell.questionTypeLabel.text=model.state;
    cell.qyContactLabel.text=model.TJRName;
    cell.timeLabel.text=model.submitTime;
    if ([model.state isEqualToString:@"2"]) {
        cell.questionTypeLabel.textColor=ColorWithAlpha(0x3183fd, 1);
        cell.questionTypeLabel.text=@"已驳回";
    }else if ([model.state isEqualToString:@"1"]) {
        cell.questionTypeLabel.textColor=ColorWithAlpha(0x999999, 1);
        cell.questionTypeLabel.text=@"已处理";
    }else{
        cell.questionTypeLabel.textColor=[UIColor redColor];
        cell.questionTypeLabel.text=@"未处理";
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QuestionMessageController *mv=[[QuestionMessageController alloc] init];
    mv.model=self.dataArray[indexPath.row];
    if (self.tempArray.count!=0) {
        
        mv.model=self.tempArray[indexPath.row];
    }

    [self.navigationController pushViewController:mv animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return widthOn(170);
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
