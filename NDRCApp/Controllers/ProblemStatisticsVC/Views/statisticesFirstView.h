//
//  statisticesFirstView.h
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHChartHeader.h"
#import "QuestionTJFirstCell.h"
@interface statisticesFirstView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@end
