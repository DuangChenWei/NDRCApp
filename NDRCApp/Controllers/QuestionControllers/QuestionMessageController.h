//
//  QuestionMessageController.h
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "BaseViewController.h"
#import "QuestionListModel.h"

@protocol QuestionMessageControllerDelegate <NSObject>
-(void)QuestionMessageControllerRefreshMessageAction;


@end

@interface QuestionMessageController : BaseViewController
@property(nonatomic,strong)QuestionListModel *model;
@property(nonatomic,assign)id<QuestionMessageControllerDelegate> delegate;
@end
