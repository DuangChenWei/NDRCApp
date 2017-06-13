//
//  QYEditMessageController.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYEditMessageController.h"
#import "QYMessageEditView.h"
#import "ChooseItemsController.h"
@interface QYEditMessageController ()<ChooseItemDelegate>
@property(nonatomic,strong)QYMessageEditView *myView;
@end

@implementation QYEditMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"完善信息"];
    self.setPopGestureRecognizerOn=NO;
    self.menubtn.hidden=YES;
//    self.backBtn.hidden=YES;
    // Do any additional setup after loading the view.
    self.myView=[[QYMessageEditView alloc] initWithFrame:CGRectMake(0, appNavigationBarHeight, k_ScreenWidth, k_ScreenHeight-appNavigationBarHeight)];
    [self.myView.addItemBtn addTarget:self action:@selector(addItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myView];
    
    
}
-(void)addItemAction{

    [self.myView backKeybod];
    ChooseItemsController *mv=[[ChooseItemsController alloc] init];
    mv.deleagte=self;
    [self.navigationController pushViewController:mv animated:YES];
}
-(void)updateItemMessageWithModel:(QYPointModel *)model{

    for (int i=1; i<=self.myView.itemsArray.count; i++) {
        UILabel *lab=(UILabel *)[self.myView.itemView viewWithTag:100+i];
        [lab removeFromSuperview];
    }
    
    
    [self.myView.itemsArray addObject:model];
    [self.myView addItemView];
    
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
