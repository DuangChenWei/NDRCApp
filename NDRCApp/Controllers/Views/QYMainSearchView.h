//
//  QYMainSearchView.h
//  NDRCApp
//
//  Created by vp on 2017/5/18.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ArcGIS/ArcGIS.h>
@protocol QYSearchViewDelegate <NSObject>

-(void)showOneCompanyWithGraphic:(AGSGraphic *)graphic;

@end


@interface QYMainSearchView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIButton *selectTypeBtn;
@property(nonatomic,strong)UIView *topSearchBackView;
@property(nonatomic,strong)UITextField *searchTextField;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,assign)int SearchType;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *searchDateArray;
@property(nonatomic,strong)NSMutableArray *allDateArray;

@property(nonatomic,assign)id<QYSearchViewDelegate> delegate;

-(void)showSearchView;
-(void)closeSearchView;
-(void)updateSelectSearchTypeWithTag:(NSInteger)type;
@end
