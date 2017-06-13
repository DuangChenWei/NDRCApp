//
//  StatisticsController.m
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "StatisticsController.h"
#import "StatisticsMainView.h"
@interface StatisticsController ()
@property(nonatomic,strong)StatisticsMainView *mainView;
@end

@implementation StatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainTitleBar:@"问题汇总"];
    self.menubtn.hidden=YES;
    self.mainView=[[StatisticsMainView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, k_ScreenWidth, k_ScreenHeight-appNavigationBarHeight)];
    [self.view addSubview:self.mainView];
    
    // Do any additional setup after loading the view.
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
