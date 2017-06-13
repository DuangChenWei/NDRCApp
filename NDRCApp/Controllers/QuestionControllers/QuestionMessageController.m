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
@interface QuestionMessageController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UIImageView *imageView;
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
    
    CGFloat leftSpace=widthOn(35);
    
    UIView *qyIDlabel=[self creatLabelWithTitle:self.model.QuestionID name:@"序号"];
    qyIDlabel.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, leftSpace).rightSpaceToView(self.backScroller, leftSpace).heightIs(widthOn(90));
    
    UIView *qyTimeLabel=[self creatLabelWithTitle:self.model.submitTime name:@"提报时间"];
    qyTimeLabel.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyIDlabel, leftSpace).heightRatioToView(qyIDlabel, 1);
    
    UIView *qyNameView=[self creatLabelWithTitle:self.model.ZRRName name:@"责任人"];
    qyNameView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyTimeLabel, leftSpace).heightRatioToView(qyIDlabel, 1);
    
    UIView *QuestionTypeView=[self creatLabelWithTitle:self.model.GLJName name:@"提报类型"];
    QuestionTypeView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(qyNameView, leftSpace).heightRatioToView(qyIDlabel, 1);
    
    
    UIView *QuestionMessageView=[self creatLongMessageViewWithMessage:self.model.problemContent name:@"提报问题"];
    QuestionMessageView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(QuestionTypeView, 0);
    
    self.imageView=[[UIImageView alloc] init];
    self.imageView.userInteractionEnabled=NO;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.iconURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.userInteractionEnabled=YES;
        self.imageView.image=image;
    }];
    self.imageView.clipsToBounds=YES;
    
    [self.backScroller addSubview:self.imageView];
    self.imageView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(QuestionMessageView, leftSpace).heightIs(widthOn(510));
   
    UITapGestureRecognizer *tapimv  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    
    [self.imageView addGestureRecognizer:tapimv];
    NSLog(@"---%@",self.model.iconURL);
    if ([self.model.iconURL isEqualToString:@""]) {
        self.imageView.sd_layout.leftEqualToView(qyIDlabel).rightEqualToView(qyIDlabel).topSpaceToView(QuestionMessageView, leftSpace).heightIs(0);
    }
    
    UIButton *sloveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [sloveBtn setTitle:@"处理" forState:UIControlStateNormal];
    [sloveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sloveBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [sloveBtn setBackgroundColor:appMainColor];
    sloveBtn.tag=265;
    [sloveBtn addTarget:self action:@selector(sloveAuestionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backScroller addSubview:sloveBtn];
    sloveBtn.sd_layout.leftEqualToView(qyIDlabel).topSpaceToView(self.imageView, leftSpace).widthIs(k_ScreenWidth*0.5-leftSpace*2).heightIs(widthOn(90));
    sloveBtn.sd_cornerRadius=@6;
    
    UIButton *rejectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rejectBtn setTitle:@"驳回" forState:UIControlStateNormal];
    [rejectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rejectBtn.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [rejectBtn setBackgroundColor:appDarkLabelColor];
    rejectBtn.tag=266;
    [rejectBtn addTarget:self action:@selector(sloveAuestionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backScroller addSubview:rejectBtn];
    rejectBtn.sd_layout.rightEqualToView(qyIDlabel).topEqualToView(sloveBtn).widthRatioToView(sloveBtn, 1).heightRatioToView(sloveBtn, 1);
    rejectBtn.sd_cornerRadius=@6;
    
    [self.backScroller setupAutoHeightWithBottomView:sloveBtn bottomMargin:widthOn(50)];
    
    if ([NetWorkManager sharedInstance].powerStatus!=Administrator) {
        sloveBtn.hidden=YES;
        rejectBtn.hidden=YES;
    }
    if (![self.model.state isEqualToString:@"0"]) {
        sloveBtn.hidden=YES;
        rejectBtn.hidden=YES;
    }
    
    
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

-(void)sloveAuestionAction:(UIButton *)sender{

    NSString *str=@"";
    if (sender.tag==265) {
        NSLog(@"处理问题");
        str=@"1";
    }else{
        NSLog(@"驳回问题");
        str=@"2";
    }
    

    [[ProgressHud shareHud] startLoadingWithShowView:self.view text:@""];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:self.model.QuestionID forKey:@"ID"];
    [dic setValue:str forKey:@"state"];
    
    NSLog(@"+++++%@",dic);
    
    [[NetWorkManager sharedInstance] GetDictionaryMethodWithUrl:@"Update_ProblemState" parameters:dic success:^(id response) {
        NSLog(@"返回%@",response);
        [[ProgressHud shareHud] stopLoading];
        if ([response[@"STATE"][@"text"] isEqualToString:@"0"]) {
            [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"修改成功"];
            [self.delegate QuestionMessageControllerRefreshMessageAction];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(NSError *error) {
        [[ProgressHud shareHud] stopLoading];
        [[NetWorkManager sharedInstance] showExceptionMessageWithString:@"请求失败，请检查网络后重试"];
    }];

    
    
}


- (void)magnifyImage
{
    NSLog(@"局部放大");
    [SJAvatarBrowser showImage:self.imageView];//调用方法
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
