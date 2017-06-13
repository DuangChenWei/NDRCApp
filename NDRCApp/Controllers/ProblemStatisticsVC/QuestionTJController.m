//
//  QuestionTJController.m
//  NDRCApp
//
//  Created by vp on 2017/6/9.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionTJController.h"

@interface QuestionTJController ()

@end

@implementation QuestionTJController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainTitleBar:@"问题统计"];
    self.menubtn.hidden=YES;
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
