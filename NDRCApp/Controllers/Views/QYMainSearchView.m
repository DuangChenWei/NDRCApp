//
//  QYMainSearchView.m
//  NDRCApp
//
//  Created by vp on 2017/5/18.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMainSearchView.h"
#import "QYMainSearchCell.h"
#import "QYPointModel.h"
@implementation QYMainSearchView
-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        self.clipsToBounds=YES;
        self.SearchType=0;
        self.backgroundColor=[UIColor clearColor];
        self.backView=[[UIView alloc] initWithFrame:frame];
        self.backView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.backView];
        CGFloat leftSpace=widthOn(20);
        self.topSearchBackView=[[UIView alloc] initWithFrame:CGRectMake(leftSpace, 20+leftSpace, k_ScreenWidth-widthOn(160), widthOn(80))];
        self.topSearchBackView.backgroundColor=[UIColor whiteColor];
        self.topSearchBackView.layer.borderColor=appLineColor.CGColor;
        self.topSearchBackView.layer.borderWidth=1;
        self.topSearchBackView.layer.cornerRadius=widthOn(10);
        [self addSubview:self.topSearchBackView];
        
        
        self.selectTypeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.topSearchBackView.frame), CGRectGetHeight(self.topSearchBackView.frame))];
        [self.selectTypeBtn setImage:[UIImage imageNamed:@"xiaLaDark.png"] forState:UIControlStateNormal];
        [self.topSearchBackView addSubview:self.selectTypeBtn];
        
        self.searchTextField=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectTypeBtn.frame)+CGRectGetMinX(self.selectTypeBtn.frame), 0, CGRectGetWidth(self.topSearchBackView.frame)-CGRectGetMaxX(self.selectTypeBtn.frame)-CGRectGetMinX(self.selectTypeBtn.frame), CGRectGetHeight(self.topSearchBackView.frame))];
        self.searchTextField.placeholder=@"请输入搜索内容";
        self.searchTextField.returnKeyType=UIReturnKeySearch;
        self.searchTextField.textColor=[UIColor blackColor];
        self.searchTextField.delegate=self;
        self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.searchTextField.font=[UIFont systemFontOfSize:widthOn(30)];
        [self.topSearchBackView addSubview:self.searchTextField];
        [self.searchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        
        self.backBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        self.backBtn.frame=CGRectMake(CGRectGetMaxX(self.topSearchBackView.frame), CGRectGetMinY(self.topSearchBackView.frame), k_ScreenWidth-CGRectGetMaxX(self.topSearchBackView.frame), CGRectGetHeight(self.topSearchBackView.frame));
        [self.backBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backBtn.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
        [self addSubview:self.backBtn];
        
        
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSearchBackView.frame), k_ScreenWidth, k_ScreenHeight- CGRectGetMaxY(self.topSearchBackView.frame)) style:UITableViewStylePlain];
        self.tableView.separatorColor=[UIColor clearColor];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.backgroundColor=[UIColor whiteColor];
        [self.backView addSubview:self.tableView];
        
        
    }
    return self;
}

-(void)showSearchView{
 
    [self.searchTextField becomeFirstResponder];
    self.searchTextField.text=@"";
    self.SearchType=0;
    [self.tableView reloadData];
    self.frame=CGRectMake(0, 0, k_ScreenWidth, k_ScreenHeight);
    self.backBtn.hidden=YES;
    self.backView.alpha=0;
    CGFloat leftSpace=widthOn(20);
    self.topSearchBackView.frame=CGRectMake(leftSpace, appNavigationBarHeight+leftSpace, k_ScreenWidth-leftSpace*2, widthOn(80));

    [UIView animateWithDuration:0.1 animations:^{
        self.topSearchBackView.frame=CGRectMake(leftSpace, 20+leftSpace, k_ScreenWidth-widthOn(160), widthOn(80));
        self.backView.alpha=1;
    } completion:^(BOOL finished) {
        self.backBtn.hidden=NO;
    }];

}
-(void)closeSearchView{

    [self.searchTextField resignFirstResponder];
    self.backBtn.hidden=YES;
    self.backView.alpha=1;
    CGFloat leftSpace=widthOn(20);
    self.topSearchBackView.frame=CGRectMake(leftSpace, 20+leftSpace, k_ScreenWidth-widthOn(160), widthOn(80));
    
    [UIView animateWithDuration:0.1 animations:^{
        self.topSearchBackView.frame=CGRectMake(leftSpace, appNavigationBarHeight+leftSpace, k_ScreenWidth-leftSpace*2, widthOn(80));
        self.backView.alpha=0;
    } completion:^(BOOL finished) {
        self.frame=CGRectMake(0, 0, k_ScreenWidth, 0);
    }];
}
-(void)updateSelectSearchTypeWithTag:(NSInteger)type{
    if (type==1) {
        self.searchTextField.placeholder=@"请输入企业名称";
        self.SearchType=1;
    }else if(type==2){
        self.SearchType=2;
        self.searchTextField.placeholder=@"请输入企业代码";
    }
    [self searchActionWIthText:self.searchTextField.text];
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
    
    if (self.SearchType==1||self.SearchType==0) {
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.qyName CONTAINS[c] %@", searchString];
        //过滤数据
        NSMutableArray *qySearchArray= [NSMutableArray arrayWithArray:[self.allDateArray filteredArrayUsingPredicate:preicate]];
        for ( QYPointModel *model in qySearchArray) {
            [self.searchDateArray addObject:model];
        }
    }
    
    if (self.SearchType==2||self.SearchType==0) {
        
        NSPredicate *preicate1 = [NSPredicate predicateWithFormat:@"SELF.qyId CONTAINS[c] %@", searchString];
        NSMutableArray *carNameArray= [NSMutableArray arrayWithArray:[self.allDateArray filteredArrayUsingPredicate:preicate1]];
        
        for ( QYPointModel *model in carNameArray) {
            [self.searchDateArray addObject:model];
        }
    }
    
    
    
    //刷新表格
    
    [self.tableView reloadData];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.searchDateArray.count?self.searchDateArray.count:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QYMainSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QYMainSearchCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:@"cell_id"];
    }
    QYPointModel *model=self.searchDateArray[indexPath.row];
    cell.nameLabel.text=model.qyName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self closeSearchView];
    if (self.delegate) {
        QYPointModel *model=self.searchDateArray[indexPath.row];
        [self.delegate showOneCompanyWithGraphic:model.graphic];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return widthOn(100);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}
-(void)dealloc{

    [self.searchTextField removeTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
