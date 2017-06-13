//
//  QuestionEditControllerViewController.h
//  NDRCApp
//
//  Created by vp on 2017/5/22.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "BaseViewController.h"

@protocol QuestionEditControllerDelegate <NSObject>

-(void)refreshMessage;

@end


@interface QuestionEditController : BaseViewController
@property(nonatomic,assign)id<QuestionEditControllerDelegate> delegate;
@end
