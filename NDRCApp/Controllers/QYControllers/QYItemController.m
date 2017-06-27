//
//  QYItemController.m
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYItemController.h"
#import "ItemsCell.h"
#import "AddItemController.h"
#import "ChangePasswordController.h"
@interface QYItemController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation QYItemController
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *dataArray = [NSArray array];
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectMake(0, 0,widthOn(200), 0) target:self dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [CommonMenuView clearMenu];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"项目汇总"];
    self.backBtn.hidden=YES;
    [self.menubtn addTarget:self action:@selector(showMenuView) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    // Do any additional setup after loading the view.
}

-(void)showMenuView{

    NSDictionary *dict2 = @{@"imageName" : @"",
                            @"itemName" : @"修改密码"
                            };
    
    NSArray *dataArray = @[dict2];
    [CommonMenuView updateMenuItemsWith:dataArray];
    
    [self popMenu:CGPointMake(self.navigationController.view.width - 20, 50)];
}

- (void)popMenu:(CGPoint)point{
    //    NSLog(@"点击了  展示");000
    [CommonMenuView showMenuAtPoint:point];
   ;
    
}
#pragma mark -- 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    
    [CommonMenuView hidden];
    
    ChangePasswordController *qv=[[ChangePasswordController alloc] init];
    
    [self.navigationController pushViewController:qv animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ItemsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[ItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    if (indexPath.row==4) {
        cell.addImageView.hidden=NO;
        
        cell.itemNameLabel.text=@"";
        cell.personNameLabel.text=@"";
        cell.timeLabel.text=@"";
    }else{
        cell.addImageView.hidden=YES;
       
        cell.itemNameLabel.text=@"项目名字一";
        cell.personNameLabel.text=@"张二狗";
        cell.timeLabel.text=@"2017.03.06 15:16:20";
    }
   cell.lineView.hidden=!cell.addImageView.hidden;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==4) {
        AddItemController *mv=[[AddItemController alloc] init];
        [self.navigationController pushViewController:mv animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return widthOn(160);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
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
