//
//  StatisticsMainView.m
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "StatisticsMainView.h"

@implementation StatisticsMainView
-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        
        self.backScroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, CGRectGetHeight(frame))];
        self.backScroller.contentSize=CGSizeMake(k_ScreenWidth*3, CGRectGetHeight(self.frame));
        self.backScroller.pagingEnabled=YES;
//        self.backScroller.showsHorizontalScrollIndicator=NO;
//        self.backScroller.showsVerticalScrollIndicator=NO;
        [self addSubview:self.backScroller];
        
        self.firstView=[[statisticesFirstView alloc] initWithFrame:CGRectMake(0, 0, k_ScreenWidth, CGRectGetHeight(self.backScroller.frame))];
        [self.backScroller addSubview:self.firstView];
       
        
        
        self.secondView=[[statisticesSecondView alloc] initWithFrame:CGRectMake(k_ScreenWidth*1, 0, k_ScreenWidth, CGRectGetHeight(self.backScroller.frame))];
        [self.backScroller addSubview:self.secondView];
       
        
        self.thirdView=[[statisticesThirdView alloc] initWithFrame:CGRectMake(k_ScreenWidth*2, 0, k_ScreenWidth, CGRectGetHeight(self.backScroller.frame))];
        [self.backScroller addSubview:self.thirdView];
        
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
