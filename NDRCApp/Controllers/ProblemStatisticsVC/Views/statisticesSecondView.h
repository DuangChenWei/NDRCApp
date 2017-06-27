//
//  statisticesSecondView.h
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHChartHeader.h"
#import "QuestionTJFirstCell.h"

@protocol statisticesSecondViewDelegate <NSObject>

-(void)SecondViewOnSelectCellWithTitle:(NSString *)titleStr;

@end

@interface statisticesSecondView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property(nonatomic,assign)id<statisticesSecondViewDelegate> delegate;
@end
