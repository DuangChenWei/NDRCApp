//
//  BaseViewController.h
//  RainStationApp
//
//  Created by vp on 2017/4/27.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMenuView.h"
#import "UIView+AdjustFrame.h"
@interface BaseViewController : UIViewController
@property(nonatomic,assign)BOOL setPopGestureRecognizerOn;

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *menubtn;
@property(nonatomic,strong)UIView *baseLineView;
- (void) initTitleBar:(NSString *) title;
- (void) initMainTitleBar:(NSString *) title;
@end
