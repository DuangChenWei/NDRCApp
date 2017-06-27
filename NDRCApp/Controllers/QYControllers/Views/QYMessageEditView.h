//
//  QuestionEditView.h
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYPointModel.h"
@interface QYMessageEditView : UIView<UIScrollViewDelegate,UITextFieldDelegate>

{

    UITextField *itemTextField;
}

@property(nonatomic,strong)UIScrollView *backScroller;
@property(nonatomic,strong)UITextField *ZZJGTextField;
@property(nonatomic,strong)UITextField *qyNameTextfield;
@property(nonatomic,strong)UITextField *qyAddressTextfield;
@property(nonatomic,strong)UITextField *qyTelTextfield;
@property(nonatomic,strong)UITextField *qyMailTextfield;
@property(nonatomic,strong)UITextField *qyBossTextfield;
@property(nonatomic,strong)UITextField *qyHtmlTextField;

@property(nonatomic,strong)UIView *itemView;
@property(nonatomic,strong)UIButton *addItemBtn;
@property(nonatomic,strong)NSMutableArray *itemsArray;
-(void)backKeybod;
-(void)addItemView;
-(void)updateItemViewWithModel:(QYPointModel *)model isDeleteType:(BOOL)isDelete;
@end
