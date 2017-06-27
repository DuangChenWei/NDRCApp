//
//  ItemsCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/16.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ItemsCell.h"

@implementation ItemsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.itemNameLabel=[[UILabel alloc] init];
        self.itemNameLabel.font=[UIFont systemFontOfSize:widthOn(32)];
        self.itemNameLabel.numberOfLines=2;
        [self.contentView addSubview:self.itemNameLabel];
        self.itemNameLabel.textColor=[UIColor blackColor];
        self.itemNameLabel.sd_layout.leftSpaceToView(self.contentView, widthOn(34)).rightSpaceToView(self.contentView, widthOn(34)).topSpaceToView(self.contentView, 0).heightRatioToView(self.contentView, 0.5);
        
        self.personNameLabel=[[UILabel alloc] init];
        self.personNameLabel.font=[UIFont systemFontOfSize:widthOn(28)];
        self.personNameLabel.textColor=ColorWithAlpha(0x999999, 1);
        [self.contentView addSubview:self.personNameLabel];
        self.personNameLabel.sd_layout.leftEqualToView(self.itemNameLabel).topSpaceToView(self.itemNameLabel, 0).bottomSpaceToView(self.contentView, 1).widthIs(widthOn(300));
        
        self.timeLabel=[[UILabel alloc] init];
        self.timeLabel.textColor=self.personNameLabel.textColor;
        self.timeLabel.font=self.personNameLabel.font;
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.sd_layout.leftSpaceToView(self.personNameLabel, 0).rightSpaceToView(self.contentView, 0).topEqualToView(self.personNameLabel).bottomEqualToView(self.personNameLabel);
        
        self.lineView=[[UIView alloc] init];
        self.lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:self.lineView];
        self.lineView.sd_layout.leftEqualToView(self.itemNameLabel).widthRatioToView(self.itemNameLabel, 1).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
        
        self.addImageView=[[UIImageView alloc] init];
        self.addImageView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.addImageView];
        self.addImageView.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView(self.contentView).widthIs(widthOn(100)).heightIs(widthOn(100));
        self.addImageView.hidden=YES;
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
