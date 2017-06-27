//
//  QYItemQuestionCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/26.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYItemQuestionCell.h"

@implementation QYItemQuestionCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.qyNameLabel=[[UILabel alloc] init];
        self.qyNameLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        [self.contentView addSubview:self.qyNameLabel];
        
        self.qyContactLabel=[[UILabel alloc] init];
        self.qyContactLabel.font=[UIFont systemFontOfSize:widthOn(30)];
        self.qyContactLabel.textColor=ColorWithAlpha(0x999999, 0.5);
        [self.contentView addSubview:self.qyContactLabel];
        
        self.qyTimeLabel=[[UILabel alloc] init];
        self.qyTimeLabel.textColor=self.qyContactLabel.textColor;
        self.qyTimeLabel.font=self.qyContactLabel.font;
        [self.contentView addSubview:self.qyTimeLabel];
        
        self.qyQuestionNumberLabel=[[UILabel alloc] init];
        self.qyQuestionNumberLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        self.qyQuestionNumberLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.qyQuestionNumberLabel];
        
        UIView *lineView=[[UIView alloc] init];
        lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:lineView];
        
        lineView.sd_layout.leftSpaceToView(self.contentView, widthOn(34)).rightSpaceToView(self.contentView, widthOn(34)).bottomSpaceToView(self.contentView, 0).heightIs(1);
        
        self.qyNameLabel.sd_layout.leftEqualToView(lineView).topSpaceToView(self.contentView, 0).rightEqualToView(lineView).heightRatioToView(self.contentView, 0.6);
        self.qyContactLabel.sd_layout.leftEqualToView(lineView).topSpaceToView(self.qyNameLabel, 0).bottomSpaceToView(lineView, 0).widthIs(widthOn(200));
        self.qyTimeLabel.sd_layout.leftSpaceToView(self.qyContactLabel, 5).topEqualToView(self.qyContactLabel).bottomEqualToView(self.qyContactLabel).widthIs(400);
        self.qyQuestionNumberLabel.sd_layout.leftSpaceToView(self.qyTimeLabel, 0).bottomEqualToView(self.qyTimeLabel).rightEqualToView(lineView).heightRatioToView(self.qyTimeLabel, 1.2);
        
        
        
        
        
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
