//
//  StatisticsMainView.h
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "statisticesFirstView.h"
#import "statisticesSecondView.h"
#import "statisticesThirdView.h"
@interface StatisticsMainView : UIView
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)statisticesFirstView *firstView;
@property(nonatomic,strong)statisticesSecondView *secondView;
@property(nonatomic,strong)statisticesThirdView *thirdView;
@end
