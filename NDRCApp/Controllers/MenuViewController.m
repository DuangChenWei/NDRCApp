//
//  MenuViewController.m
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "MenuViewController.h"
#import "QuestionListController.h"
#import "QYQurstionListController.h"
#import "TodayMessageController.h"
#import "StatisticsController.h"
#import "QuestionTJController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setPopGestureRecognizerOn=YES;
    [self initMainTitleBar:@"首页"];
    self.backBtn.hidden=YES;
    self.menubtn.hidden=YES;
    
    
    UIView *verLine=[[UIView alloc] init];
    verLine.backgroundColor=appLineColor;
    [self.view addSubview:verLine];
    
    UIView *horLine=[[UIView alloc] init];
    horLine.backgroundColor=appLineColor;
    [self.view addSubview:horLine];


    
    UIButton *btnDT=[self creatMainButtonWithTitle:@"今日动态" icon:@"今日动态icon.png"];

    [btnDT addTarget:self action:@selector(pushTodayMessageAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnWTHZ=[self creatMainButtonWithTitle:@"问题汇总" icon:@"问题汇总icon.png"];

    [btnWTHZ addTarget:self action:@selector(pushQuestionVCAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnTJ=[self creatMainButtonWithTitle:@"问题统计" icon:@"问题统计icon.png"];
    [btnTJ addTarget:self action:@selector(pushTJAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnWTFB=[self creatMainButtonWithTitle:@"问题分布" icon:@"问题分布icon.png"];

    
    [btnWTFB addTarget:self action:@selector(pushMapViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    horLine.sd_layout.centerXEqualToView(self.view).widthIs(1).topSpaceToView(self.view, appNavigationBarHeight+widthOn(35)).heightIs(widthOn(500));

    verLine.sd_layout.leftSpaceToView(self.view, widthOn(10)).rightSpaceToView(self.view, widthOn(10)).heightIs(1).centerYEqualToView(horLine);
    
    btnDT.sd_layout.leftEqualToView(verLine).topEqualToView(horLine).rightSpaceToView(horLine, 0).bottomSpaceToView(verLine, 0);
    btnWTHZ.sd_layout.leftSpaceToView(horLine, 0).topEqualToView(btnDT).rightEqualToView(verLine).bottomEqualToView(btnDT);
    btnTJ.sd_layout.leftEqualToView(btnDT).topSpaceToView(verLine, 0).rightEqualToView(btnDT).bottomEqualToView(horLine);
    btnWTFB.sd_layout.leftEqualToView(btnWTHZ).topEqualToView(btnTJ).rightEqualToView(btnWTHZ).bottomEqualToView(btnTJ);
    
    
    

    
    
    
    // Do any additional setup after loading the view.
}

-(UIButton *)creatMainButtonWithTitle:(NSString *)title icon:(NSString *)icon{

    UIButton *btnQY=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnQY setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [btnQY setTitle:title forState:UIControlStateNormal];

//    [btnQY addTarget:self action:@selector(pushMapViewAction) forControlEvents:UIControlEventTouchUpInside];
//    [btnQY setTitleColor:btnColor forState:UIControlStateNormal];
    [self.view addSubview:btnQY];

    UILabel *titlelabel=[[UILabel alloc] init];
    titlelabel.text=title;
    titlelabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [btnQY addSubview:titlelabel];
    titlelabel.textAlignment=NSTextAlignmentCenter;
    titlelabel.sd_layout.leftSpaceToView(btnQY, 0).rightSpaceToView(btnQY, 0).bottomSpaceToView(btnQY, 0).heightRatioToView(btnQY, 0.5);
    
    
    return btnQY;
    
}

-(void)pushTodayMessageAction{

    TodayMessageController *mv=[[TodayMessageController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];
}
-(void)pushTJAction{

    QuestionTJController *mv=[[QuestionTJController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];
}
-(void)pushMapViewAction{

    [self performSegueWithIdentifier:@"pushToMap" sender:self];
}

-(void)pushQuestionVCAction{

    
    StatisticsController *mv=[[StatisticsController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];
    
//    QuestionListController *mv=[[QuestionListController alloc] init];
////    QYQurstionListController *mv=[[QYQurstionListController alloc] init];
//    [self.navigationController pushViewController:mv animated:YES];
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
