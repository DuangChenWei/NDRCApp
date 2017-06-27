//
//  QYQuestionListView.m
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYQuestionListView.h"

@implementation QYQuestionListView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


-(void)addAllViews{
    

    NSArray *nameArr=@[@"已受理",@"处理中",@"未处理",@"已驳回",@"已处理"];
    
    for (int i=0; i<5; i++) {
        UIButton *typeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [typeBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        [typeBtn.titleLabel setFont:[UIFont systemFontOfSize:widthOn(32)]];
        typeBtn.backgroundColor=appMainColor;
        if (i==0) {
            [typeBtn setBackgroundColor:ColorWithAlpha(0xd6362b, 1)];
        }
        [typeBtn setTitleColor:ColorWithAlpha(0xffffff, 0.8) forState:UIControlStateNormal];
        typeBtn.tag=123+i;
        [self addSubview:typeBtn];
        typeBtn.sd_layout.leftSpaceToView(self, k_ScreenWidth*0.2*i).topSpaceToView(self, 0).widthIs(k_ScreenWidth*0.2).heightIs(widthOn(80));
        [typeBtn addTarget:self action:@selector(onClickTypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
 
    
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0,widthOn(80), k_ScreenWidth, 1)];
    lineView.backgroundColor=appLineColor;
    [self addSubview:lineView];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), k_ScreenWidth, CGRectGetHeight(self.frame)-CGRectGetMaxY(lineView.frame)) style:UITableViewStylePlain];
    self.tableView.separatorColor=[UIColor clearColor];
    [self addSubview:self.tableView];
    
    
    
}
-(void)onClickTypeBtnAction:(UIButton *)sender{

    for (int i=0; i<5; i++) {
        UIButton *btn=(UIButton *)[self viewWithTag:123+i];
        [btn setBackgroundColor:appMainColor];
    }
    [sender setBackgroundColor:ColorWithAlpha(0xd6362b, 1)];
    
    if (self.delegate) {
        [self.delegate OnClickTypeBtnWithIndex:sender.tag-123];
    }
    
//    NSLog(@"点击%ld",[sender tag]);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
