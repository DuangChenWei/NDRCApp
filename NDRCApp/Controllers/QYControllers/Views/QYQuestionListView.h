//
//  QYQuestionListView.h
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYQuestionListView : UIView
@property(nonatomic,strong)UIButton *personBtn;
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UIButton *timeBtn;

@property(nonatomic,strong)UITableView *tableView;
@end
