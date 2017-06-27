//
//  statisticesFirstView.m
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "statisticesFirstView.h"

@implementation statisticesFirstView
-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        
        self.colorArray=[NSMutableArray arrayWithObjects:ColorWithAlpha(0xf6b317, 1),ColorWithAlpha(0x36d891, 1),ColorWithAlpha(0xff584f, 1),ColorWithAlpha(0xbe2821, 1), nil];
        self.titleArray=[NSMutableArray arrayWithObjects:@"已响应",@"已处理",@"未处理",@"已驳回", nil];
        self.valueArray=[NSMutableArray arrayWithObjects:@"36",@"20",@"15",@"3", nil];
        JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, k_ScreenWidth)];
        /*        background color         */
        ring.backgroundColor = [UIColor whiteColor];
        /*        Data source array, only the incoming value, the corresponding ratio will be automatically calculated         */
        ring.valueDataArr = [NSMutableArray arrayWithArray:self.valueArray];
        /*         Width of ring graph        */
        ring.ringWidth = 35.0;
        /*        Fill color for each section of the ring diagram         */
        ring.fillColorArray = [NSMutableArray arrayWithArray:self.colorArray];
        /*        Start animation             */
        [ring showAnimation];
        [self addSubview:ring];

        
        self.colorArray=[NSMutableArray arrayWithObjects:ColorWithAlpha(0xf6b317, 1),ColorWithAlpha(0x36d891, 1),ColorWithAlpha(0xff584f, 1),ColorWithAlpha(0xbe2821, 1), nil];
        
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ring.frame), k_ScreenWidth, frame.size.height-CGRectGetMaxY(ring.frame)) style:UITableViewStyleGrouped];
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

    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QuestionTJFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell==nil) {
        cell=[[QuestionTJFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    cell.titleLabel.text=self.titleArray[indexPath.row];
    cell.contentLabel.text=self.valueArray[indexPath.row];
    cell.stateIcon.backgroundColor=self.colorArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate) {
        [self.delegate FirstViewOnSelectCellWithTitle:self.titleArray[indexPath.row]];
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
