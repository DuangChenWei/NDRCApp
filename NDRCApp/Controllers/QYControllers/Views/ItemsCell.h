//
//  ItemsCell.h
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsCell : UITableViewCell
@property(nonatomic,strong)UILabel *itemNameLabel;
@property(nonatomic,strong)UILabel *personNameLabel;
@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UIImageView *addImageView;
@property(nonatomic,strong)UIView *lineView;
@end
