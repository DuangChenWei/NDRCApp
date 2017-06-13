//
//  QuestionListView.h
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionListView : UIView

@property(nonatomic,strong)UITextField *searchTextField;

@property(nonatomic,strong)UIButton *personBtn;
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *timeBtn;

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UITableView *tableView;
@end
