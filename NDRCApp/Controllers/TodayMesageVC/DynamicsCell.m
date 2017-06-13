//
//  DynamicsCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/7.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "DynamicsCell.h"

@implementation DynamicsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel=[[UILabel alloc] init];
        self.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel=[[UILabel alloc] init];
        self.contentLabel.font=[UIFont systemFontOfSize:widthOn(40)];
        self.contentLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.contentLabel];
        
        self.danweiLabel=[[UILabel alloc] init];
        self.danweiLabel.font=[UIFont systemFontOfSize:widthOn(32)];
        self.danweiLabel.text=@"个";
        [self.contentView addSubview:self.danweiLabel];
        
        UIView *lineView=[[UIView alloc] init];
        lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:lineView];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, widthOn(50)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, widthOn(50)).heightRatioToView(self.contentView, 0.5);
        self.contentLabel.sd_layout.centerXEqualToView(self.contentView).widthIs(widthOn(200)).topSpaceToView(self.titleLabel, 0).heightIs(widthOn(60));
        self.danweiLabel.sd_layout.leftSpaceToView(self.contentLabel, 0).bottomEqualToView(self.contentLabel).heightRatioToView(self.contentLabel, 1).widthIs(widthOn(50));
        lineView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(1);
        
        
        
        
        
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
