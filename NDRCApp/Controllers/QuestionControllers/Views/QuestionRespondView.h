//
//  QuestionRespondView.h
//  NDRCApp
//
//  Created by vp on 2017/6/14.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChooseImageView.h"
@interface QuestionRespondView : UIView<UITextViewDelegate,UIScrollViewDelegate>
{


}
@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)ChooseImageView *chooseImageView;

@property(nonatomic,strong)UIButton *doneButton;
@end
