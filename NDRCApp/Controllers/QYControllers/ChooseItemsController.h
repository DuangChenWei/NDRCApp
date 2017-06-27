//
//  ChooseItemsController.h
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "BaseViewController.h"
#import "QYPointModel.h"
@protocol ChooseItemDelegate <NSObject>

-(BOOL)updateItemMessageWithModel:(QYPointModel *)model;

@end

@interface ChooseItemsController : BaseViewController
@property(nonatomic,assign)id<ChooseItemDelegate> deleagte;
@end
