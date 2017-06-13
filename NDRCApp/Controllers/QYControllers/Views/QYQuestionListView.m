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
    

    
    self.personBtn=[self creatButtonWithFrame:CGRectMake((k_ScreenWidth-widthOn(600))/3, 0, widthOn(300), widthOn(80)) title:@"全部责任人"];
    
    
    
    self.typeBtn=[self creatButtonWithFrame:CGRectMake(k_ScreenWidth-CGRectGetMaxX(self.personBtn.frame), CGRectGetMinY(self.personBtn.frame),CGRectGetWidth(self.personBtn.frame), CGRectGetHeight(self.personBtn.frame)) title:@"全部状态"];
    
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.personBtn.frame), k_ScreenWidth, 1)];
    lineView.backgroundColor=appLineColor;
    [self addSubview:lineView];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), k_ScreenWidth, CGRectGetHeight(self.frame)-CGRectGetMaxY(lineView.frame)) style:UITableViewStylePlain];
    self.tableView.separatorColor=[UIColor clearColor];
    [self addSubview:self.tableView];
    
    
    
}

-(UIButton *)creatButtonWithFrame:(CGRect )frame title:(NSString *)title{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:ColorWithAlpha(0x666666, 1) forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:widthOn(32)];
    [self addSubview:btn];
    
    UIImageView *sanjiaoImv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sanjiaoDark"]];
    [btn addSubview:sanjiaoImv];
    sanjiaoImv.sd_layout.rightSpaceToView(btn, widthOn(34)).centerYEqualToView(btn).widthIs(widthOn(10)).heightIs(widthOn(7));
    
    return btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
