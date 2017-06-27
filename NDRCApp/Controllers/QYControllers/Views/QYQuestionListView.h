//
//  QYQuestionListView.h
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYQuestionListViewDelegate <NSObject>

-(void)OnClickTypeBtnWithIndex:(NSInteger)indexType;

@end

@interface QYQuestionListView : UIView

@property(nonatomic,assign)id<QYQuestionListViewDelegate> delegate;
@property(nonatomic,strong)UITableView *tableView;
@end
