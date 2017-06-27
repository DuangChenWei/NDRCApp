//
//  QuestionRespondView.m
//  NDRCApp
//
//  Created by vp on 2017/6/14.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionRespondView.h"
#import "myGeneralEditView.h"
@implementation QuestionRespondView
-(instancetype)init{
    
    self=[super init];
    if (self) {
        [self addAllViewsWithMessage:nil];
    }
    return self;
}


-(void)addAllViewsWithMessage:(id)tempMessage{
    
    self.backScroller=[[UIScrollView alloc] init];
    self.backScroller.delegate=self;
    self.backScroller.backgroundColor=ColorWithAlpha(0xf9f9f9, 1);
    [self addSubview:self.backScroller];
    self.backScroller.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    CGFloat leftSpace=widthOn(26);

    
    
    
    myGeneralEditView *QuestionMessageView=[self creatLongMessageViewWithMessage:@"请填写回复信息..." name:@""];
    self.textView=QuestionMessageView.textView;
    QuestionMessageView.sd_layout.leftSpaceToView(self.backScroller, leftSpace).topSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, leftSpace);

    
    
    self.chooseImageView=[[ChooseImageView alloc] init];
    [self.backScroller addSubview:self.chooseImageView];
    self.chooseImageView.sd_layout.leftSpaceToView(self.backScroller, 0).rightSpaceToView(self.backScroller, 0).topSpaceToView(QuestionMessageView, widthOn(20)).heightIs(widthOn(500));
    
    self.doneButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.doneButton setTitle:@"受理" forState:0];
    [self.doneButton setTitleColor:ColorWithAlpha(0xffffff, 1) forState:UIControlStateNormal];
    [self.doneButton.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
    [self.doneButton setBackgroundColor:appMainColor];
    [self.backScroller addSubview:self.doneButton];
    self.doneButton.sd_layout.centerXEqualToView(self.backScroller).bottomSpaceToView(self.backScroller, widthOn(80)).widthIs(widthOn(400)).heightIs(widthOn(85));
    
    [self.backScroller setupAutoHeightWithBottomView:self.chooseImageView bottomMargin:widthOn(50)];

    
    
    
    
}

-(myGeneralEditView *)creatLongMessageViewWithMessage:(NSString *)message name:(NSString *)name{
    
    myGeneralEditView *viewQ=[[myGeneralEditView alloc] initEditTextViewMessageWithContentText:message topText:name];
    [self.backScroller addSubview:viewQ];
    
    return viewQ;
    
    
}








#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.backScroller.sd_closeAutoLayout = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
