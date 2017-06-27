//
//  QuestionEditView.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMessageEditView.h"
#import "QYPointModel.h"
@implementation QYMessageEditView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.itemsArray=[NSMutableArray array];
        [self addAllViews];
    }
    return self;
}


-(void)addAllViews{
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    CGFloat verSpace=widthOn(34);
    
    self.ZZJGTextField=[self creatTextFieldWithName:@"组织机构代码" placrHoder:@"请输入企业信息代码"];
    self.ZZJGTextField.sd_layout.leftSpaceToView(self.backScroller, widthOn(34)).rightSpaceToView(self.backScroller, widthOn(34)).topSpaceToView(self.backScroller, widthOn(32)).heightIs(widthOn(70));
    self.qyNameTextfield=[self creatTextFieldWithName:@"名称" placrHoder:@"请输入企业名称"];
    self.qyNameTextfield.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.ZZJGTextField, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    itemTextField=[self creatTextFieldWithName:@"所属项目" placrHoder:@""];
    itemTextField.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.qyNameTextfield, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    UIView *temView=[[UIView alloc] init];
    [itemTextField addSubview:temView];
    temView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.addItemBtn=[UIButton buttonWithType:0];
    [self.addItemBtn setImage:[UIImage imageNamed:@"addQuestion.png"] forState:0];
    
    [itemTextField addSubview:self.addItemBtn];
    self.addItemBtn.sd_layout.rightSpaceToView(itemTextField, 0).topSpaceToView(itemTextField, 0).bottomSpaceToView(itemTextField, 0).widthEqualToHeight();
    

    
    
    self.itemView=[self creatItemsViewWithTitle:@""];
    [self addItemView];
    self.itemView.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(itemTextField, 0).heightIs(0);
    
    
    self.qyAddressTextfield=[self creatTextFieldWithName:@"地址" placrHoder:@"请输入企业地址"];
    self.qyAddressTextfield.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.itemView, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    self.qyTelTextfield=[self creatTextFieldWithName:@"联系电话" placrHoder:@"请输入联系电话"];
    self.qyTelTextfield.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.qyAddressTextfield, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    
    self.qyMailTextfield=[self creatTextFieldWithName:@"企业邮箱" placrHoder:@"请输入企业邮箱"];
    self.qyMailTextfield.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.qyTelTextfield, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    self.qyBossTextfield=[self creatTextFieldWithName:@"企业法人" placrHoder:@"请输入企业法人"];
    self.qyBossTextfield.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.qyMailTextfield, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    self.qyHtmlTextField=[self creatTextFieldWithName:@"企业网站" placrHoder:@"请输入企业网站"];
    self.qyHtmlTextField.sd_layout.leftEqualToView(self.ZZJGTextField).rightEqualToView(self.ZZJGTextField).topSpaceToView(self.qyBossTextfield, verSpace).heightRatioToView(self.ZZJGTextField, 1);
    
    UIButton *doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"提交审核" forState:0];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:0];
    [doneBtn setBackgroundColor:appMainColor];
    [doneBtn.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
    [self.backScroller addSubview:doneBtn];
    doneBtn.sd_layout.centerXEqualToView(self.backScroller).topSpaceToView(self.qyHtmlTextField, widthOn(100)).heightIs(widthOn(90)).widthIs(widthOn(400));
    
    
    [self.backScroller setupAutoHeightWithBottomView:doneBtn bottomMargin:widthOn(50)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeybod)];
    [self.backScroller addGestureRecognizer:tap];
    
}
-(UITextField *)creatTextFieldWithName:(NSString *)name placrHoder:(NSString *)placeHoder{
    
    UITextField *textField=[[UITextField alloc] init];
    textField.placeholder=placeHoder;
    textField.textAlignment=NSTextAlignmentRight;
    textField.font=[UIFont systemFontOfSize:widthOn(34)];
    textField.layer.borderColor=appDarkLineColor.CGColor;
    textField.layer.borderWidth=1;
//    textField.backgroundColor=[UIColor whiteColor];
    textField.delegate=self;
    [self.backScroller addSubview:textField];
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.rightViewMode=UITextFieldViewModeAlways;
    textField.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(10)];
    
   
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOn(240), widthOn(70))];
    textField.leftView=leftView;
    
    UILabel *leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(widthOn(10), 0, CGRectGetWidth(leftView.frame)-widthOn(10), CGRectGetHeight(leftView.frame))];
    leftLabel.text=name;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=[UIColor darkGrayColor];
    [leftView addSubview:leftLabel];
    
    UILabel *rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthOn(10), 0)];
    textField.rightView=rightLabel;
    
    
    return textField;
    
}

-(UIView *)creatItemsViewWithTitle:(NSString *)title{


    
    UIView *viewQ=[[UIView alloc] init];
    viewQ.layer.borderColor=appDarkLineColor.CGColor;
    viewQ.layer.borderWidth=1;
//    viewQ.backgroundColor=[UIColor whiteColor];
    [self.backScroller addSubview:viewQ];
    viewQ.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(10)];
    
    
    return viewQ;
    
}
-(void)addItemView{

    for (int i=1; i<=self.itemsArray.count; i++) {
        QYPointModel *model=self.itemsArray[i-1];
        UILabel *itemLabel=[[UILabel alloc] init];
        itemLabel.text=[NSString stringWithFormat:@"0%d.%@",i,model.qyName];
        itemLabel.font=[UIFont systemFontOfSize:widthOn(28)];
        itemLabel.numberOfLines=2;
    
        [self.itemView addSubview:itemLabel];
        itemLabel.sd_layout.leftSpaceToView(self.itemView, widthOn(10)).topSpaceToView(self.itemView, widthOn(80)*(i-1)).rightSpaceToView(self.itemView, widthOn(10)+widthOn(80)).heightIs(widthOn(80));
        
        UIButton *btn=[UIButton buttonWithType:0];
        [btn setImage:[UIImage imageNamed:@"itemDeleteIcon.png"] forState:0];
        [self.itemView addSubview:btn];
        btn.tag=250+i;
        [btn addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.sd_layout.leftSpaceToView(itemLabel, 0).topEqualToView(itemLabel).widthIs(widthOn(80)).heightRatioToView(itemLabel, 1);
        
        UIView *lineView=[[UIView alloc] init];
        lineView.backgroundColor=appLineColor;
        [self.itemView addSubview:lineView];
     
        lineView.sd_layout.leftEqualToView(itemLabel).bottomSpaceToView(self.itemView, 0).heightIs(1).rightSpaceToView(self.itemView, widthOn(10));
        
        [self.itemView setupAutoHeightWithBottomView:btn bottomMargin:widthOn(0)];
    }
    
    if (self.itemsArray.count==0) {
        itemTextField.layer.borderColor=appDarkLineColor.CGColor;
     
    }else{
        itemTextField.layer.borderColor=[UIColor clearColor].CGColor;
        
    }

    
}
-(void)deleteItemAction:(UIButton *)sender{

    NSLog(@"删除项目");
    QYPointModel *model=self.itemsArray[sender.tag-251];
    [self updateItemViewWithModel:model isDeleteType:YES];
}
-(void)updateItemViewWithModel:(QYPointModel *)model isDeleteType:(BOOL)isDelete{

    
    for (UIView *viewQ in self.itemView.subviews) {
        [viewQ removeFromSuperview];
        
    }

    
    if (isDelete) {
        [self.itemsArray removeObject:model];
    }else{
        [self.itemsArray addObject:model];
    }
    
    [self addItemView];
}


-(void)backKeybod{

    [self.ZZJGTextField resignFirstResponder];
    [self.qyNameTextfield resignFirstResponder];
    [self.qyAddressTextfield resignFirstResponder];
    [self.qyTelTextfield resignFirstResponder];
    [self.qyMailTextfield resignFirstResponder];
    [self.qyBossTextfield resignFirstResponder];
    [self.qyHtmlTextField resignFirstResponder];
   
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
