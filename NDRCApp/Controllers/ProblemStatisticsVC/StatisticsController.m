//
//  StatisticsController.m
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "StatisticsController.h"
#import "StatisticsMainView.h"
#import "QuestionListController.h"
@interface StatisticsController ()<statisticesThirdViewDelegate,statisticesSecondViewDelegate,statisticesFirstViewDelegate>
@property(nonatomic,strong)StatisticsMainView *mainView;
@end

@implementation StatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainTitleBar:@"问题汇总"];
    self.menubtn.hidden=YES;
    self.mainView=[[StatisticsMainView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, k_ScreenWidth, k_ScreenHeight-appNavigationBarHeight)];
    self.mainView.firstView.delegate=self;
    self.mainView.secondView.delegate=self;
    self.mainView.thirdView.delegate=self;
    [self.view addSubview:self.mainView];
    
    // Do any additional setup after loading the view.
}
-(void)FirstViewOnSelectCellWithTitle:(NSString *)titleStr{

    [self pushQuestionListVCWithTitle:titleStr];
}
-(void)SecondViewOnSelectCellWithTitle:(NSString *)titleStr{

    [self pushQuestionListVCWithTitle:titleStr];
}
-(void)ThirdViewOnSelectCellWithTitle:(NSString *)titleStr{

    [self pushQuestionListVCWithTitle:titleStr];
}

-(void)pushQuestionListVCWithTitle:(NSString*)titleStr{

    QuestionListController *qv=[[QuestionListController alloc] init];
    qv.titleStr=titleStr;
    [self.navigationController pushViewController:qv animated:YES];
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
