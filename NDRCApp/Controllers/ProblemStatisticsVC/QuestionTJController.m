//
//  QuestionTJController.m
//  NDRCApp
//
//  Created by vp on 2017/6/9.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionTJController.h"
#import "JHChartHeader.h"
@interface QuestionTJController ()

@end

@implementation QuestionTJController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"问题统计"];
    self.menubtn.hidden=YES;
    // Do any additional setup after loading the view.
    [self addZZTTop];
    [self addZZTCenter];
    
    [self showZZTTopView];
    [self showZZTCenterView];
}


-(UILabel*)addZZTTop{
    
    
    self.topColumn = [[JHColumnChartTJ alloc] initWithFrame:CGRectMake(0,widthOn(120), [UIScreen mainScreen].bounds.size.width, widthOn(420))];
    /*       This point represents the distance from the lower left corner of the origin.         */
    self.topColumn.originSize = CGPointMake(widthOn(60), widthOn(40));
    /*    The first column of the distance from the starting point     */
    self.topColumn.drawFromOriginX = widthOn(40);
    self.topColumn.typeSpace = widthOn(10);
    self.topColumn.isShowYLine = YES;
    /*        Column width         */
    self.topColumn.columnWidth = widthOn(50);
    /*        Column backgroundColor         */
    //    self.columnJiangYU.bgVewBackgoundColor = [UIColor whiteColor];
    /*        X, Y axis font color         */
    self.topColumn.drawTextColorForX_Y = ColorWithAlpha(0x67afcd, 1);
    /*        X, Y axis line color         */
    self.topColumn.colorForXYLine =ColorWithAlpha(0x67afcd, 1);
    
    [self.view addSubview:self.topColumn];
    
    
    UILabel *topTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topColumn.frame), k_ScreenWidth, widthOn(40))];
    topTitleLabel.textAlignment=NSTextAlignmentCenter;
    topTitleLabel.text=@"月问题分类统计";
    topTitleLabel.textColor=ColorWithAlpha(0x67afcd, 1);
    topTitleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [self.view addSubview:topTitleLabel];
    return topTitleLabel;
    
}


-(UILabel*)addZZTCenter{
    
    
    
    
    self.centerColumn = [[JHColumnChartTJ alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topColumn.frame)+widthOn(100), [UIScreen mainScreen].bounds.size.width, widthOn(420))];
    /*       This point represents the distance from the lower left corner of the origin.         */
    self.centerColumn.originSize = CGPointMake(widthOn(60), widthOn(40));
    /*    The first column of the distance from the starting point     */
    self.centerColumn.drawFromOriginX = widthOn(40);
    self.centerColumn.typeSpace = widthOn(20);
    self.centerColumn.isShowYLine = YES;
    /*        Column width         */
    self.centerColumn.columnWidth = widthOn(33);
    /*        Column backgroundColor         */
    //    self.columnJiangYU.bgVewBackgoundColor = [UIColor whiteColor];
    /*        X, Y axis font color         */
    self.centerColumn.drawTextColorForX_Y = ColorWithAlpha(0x67afcd, 1);
    /*        X, Y axis line color         */
    self.centerColumn.colorForXYLine =ColorWithAlpha(0x67afcd, 1);
    
    [self.view addSubview:self.centerColumn];
    
    
    UILabel *topTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.centerColumn.frame), k_ScreenWidth, widthOn(40))];
    topTitleLabel.textAlignment=NSTextAlignmentCenter;
    topTitleLabel.text=@"问题分类统计";
    topTitleLabel.textColor=ColorWithAlpha(0x67afcd, 1);
    topTitleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
    [self.view addSubview:topTitleLabel];
    return topTitleLabel;
}

-(void)showZZTCenterView{
    
    
    NSMutableArray *valueArr=[NSMutableArray array];
    NSMutableArray *xShowInfoText=[NSMutableArray array];
    NSMutableArray *colorArr=[NSMutableArray array];

    for (int i=0;i<10;i++) {
        [valueArr addObject:[NSArray arrayWithObject:[NSString stringWithFormat:@"%d",i]]];
        
        [xShowInfoText addObject:[NSString stringWithFormat:@"%d",i+1]];
        
        [colorArr addObject:ColorWithAlpha(0x5abeb2, 1)];
        
        
    }
    
    self.centerColumn.valueArr =valueArr;
    
    self.centerColumn.xShowInfoText = xShowInfoText;
    self.centerColumn.columnBGcolorsArr=colorArr;
    
    [self.centerColumn showAnimation];
    
    
    
}


-(void)showZZTTopView{

    
    NSMutableArray *valueArr=[NSMutableArray array];
    NSMutableArray *xShowInfoText=[NSMutableArray array];
    NSMutableArray *colorArr=[NSMutableArray array];

     for (int i=0;i<10;i++) {
         [valueArr addObject:[NSArray arrayWithObject:[NSString stringWithFormat:@"%d",i]]];
         
         [xShowInfoText addObject:[NSString stringWithFormat:@"%d",i+1]];
         
         [colorArr addObject:ColorWithAlpha(0x5abeb2, 1)];

        
        
    }
    
    self.topColumn.valueArr =valueArr;
    
    self.topColumn.xShowInfoText = xShowInfoText;
    self.topColumn.columnBGcolorsArr=colorArr;
    
    [self.topColumn showAnimation];
    
    
    
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
