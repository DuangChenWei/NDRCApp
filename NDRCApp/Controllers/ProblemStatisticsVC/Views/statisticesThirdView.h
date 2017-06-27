//
//  statisticesThirdView.h
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionTJThirdCell.h"

@protocol statisticesThirdViewDelegate <NSObject>

-(void)ThirdViewOnSelectCellWithTitle:(NSString *)titleStr;

@end

@interface statisticesThirdView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)id<statisticesThirdViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *valueArray;
@end
