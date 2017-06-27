//
//  QuestionListCell.m
//  NDRCApp
//
//  Created by vp on 2017/5/20.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionListCell.h"

@implementation QuestionListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.qyNameLabel=[[UILabel alloc] init];
        self.qyNameLabel.textColor=ColorWithAlpha(0x666666, 1);
        self.qyNameLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        [self.contentView addSubview:self.qyNameLabel];
        
        self.questionTypeLabel=[[UILabel alloc] init];
        self.questionTypeLabel.textAlignment=NSTextAlignmentRight;
        self.questionTypeLabel.font=self.qyNameLabel.font;
        self.questionTypeLabel.textColor=[UIColor redColor];
        [self.contentView addSubview:self.questionTypeLabel];
        
        self.qyContactLabel=[[UILabel alloc] init];
        self.qyContactLabel.font=[UIFont systemFontOfSize:widthOn(28)];
        self.qyContactLabel.textColor=self.qyNameLabel.textColor;
//        [self.contentView addSubview:self.qyContactLabel];
        
        
        self.timeLabel=[[UILabel alloc] init];
        self.timeLabel.textColor=ColorWithAlpha(0x999999, 1);
        self.timeLabel.font=self.qyContactLabel.font;
        self.timeLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        
        UIView *lineView=[[UIView alloc] init];
        lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:lineView];
        
        self.qyNameLabel.sd_layout.leftSpaceToView(self.contentView, widthOn(34)).topSpaceToView(self.contentView, widthOn(10)).widthIs(widthOn(550)).heightIs(widthOn(80));
        self.questionTypeLabel.sd_layout.rightSpaceToView(self.contentView, widthOn(34)).topEqualToView(self.qyNameLabel).heightRatioToView(self.qyNameLabel, 1).leftSpaceToView(self.qyNameLabel, 10);
//        self.qyContactLabel.sd_layout.leftEqualToView(self.qyNameLabel).bottomSpaceToView(self.contentView, widthOn(10)).widthIs(widthOn(300)).heightRatioToView(self.qyNameLabel, 1);
        self.timeLabel.sd_layout.leftEqualToView(self.qyNameLabel).bottomSpaceToView(self.contentView, widthOn(10)).widthIs(widthOn(450)).heightRatioToView(self.qyNameLabel, 1);
        
        lineView.sd_layout.leftEqualToView(self.qyNameLabel).rightEqualToView(self.questionTypeLabel).bottomSpaceToView(self.contentView,1).heightIs(1);
        
        
        
        
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
