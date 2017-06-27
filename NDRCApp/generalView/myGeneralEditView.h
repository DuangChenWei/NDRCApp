//
//  myGeneralEditView.h
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myGeneralEditView : UIView<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *leftLabel;


- (instancetype)initWithTextFieldText:(NSString *)textFieldText leftViewWidth:(CGFloat)leftWidth couldEdit:(BOOL)couldEdit placeHoder:(NSString *)placeHoder leftText:(NSString *)leftText;


//*******************************************************
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UILabel *contentLabel;
- (instancetype)initContentMessageWithContentText:(NSString *)ContentText topText:(NSString *)topText;

//********************************************************
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,copy)NSString *placeHoder;
- (instancetype)initEditTextViewMessageWithContentText:(NSString *)ContentText topText:(NSString *)topText;


//************************************************
@property(nonatomic,strong)UIButton *chooseButton;
- (instancetype)initChooseButtonWithText:(NSString *)textFieldText leftViewWidth:(CGFloat)leftWidth leftText:(NSString *)leftText;

@end
