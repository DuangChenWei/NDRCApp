//
//  myGeneralEditView.m
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "myGeneralEditView.h"

@implementation myGeneralEditView
- (instancetype)initWithTextFieldText:(NSString *)textFieldText leftViewWidth:(CGFloat)leftWidth couldEdit:(BOOL)couldEdit placeHoder:(NSString *)placeHoder leftText:(NSString *)leftText
{
    self = [super init];
    if (self) {
        self.textField=[[UITextField alloc] init];
        self.textField.placeholder=placeHoder;
        if (textFieldText) {
            self.textField.text=textFieldText;
        }
        self.textField.textAlignment=NSTextAlignmentRight;
        self.textField.font=[UIFont systemFontOfSize:widthOn(34)];
        self.textField.layer.borderColor=appDarkLineColor.CGColor;
        self.textField.layer.borderWidth=1;
        self.textField.backgroundColor=[UIColor whiteColor];
        self.textField.delegate=self;
        [self addSubview:self.textField];
        self.textField.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.textField.leftViewMode=UITextFieldViewModeAlways;
        self.textField.rightViewMode=UITextFieldViewModeAlways;
        self.textField.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(10)];
        
        
        UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, widthOn(34))];
        self.textField.leftView=leftView;
        
        self.leftLabel=[[UILabel alloc] initWithFrame:CGRectMake(widthOn(20), 0, CGRectGetWidth(leftView.frame)-widthOn(10), CGRectGetHeight(leftView.frame))];
        self.leftLabel.text=leftText;
        self.leftLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        self.leftLabel.textColor=[UIColor darkGrayColor];
        [leftView addSubview:self.leftLabel];
        
        UILabel *rightLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, widthOn(20), 0)];
        self.textField.rightView=rightLabel;
        
        
        self.textField.userInteractionEnabled=couldEdit;
        
        
       
    }
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}



//***********************************************************************
- (instancetype)initContentMessageWithContentText:(NSString *)ContentText topText:(NSString *)topText
{
    self = [super init];
    if (self) {

 
        UILabel *topLabel=[[UILabel alloc] init];
        topLabel.text=topText;
        topLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        topLabel.textColor=[UIColor blackColor];
        [self addSubview:topLabel];
        topLabel.sd_layout.leftSpaceToView(self, widthOn(20)).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(widthOn(90));
        [topLabel updateLayout];
        
        self.backView=[[UIView alloc] init];
        self.backView.layer.borderColor=appDarkLineColor.CGColor;
        self.backView.layer.borderWidth=1;
        self.backView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.backView];
        self.backView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(topLabel, 0).rightSpaceToView(self, 0);
        self.contentLabel=[[UILabel alloc] init];
        self.contentLabel.text=ContentText;
        self.contentLabel.font=topLabel.font;
        self.contentLabel.textColor=ColorWithAlpha(0x666666, 1);
        [self.backView addSubview:self.contentLabel];
        self.contentLabel.textAlignment=NSTextAlignmentLeft;
        self.contentLabel.sd_layout.leftEqualToView(topLabel).rightSpaceToView(self.backView,widthOn(20)).topSpaceToView(self.backView, widthOn(15)).autoHeightRatio(0);
        self.backView.sd_cornerRadius=@6.2;
        [self.backView setupAutoHeightWithBottomView:self.contentLabel bottomMargin:widthOn(15)];
        
        [self setupAutoHeightWithBottomView:self.backView bottomMargin:0];
        
  

    }
    return self;
}
//***************************************************************************
- (instancetype)initEditTextViewMessageWithContentText:(NSString *)ContentText topText:(NSString *)topText{

    self = [super init];
    if (self) {
        
        self.placeHoder=ContentText;
        
        UILabel *topLabel=[[UILabel alloc] init];
        topLabel.text=topText;
        topLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        topLabel.textColor=[UIColor blackColor];
        [self addSubview:topLabel];
        topLabel.sd_layout.leftSpaceToView(self, widthOn(20)).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(widthOn(90));
        [topLabel updateLayout];
        
        UIView *backView=[[UIView alloc] init];
        backView.layer.borderColor=appDarkLineColor.CGColor;
        backView.layer.borderWidth=1;
        backView.backgroundColor=[UIColor whiteColor];
        backView.clipsToBounds=YES;
        [self addSubview:backView];
        backView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(topLabel, 0).rightSpaceToView(self, 0);
        self.textView=[[UITextView alloc] init];
        self.textView.text=ContentText;
        self.textView.font=topLabel.font;
        self.textView.textColor=ColorWithAlpha(0x666666, 1);
        self.textView.delegate=self;
        [backView addSubview:self.textView];
        self.textView.textAlignment=NSTextAlignmentLeft;
        self.textView.sd_layout.leftEqualToView(topLabel).rightSpaceToView(backView,widthOn(20)).topSpaceToView(backView, widthOn(15)).heightIs(widthOn(250));
        backView.sd_cornerRadius=@6.2;
        [backView setupAutoHeightWithBottomView:self.textView bottomMargin:widthOn(15)];
        
        [self setupAutoHeightWithBottomView:backView bottomMargin:0];

        
        
        
    }
    return self;

}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeHoder]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = self.placeHoder;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.textView resignFirstResponder];
        return YES; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

//****************************************************************************


- (instancetype)initChooseButtonWithText:(NSString *)textFieldText leftViewWidth:(CGFloat)leftWidth leftText:(NSString *)leftText{
    self = [super init];
    if (self) {
    
        self=[self initWithTextFieldText:@"" leftViewWidth:widthOn(300) couldEdit:NO placeHoder:@"" leftText:leftText];
      
        self.chooseButton=[[UIButton alloc] init];
        [self.chooseButton setTitle:textFieldText forState:UIControlStateNormal];
        //    rightLabelBtn.backgroundColor=[UIColor greenColor];
        [self.chooseButton.titleLabel setFont:[UIFont systemFontOfSize:widthOn(34)]];
        [self.chooseButton setTitleColor:ColorWithAlpha(0x000000, 1) forState:UIControlStateNormal];
        [self addSubview:self.chooseButton];
        self.chooseButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        self.chooseButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(180), 0, widthOn(20)));

        
        
        
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
