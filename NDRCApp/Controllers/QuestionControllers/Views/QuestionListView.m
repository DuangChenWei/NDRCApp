//
//  QuestionListView.m
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionListView.h"

@implementation QuestionListView
-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


-(void)addAllViews{

    self.backBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.backBtn.frame=CGRectMake(0, 0, 64, 64);
   
    [self addSubview:self.backBtn];
    UIImageView *image=[[UIImageView alloc] init];
    image.frame=CGRectMake(widthOn(30), 34, 16, 16);
    image.image=[UIImage imageNamed:@"MainBackIcon.png"];
    [self.backBtn addSubview:image];

    self.searchTextField=[[UITextField alloc] init];
    self.searchTextField.placeholder=@"请输入企业名称、联系人";
    self.searchTextField.font=[UIFont systemFontOfSize:widthOn(34)];
    self.searchTextField.layer.borderColor=appLineColor.CGColor;
    self.searchTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.searchTextField.layer.borderWidth=1;
    self.searchTextField.layer.cornerRadius=widthOn(10);
    self.searchTextField.clipsToBounds=YES;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthOn(30), 34)];
    lbl.backgroundColor = [UIColor clearColor];
   
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.leftView=lbl;
    [self addSubview:self.searchTextField];
    
    self.searchTextField.sd_layout.leftSpaceToView(self.backBtn, widthOn(10)).topSpaceToView(self, 20+5).rightSpaceToView(self, widthOn(30)).heightIs(34);
    
    
    self.personBtn=[self creatButtonWithFrame:CGRectMake(0, appNavigationBarHeight, widthOn(200), widthOn(80)) title:@"责任人"];
   
    
    
    self.typeBtn=[self creatButtonWithFrame:CGRectMake(k_ScreenWidth*0.5-(widthOn(240))*0.5, CGRectGetMinY(self.personBtn.frame), widthOn(240), CGRectGetHeight(self.personBtn.frame)) title:@"全部状态"];
    
    self.timeBtn=[self creatButtonWithFrame:CGRectMake(k_ScreenWidth-CGRectGetWidth(self.typeBtn.frame), CGRectGetMinY(self.personBtn.frame), CGRectGetWidth(self.typeBtn.frame), CGRectGetHeight(self.personBtn.frame)) title:@"全部时间"];
    
    
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
