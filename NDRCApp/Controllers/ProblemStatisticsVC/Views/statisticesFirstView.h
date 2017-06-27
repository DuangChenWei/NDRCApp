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

@protocol statisticesFirstViewDelegate <NSObject>

-(void)FirstViewOnSelectCellWithTitle:(NSString *)titleStr;

@end

@interface statisticesFirstView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,assign)id<statisticesFirstViewDelegate> delegate;
@end
