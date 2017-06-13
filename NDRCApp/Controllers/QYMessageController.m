//
//  QYMessageController.m
//  NDRCApp
//
//  Created by vp on 2017/5/17.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMessageController.h"
#import "QuestionListController.h"
@interface QYMessageController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *backScroller;
@end

@implementation QYMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initMainTitleBar:@"项目详情"];
     self.menubtn.hidden=YES;
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"问题" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn .titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
    [rightBtn addTarget:self action:@selector(pushToQuestionsVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    rightBtn.sd_layout.rightSpaceToView(self.view, 0).topSpaceToView(self.view, 20).widthIs(widthOn(130)).heightIs(44);
    
    
    [self addAllViews];
    
    
    // Do any additional setup after loading the view.
}
-(void)pushToQuestionsVC{

    NSLog(@"点击了问题");
    QuestionListController *qv=[[QuestionListController alloc] init];
    [self.navigationController pushViewController:qv animated:YES];
}
-(void)addAllViews{

    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    CGFloat leftSpace=widthOn(35);
    
    UIView *qyIDlabel=[self creatLabelWithTitle:self.model.qyId name:@"企业组织机构代码"];
    qyIDlabel.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(90));
    
    UIView *qyContactLabel=[self creatLabelWithTitle:self.model.qyContact name:@"联系人信息"];
    qyContactLabel.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyIDlabel, leftSpace).heightRatioToView(qyIDlabel, 1);
    
    UIView *qyNameView=[self creatLongMessageViewWithMessage:self.model.qyName name:@"项目名称"];
    qyNameView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyContactLabel, 0);
   
    UIView *qyAddressView=[self creatLongMessageViewWithMessage:self.model.qyAddress name:@"建设地址"];
    qyAddressView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyNameView, 0);
    
    UIView *qyProgressView=[self creatLongMessageViewWithMessage:self.model.qyProgress name:@"建设进度"];
    qyProgressView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyAddressView, 0);
    
    UIView *qyMessageView=[self creatLongMessageViewWithMessage:self.model.qyMessage name:@"企业简介"];
    qyMessageView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyProgressView, 0);
    
    UIView *qyBuildMessageView=[self creatLongMessageViewWithMessage:self.model.qyBuildMessage name:@"建设内容"];
    qyBuildMessageView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyMessageView, 0);
    
    
    [self.backScroller setupAutoHeightWithBottomView:qyBuildMessageView bottomMargin:widthOn(50)];
    
}

-(UIView *)creatLabelWithTitle:(NSString *) qtitle name:(NSString *)name{

    UIView *viewQ=[[UIView alloc] init];
    viewQ.layer.borderColor=appDarkLineColor.CGColor;
    viewQ.layer.borderWidth=1;
    viewQ.backgroundColor=[UIColor whiteColor];
    [self.backScroller addSubview:viewQ];
    viewQ.sd_cornerRadius=@6.2;
    
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.text=name;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=[UIColor darkGrayColor];
    [viewQ addSubview:leftLabel];
    leftLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(20), 0, 0));
    
    UILabel *rightLabel=[[UILabel alloc] init];
    rightLabel.text=qtitle;
    rightLabel.font=leftLabel.font;
    [viewQ addSubview:rightLabel];
    rightLabel.textAlignment=NSTextAlignmentRight;
    rightLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(300), 0, widthOn(20)));
    
    
    return viewQ;
    
}

-(UIView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
   
    UIView *viewQ=[[UIView alloc] init];
    
    [self.backScroller addSubview:viewQ];
   
    
    UILabel *leftLabel=[[UILabel alloc] init];
    leftLabel.text=name;
    leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    leftLabel.textColor=[UIColor blackColor];
    [viewQ addSubview:leftLabel];
    leftLabel.sd_layout.leftSpaceToView(viewQ, widthOn(20)).topSpaceToView(viewQ, 0).rightSpaceToView(viewQ, 0).heightIs(widthOn(90));
    [leftLabel updateLayout];
    
    UIView *backView=[[UIView alloc] init];
    backView.layer.borderColor=appDarkLineColor.CGColor;
    backView.layer.borderWidth=1;
    backView.backgroundColor=[UIColor whiteColor];
    [viewQ addSubview:backView];
    backView.sd_layout.leftSpaceToView(viewQ, 0).topSpaceToView(leftLabel, 0).rightSpaceToView(viewQ, 0);
    UILabel *rightLabel=[[UILabel alloc] init];
    rightLabel.text=message;
    rightLabel.font=leftLabel.font;
    rightLabel.textColor=ColorWithAlpha(0x666666, 1);
    [backView addSubview:rightLabel];
    rightLabel.textAlignment=NSTextAlignmentLeft;
    rightLabel.sd_layout.leftEqualToView(leftLabel).rightSpaceToView(backView,widthOn(20)).topSpaceToView(backView, widthOn(15)).autoHeightRatio(0);
    backView.sd_cornerRadius=@6.2;
    [backView setupAutoHeightWithBottomView:rightLabel bottomMargin:widthOn(15)];
    
    [viewQ setupAutoHeightWithBottomView:backView bottomMargin:0];
    
    return viewQ;

    
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
