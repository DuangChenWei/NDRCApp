//
//  AddItemController.m
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "AddItemController.h"

@interface AddItemController ()

@end

@implementation AddItemController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"添加项目"];
    [self.menubtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.menubtn setTitle:@"提交" forState:UIControlStateNormal];
    CGRect rect=self.menubtn.frame;
    rect.origin.x=CGRectGetMinX(self.menubtn.frame)-widthOn(30);
    self.menubtn.frame=rect;

    [self.menubtn addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(void)sendMessageAction{

    
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
