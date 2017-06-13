//
//  ChooseItemsController.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ChooseItemsController.h"
#import "NetWorkManager.h"
#import "ChooseItemCell.h"
#import "QYPointModel.h"
@interface ChooseItemsController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITextField *searchTextField;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *searchDateArray;
@end

@implementation ChooseItemsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"添加项目"];
    self.menubtn.hidden=YES;
    
    self.searchTextField=[self creatTextFieldWithPlacrHoder:@"请输入企业名称"];
    self.searchTextField.sd_layout.leftSpaceToView(self.view, widthOn(20)).topSpaceToView(self.view, widthOn(20)+appNavigationBarHeight).rightSpaceToView(self.view, widthOn(20)).heightIs(widthOn(70));
    self.searchTextField.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(10)];
    [self.searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    UILabel *topLabel=[[UILabel alloc] init];
    topLabel.text=@"所有项目";
    topLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [self.view addSubview:topLabel];
    topLabel.sd_layout.leftEqualToView(self.searchTextField).topSpaceToView(self.searchTextField, 0).rightEqualToView(self.searchTextField).heightRatioToView(self.searchTextField, 1);
    
    self.tableView=[[UITableView alloc] init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(topLabel, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
    [self getDataFromServer];
    
    
    // Do any additional setup after loading the view.
}

-(UITextField *)creatTextFieldWithPlacrHoder:(NSString *)placeHoder{
    
    UITextField *textField=[[UITextField alloc] init];
    textField.placeholder=placeHoder;
//    textField.textAlignment=NSTextAlignmentRight;
    textField.font=[UIFont systemFontOfSize:widthOn(34)];
    textField.layer.borderColor=appDarkLineColor.CGColor;
    textField.layer.borderWidth=1;
    textField.backgroundColor=[UIColor whiteColor];
    textField.delegate=self;
    [self.view addSubview:textField];
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.rightViewMode=UITextFieldViewModeAlways;
    textField.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(20)];
    
    UIButton  *rightimage=[[UIButton alloc] initWithFrame:CGRectMake(0, widthOn(21.5),  widthOn(27)+widthOn(40), widthOn(27))];
    [rightimage setImage:[UIImage imageNamed:@"searchBlue.png"] forState:0];
    textField.rightView=rightimage;
    
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOn(20), widthOn(70))];
    textField.leftView=leftView;
   
    
    
    
    
    return textField;
    
}

-(void)getDataFromServer{

    if (self.dataArray==nil) {
        self.dataArray=[NSMutableArray array];
    }
    
    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Check_BRIEFINFO" parameters:nil success:^(id response) {
        [[ProgressHud shareHud] stopLoading];
        //            NSLog(@"--%@",response[@"BRIEF"]);
        id resPon=response[@"BRIEF"];
        if ([resPon isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in resPon) {
                
                QYPointModel *model=[[QYPointModel alloc] init];
                model.qyName=[NSString stringWithFormat:@"%@",dic[@"PRONAME"][@"text"]];
                model.qyId=[NSString stringWithFormat:@"%@",dic[@"ID"][@"text"]];
                [self.dataArray addObject:model];
            }
            
        }else if ([resPon isKindOfClass:[NSMutableDictionary class]]){
            
            QYPointModel *model=[[QYPointModel alloc] init];
            model.qyName=[NSString stringWithFormat:@"%@",resPon[@"PRONAME"][@"text"]];
            model.qyId=[NSString stringWithFormat:@"%@",resPon[@"ID"][@"text"]];
            [self.dataArray addObject:model];
            
        }else{
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"获取项目列表失败，请检查网络后重试"];
    }];

}

-(void)textFieldChange:(UITextField *)textField{
    
    
    NSString *searchString = [textField text];
    
    
    [self searchActionWIthText:searchString];
    
    
}
-(void)searchActionWIthText:(NSString *)searchString{
    
    if (self.searchDateArray!= nil) {
        [self.searchDateArray removeAllObjects];
    }else{
        
        self.searchDateArray=[NSMutableArray array];
    }
    
  
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.qyName CONTAINS[c] %@", searchString];
    //过滤数据
    NSMutableArray *qySearchArray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:preicate]];
    for ( QYPointModel *model in qySearchArray) {
        [self.searchDateArray addObject:model];
    }

    
    //刷新表格
    
    [self.tableView reloadData];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchDateArray.count>0 || ![self.searchTextField.text isEqualToString:@""]) {
        return self.searchDateArray.count;
        
    }

    return self.dataArray.count?self.dataArray.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ChooseItemCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[ChooseItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    QYPointModel *model=self.dataArray[indexPath.row];
    if (self.searchDateArray.count>0 || ![self.searchTextField.text isEqualToString:@""]) {
        model=self.searchDateArray[indexPath.row];
    }
    cell.titleLabel.text=[NSString stringWithFormat:@"%ld.%@",indexPath.row+1,model.qyName];
    if (indexPath.row<9) {
        cell.titleLabel.text=[NSString stringWithFormat:@"0%ld.%@",indexPath.row+1,model.qyName];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchTextField resignFirstResponder];
    QYPointModel *model=self.dataArray[indexPath.row];
    if (self.searchDateArray.count>0 || ![self.searchTextField.text isEqualToString:@""]) {
        model=self.searchDateArray[indexPath.row];
    }
    NSLog(@"%@",model.qyName);
    if (self.deleagte) {
        [self.deleagte updateItemMessageWithModel:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return widthOn(100);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [self.searchTextField removeTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
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
