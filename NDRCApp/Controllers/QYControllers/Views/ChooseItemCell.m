//
//  ChooseItemCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "ChooseItemCell.h"

@implementation ChooseItemCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.titleLabel=[[UILabel alloc] init];
        self.titleLabel.font=[UIFont systemFontOfSize:widthOn(32)];
        self.titleLabel.numberOfLines=2;
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textColor=ColorWithAlpha(0x999999, 1);
        self.titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, widthOn(34), 0, widthOn(34)));
        
        UIView *lineView=[[UIView alloc] init];
        lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:lineView];
        lineView.sd_layout.leftEqualToView(self.titleLabel).widthRatioToView(self.titleLabel, 1).bottomSpaceToView(self.contentView, 1).heightIs(1);
        
        
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
