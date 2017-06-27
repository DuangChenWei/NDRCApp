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
#import "ChangePasswordController.h"
#import "QYEvaluateListController.h"
@interface QYQurstionListController ()<UITableViewDelegate,UITableViewDataSource,QuestionEditControllerDelegate,QYQuestionListViewDelegate>
@property(nonatomic,strong)QYQuestionListView *myView;
@property(nonatomic,strong)NSMutableArray *dataArray;


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
    if ([NetWorkManager sharedInstance].powerStatus==QYAdmin || [NetWorkManager sharedInstance].powerStatus==QYUser ) {
        self.backBtn.hidden=YES;
        [self.menubtn addTarget:self action:@selector(showMenuAction) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.menubtn.hidden=YES;
    }
    
    self.baseLineView.hidden=YES;
    
    
    self.myView=[[QYQuestionListView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, k_ScreenWidth, k_ScreenHeight-appNavigationBarHeight)];
    self.myView.tableView.delegate=self;
    self.myView.tableView.dataSource=self;
    self.myView.delegate=self;
    [self.view addSubview:self.myView];
    
//     [self getQuestionListMessage];
    
    
    // Do any additional setup after loading the view.
}




- (void)popMenu:(CGPoint)point{
    //    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
    
    if (tag==1) {
        QuestionEditController *mv=[[QuestionEditController alloc] init];
        mv.delegate=self;
        [self.navigationController pushViewController:mv animated:YES];
    }else if (tag==2){
        
        QYEvaluateListController *mv=[[QYEvaluateListController alloc] init];
        [self.navigationController pushViewController:mv animated:YES];
        
    }else if (tag==3){
    
        ChangePasswordController *mv=[[ChangePasswordController alloc] init];
        [self.navigationController pushViewController:mv animated:YES];
        
    }
}



-(void)refreshMessage{

    [self getQuestionListMessage];
}
-(void)showMenuAction{

    
    NSArray *nameArr=@[@"上报问题",@"待评价问题",@"修改密码"];
    NSMutableArray *arrValue=[NSMutableArray array];
    for (NSString *str in nameArr) {
        NSDictionary *dict1 = @{@"imageName" : @"",
                                @"itemName" : str
                                };
        [arrValue addObject:dict1];
    }
    
    
    
    NSArray *dataArray =[NSArray arrayWithArray:arrValue];
    [CommonMenuView updateMenuItemsWith:dataArray];
    
    [self popMenu:CGPointMake(self.navigationController.view.width - 20, 50)];
    
    
    
    
}
-(void)OnClickTypeBtnWithIndex:(NSInteger)indexType{

    NSLog(@"点击了按钮：%ld",indexType);
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


    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];//WithObject: forKey:@"proID"];

    [dic setValue:[NetWorkManager sharedInstance].userInfoModel.qyMessageModel.qyId forKey:@"proID"];
    NSLog(@"+++++%@",dic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_Problem" parameters:dic success:^(id response) {
        NSLog(@"返回%@",response);
        [[ProgressHud shareHud] stopLoading];
        [self.dataArray removeAllObjects];
      
        id respon=response[@"AddAndCheckProblem"];
        if ([respon isKindOfClass:[NSArray class]]) {
        
            for (NSDictionary *dic in respon) {
                QuestionListModel *model=[[QuestionListModel alloc] init];
                [model setMessageWithDic:dic];
                [self.dataArray addObject:model];
  
            }
            
            
        }else if ([respon isKindOfClass:[NSDictionary class]]){
            QuestionListModel *model=[[QuestionListModel alloc] init];
            [model setMessageWithDic:respon];
            [self.dataArray addObject:model];
    
        }else{
        
        }
   
        [self.myView.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
    }];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 10;
    
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
//    QuestionListModel *model=self.dataArray[indexPath.row];
//    if (self.tempArray.count!=0) {
//        
//        model=self.tempArray[indexPath.row];
//    }
//
//    cell.qyNameLabel.text=model.QYName;
//    cell.questionTypeLabel.text=model.state;
//    cell.qyContactLabel.text=model.TJRName;
//    cell.timeLabel.text=model.submitTime;
//    if ([model.state isEqualToString:@"2"]) {
//        cell.questionTypeLabel.textColor=ColorWithAlpha(0x3183fd, 1);
//        cell.questionTypeLabel.text=@"已驳回";
//    }else if ([model.state isEqualToString:@"1"]) {
//        cell.questionTypeLabel.textColor=ColorWithAlpha(0x999999, 1);
//        cell.questionTypeLabel.text=@"已处理";
//    }else{
//        cell.questionTypeLabel.textColor=[UIColor redColor];
//        cell.questionTypeLabel.text=@"未处理";
//    }
    
    
        cell.qyNameLabel.text=@"沈阳沈阳";
        cell.questionTypeLabel.text=@"已驳回";
        cell.qyContactLabel.text=@"李明子";
        cell.timeLabel.text=@"2017.05.16 20:20:20";
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QuestionMessageController *mv=[[QuestionMessageController alloc] init];
//    mv.model=self.dataArray[indexPath.row];
//    if (self.tempArray.count!=0) {
//        
//        mv.model=self.tempArray[indexPath.row];
//    }

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
