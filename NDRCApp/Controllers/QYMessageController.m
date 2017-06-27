//
//  QYMessageController.m
//  NDRCApp
//
//  Created by vp on 2017/5/17.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMessageController.h"
#import "QuestionListController.h"
#import "myGeneralEditView.h"
#import "QYItemQuestionListController.h"
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
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn .titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
    [rightBtn addTarget:self action:@selector(pushToQuestionsVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    rightBtn.sd_layout.rightSpaceToView(self.view, 0).topSpaceToView(self.view, 20).widthIs(widthOn(130)).heightIs(44);
    
    
    [self addAllViews];
    
    
    // Do any additional setup after loading the view.
}
-(void)pushToQuestionsVC{

    NSLog(@"点击了问题");
    QYItemQuestionListController *mv=[[QYItemQuestionListController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];

}
-(void)addAllViews{

    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    CGFloat leftSpace=widthOn(35);
    

    UIView *qyIDlabel=[[myGeneralEditView alloc] initWithTextFieldText:self.model.qyId leftViewWidth:widthOn(300) couldEdit:NO placeHoder:@"" leftText:@"企业组织机构代码"];
    [self.backScroller addSubview:qyIDlabel];
    
    qyIDlabel.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(90));
    
    UIView *qyContactLabel=[[myGeneralEditView alloc] initWithTextFieldText:self.model.qyContact leftViewWidth:widthOn(200) couldEdit:NO placeHoder:@"" leftText:@"联系人信息"];
    [self.backScroller addSubview:qyContactLabel];
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



-(UIView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
   
    UIView *viewQ=[[myGeneralEditView alloc] initContentMessageWithContentText:message topText:name];
    [self.backScroller addSubview:viewQ];
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
