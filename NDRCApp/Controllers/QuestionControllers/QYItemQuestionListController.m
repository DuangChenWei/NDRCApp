//
//  QYItemQuestionListController.m
//  NDRCApp
//
//  Created by vp on 2017/6/26.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYItemQuestionListController.h"
#import "QYQurstionListController.h"
#import "QYItemQuestionCell.h"
@interface QYItemQuestionListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *searchTextField;
@end

@implementation QYItemQuestionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@""];
    self.menubtn.hidden=YES;
    
    
    [self addTextField];
    
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 14;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QYItemQuestionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QYItemQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    cell.qyNameLabel.text=@"企业01";
    cell.qyContactLabel.text=@"李明子";
    cell.qyTimeLabel.text=@"2017.03.26 15:15:15";
    cell.qyQuestionNumberLabel.text=@"16";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYQurstionListController *qv=[[QYQurstionListController alloc] init];
    [self.navigationController pushViewController:qv animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return widthOn(180);
}

-(void)addTextField{

    self.searchTextField=[[UITextField alloc] init];
    self.searchTextField.delegate=self;
    self.searchTextField.placeholder=@"请输入企业名称";
    self.searchTextField.font=[UIFont systemFontOfSize:widthOn(30)];
    self.searchTextField.backgroundColor=ColorWithAlpha(0xffffff, 1);
    [self.view addSubview:self.searchTextField];
    
    self.searchTextField.leftViewMode=UITextFieldViewModeAlways;
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOn(34), 0)];
    self.searchTextField.leftView=leftView;
    
    self.searchTextField.rightViewMode=UITextFieldViewModeAlways;
//    UIView *rightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOn(27+50), 44-widthOn(30))];
    
    UIImageView *iconImv=[[UIImageView alloc] initWithFrame:CGRectMake(widthOn(25), (44-widthOn(30))*0.5-widthOn(13.5), widthOn(27)+20, widthOn(27))];
    
     UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(widthOn(10), CGRectGetHeight(iconImv.frame)*0.5-widthOn(13.5), widthOn(27), widthOn(27))];
    icon.image=[UIImage imageNamed:@"searchBlue.png"];
    [iconImv addSubview:icon];
    self.searchTextField.rightView=iconImv;
    
    self.searchTextField.sd_layout.centerXIs(k_ScreenWidth*0.5).widthIs(widthOn(550)).topSpaceToView(self.view, 20+widthOn(15)).heightIs(44-widthOn(30));
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
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
