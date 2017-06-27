//
//  QuestionMessageController.m
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionMessageController.h"
#import "SJAvatarBrowser.h"
#import "NetWorkManager.h"
#import "UIImageView+WebCache.h"
#import "QuestionRespondController.h"
#import "myGeneralEditView.h"


@interface QuestionMessageController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UIView *respondView;
@end

@implementation QuestionMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"问题详情"];
    self.menubtn.hidden=YES;
    [self addAllViews];
    // Do any additional setup after loading the view.
}
-(void)addAllViews{
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self.view addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, 0, 0));
    
    UIView *topbackView=[[UIView alloc] init];
    topbackView.backgroundColor=[UIColor whiteColor];
    [self.backScroller addSubview:topbackView];
    topbackView.sd_layout.leftSpaceToView(self.backScroller, 0).topSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, 0).heightIs(widthOn(160));
    
    CGFloat leftSpace=widthOn(30);
    
    myGeneralEditView *typelabel=[self creatLabelWithTitle:@"已受理" name:@"审核状态"];
    typelabel.textField.layer.borderColor=[UIColor clearColor].CGColor;
    typelabel.textField.textColor=[UIColor greenColor];
    typelabel.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(80));
    
    UIView *lineView=[[UIView alloc] init];
    lineView.backgroundColor=ColorWithAlpha(0x999999, 0.1);
    [typelabel addSubview:lineView];
    lineView.sd_layout.leftSpaceToView(typelabel, 0).rightSpaceToView(typelabel, 0).bottomSpaceToView(typelabel, 0).heightIs(1);
    myGeneralEditView *gljlabel=[self creatLabelWithTitle:@"发改委" name:@"审核职能局"];
    gljlabel.textField.layer.borderColor=typelabel.textField.layer.borderColor;
    gljlabel.sd_layout.leftEqualToView(typelabel).rightEqualToView(typelabel).topSpaceToView(typelabel, 0).heightRatioToView(typelabel, 1);
    
    UIView *lineView1=[[UIView alloc] init];
    lineView1.backgroundColor=appLineColor;
    [self.backScroller addSubview:lineView1];
    lineView1.sd_layout.leftSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, 0).topSpaceToView(gljlabel, 0).heightIs(2);

    
    
    self.respondView=[[UIView alloc] init];
    self.respondView.backgroundColor=[UIColor whiteColor];
    [self.backScroller addSubview:self.respondView];
    self.respondView.sd_layout.leftSpaceToView(self.backScroller, 0).topSpaceToView(lineView1, 0).rightSpaceToView(self.backScroller, 0).heightIs(0);
    [self addResponsdMessageView];
    
    UIView *qyNamelabel=[self creatLabelWithTitle:self.model.QuestionID name:@"项目名称"];
    qyNamelabel.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.respondView, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(80));
    
    UIView *qyTimeLabel=[self creatLabelWithTitle:self.model.submitTime name:@"提报时间"];
    qyTimeLabel.sd_layout.leftEqualToView(qyNamelabel).rightEqualToView(qyNamelabel).topSpaceToView(qyNamelabel, leftSpace).heightRatioToView(qyNamelabel, 1);
    
    UIView *bigCategoryView=[self creatLabelWithTitle:self.model.ZRRName name:@"问题大类"];
    bigCategoryView.sd_layout.leftEqualToView(qyNamelabel).rightEqualToView(qyNamelabel).topSpaceToView(qyTimeLabel, leftSpace).heightRatioToView(qyNamelabel, 1);
    
    UIView *littleCategoryView=[self creatLabelWithTitle:self.model.GLJName name:@"问题小类"];
    littleCategoryView.sd_layout.leftEqualToView(qyNamelabel).rightEqualToView(qyNamelabel).topSpaceToView(bigCategoryView, leftSpace).heightRatioToView(qyNamelabel, 1);
    
    
    
    UIView *QuestionMessageView=[self creatLongMessageViewWithMessage:@"问题一大推怎么解决你说说看问题一大推怎么解决你说说看问题一大推怎么解决你说说看问题一大推怎么解决你说说看问题一大推怎么解决你说说看问题一大推怎么解决你说说看问题一大推怎么解决你说说看" name:@"问题描述"];
    QuestionMessageView.sd_layout.leftEqualToView(qyNamelabel).rightEqualToView(qyNamelabel).topSpaceToView(littleCategoryView, 0);
    
    
    [self.backScroller setupAutoHeightWithBottomView:QuestionMessageView bottomMargin:widthOn(50)];
    
    
    if ([NetWorkManager sharedInstance].powerStatus==Administrator) {
        
        self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(appNavigationBarHeight, 0, widthOn(130), 0));
        
        NSMutableArray *nameArr=[NSMutableArray arrayWithObjects:@"响 应",@"处 理",@"驳 回", nil];
        NSMutableArray *iconArr=[NSMutableArray arrayWithObjects:@"响应.png",@"处理.png",@"驳回.png", nil];
        
        
        for (int i=0; i<nameArr.count; i++) {
            UIButton *sloveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [sloveBtn setTitle:nameArr[i] forState:UIControlStateNormal];
            [sloveBtn setTitleColor:appDarkLabelColor forState:UIControlStateNormal];
            sloveBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
            [sloveBtn setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
            sloveBtn.tag=265+i;
            [sloveBtn addTarget:self action:@selector(sloveAuestionAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:sloveBtn];
            sloveBtn.sd_layout.leftSpaceToView(self.view, k_ScreenWidth/3*i).bottomSpaceToView(self.view, 0).widthIs(k_ScreenWidth/3).heightIs(widthOn(130));
            sloveBtn.sd_cornerRadius=@6;
            
            UIView *lineViewEnd=[[UIView alloc] init];
            lineViewEnd.backgroundColor=appLineColor;
            if (i!=0) {
                [self.view addSubview:lineViewEnd];
                lineViewEnd.sd_layout.leftEqualToView(sloveBtn).centerYEqualToView(sloveBtn).widthIs(1).heightIs(widthOn(50));
            }
            
            
            
            
        }

    }
    
    
   

    
    
}
-(void)addResponsdMessageView{


    UIView *tempView;
    for (int i=0; i<3; i++) {
       UIView *viewRe= [self creatRespondMessageWithModel:[NSString stringWithFormat:@"%d",i]];

        viewRe.sd_layout.leftSpaceToView(self.respondView, 0).rightSpaceToView(self.respondView, 0).topSpaceToView(tempView?tempView:self.respondView, 0);
        [self.respondView setupAutoHeightWithBottomView:viewRe bottomMargin:0];
        tempView=viewRe;
    }
}
-(myGeneralEditView *)creatLabelWithTitle:(NSString *) qtitle name:(NSString *)name{
    
    myGeneralEditView *viewQ=[[myGeneralEditView alloc] initWithTextFieldText:qtitle leftViewWidth:widthOn(300) couldEdit:NO placeHoder:@"" leftText:name];
    [self.backScroller addSubview:viewQ];
    
    
    return viewQ;
    
}

-(UIView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
    
    myGeneralEditView *viewQ=[[myGeneralEditView alloc] initContentMessageWithContentText:message topText:name];
    [self.backScroller addSubview:viewQ];
    
    NSMutableArray *arr=[NSMutableArray arrayWithObjects:@"textIcon.png",@"textIcon.png",@"textIcon.png", nil];
    

    
    for (int i=0; i<3; i++) {
        UIImageView *iconImage=[[UIImageView alloc] init];
        iconImage.image=[UIImage imageNamed:arr[i]];
        iconImage.userInteractionEnabled=YES;
//        iconImage.contentMode = UIViewContentModeScaleAspectFit;
        [viewQ.backView addSubview:iconImage];
        
        iconImage.sd_layout.leftEqualToView(viewQ.contentLabel).rightEqualToView(viewQ.contentLabel).topSpaceToView(viewQ.contentLabel,widthOn(10)+widthOn(510)*i).heightIs(widthOn(500));
        
        
        UITapGestureRecognizer *tapimv  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
        
        [iconImage addGestureRecognizer:tapimv];

        [viewQ.backView setupAutoHeightWithBottomView:iconImage bottomMargin:widthOn(15)];
        
        
        
    }
    
    
    
    
    
    
    return viewQ;
    
    
}

-(UIView *)creatRespondMessageWithModel:(NSString *)model{

    UIView *viewBack=[[UIView alloc] init];
    viewBack.backgroundColor=[UIColor whiteColor];
    [self.respondView addSubview:viewBack];
    
    
     CGFloat leftSpace=widthOn(30);
    
    myGeneralEditView *timeView=[self creatLabelWithTitle:@"2017.04.06 15:12:02" name:@"审核时间"];
    timeView.textField.layer.borderColor=[UIColor clearColor].CGColor;
    [timeView removeFromSuperview];
    [viewBack addSubview:timeView];
    timeView.sd_layout.leftSpaceToView(viewBack, leftSpace).rightSpaceToView(viewBack, leftSpace).topSpaceToView(viewBack, 0).heightIs(widthOn(80));
    
    UIView *lineView2=[[UIView alloc] init];
    lineView2.backgroundColor=ColorWithAlpha(0x999999, 0.1);
    [viewBack addSubview:lineView2];
    lineView2.sd_layout.leftEqualToView(timeView).rightEqualToView(timeView).topSpaceToView(timeView, 0).heightIs(1);
    
    NSString *conText=@"是不是啊实打实大师大手大脚阿达撒打开萨克达快递阿卡SD卡快速达斯柯达就爱看实践活动按客户打款时间等哈看手机打哈卡仕达";
    if ([model isEqualToString:@"2"]) {
        conText=@"是不是啊实打";
    }
    UIView *contentView=[[myGeneralEditView alloc] initContentMessageWithContentText:conText topText:@"审核说明"];
    [viewBack addSubview:contentView];
    contentView.sd_layout.leftSpaceToView(viewBack, leftSpace).topSpaceToView(lineView2, 0).rightSpaceToView(viewBack, leftSpace);
    UIView *lineView1=[[UIView alloc] init];
    lineView1.backgroundColor=appLineColor;
    [viewBack addSubview:lineView1];
    lineView1.sd_layout.leftSpaceToView(viewBack, 0).rightSpaceToView(viewBack, 0).bottomSpaceToView(viewBack, 0).heightIs(2);
    
    [viewBack setupAutoHeightWithBottomView:contentView bottomMargin:widthOn(20)+2];
    
  
    
    return viewBack;
    
}


-(void)sloveAuestionAction:(UIButton *)sender{

    NSString *str=@"";
    if (sender.tag==265) {
        NSLog(@"响应问题");
        str=@"1";
    }else if (sender.tag==266){
        NSLog(@"处理问题");
        str=@"2";
    }
    else{
        NSLog(@"驳回问题");
        str=@"3";
    }
    
    QuestionRespondController *mv=[[QuestionRespondController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];

//    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
//    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//    [dic setValue:self.model.QuestionID forKey:@"ID"];
//    [dic setValue:str forKey:@"state"];
//    
//    NSLog(@"+++++%@",dic);
//    
//    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Update_ProblemState" parameters:dic success:^(id response) {
//        NSLog(@"返回%@",response);
//        [[ProgressHud shareHud] stopLoading];
//        if ([response[@"STATE"][@"text"] isEqualToString:@"0"]) {
//            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"修改成功"];
//            [self.delegate QuestionMessageControllerRefreshMessageAction];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//        
//    } failure:^(NSError *error) {
//        [[ProgressHud shareHud] stopLoading];
//        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
//    }];

    
    
}


- (void)magnifyImage:(UIGestureRecognizer *)tap
{
    NSLog(@"局部放大");
    UIImageView *iconImage=(UIImageView *)[tap view];
    [SJAvatarBrowser showImage:iconImage];//调用方法
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
