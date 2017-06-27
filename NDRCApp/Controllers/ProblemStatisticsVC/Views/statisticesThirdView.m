//
//  statisticesThirdView.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "statisticesThirdView.h"

@implementation statisticesThirdView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        
        self.valueArray=[NSMutableArray arrayWithObjects:@"36",@"20",@"15", nil];
        
      
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, frame.size.height) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor=[UIColor whiteColor];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self addSubview:self.tableView];
        
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 13;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionTJThirdCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QuestionTJThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    NSString *titleStr=[NSString stringWithFormat:@"%ld.",indexPath.row];
    if (indexPath.row<10) {
        titleStr=[NSString stringWithFormat:@"0%ld.",indexPath.row];
    }
    cell.titleLabel.text=titleStr;
    cell.contentLabel.text=@"问问问问问问问问问题";
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        [self.delegate ThirdViewOnSelectCellWithTitle:@"问问问问问题"];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return widthOn(88);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
