//
//  QuestionTJThirdCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/12.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionTJThirdCell.h"

@implementation QuestionTJThirdCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
        
        self.titleLabel=[[UILabel alloc] init];
        self.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.contentLabel=[[UILabel alloc] init];
        self.contentLabel.font=[UIFont systemFontOfSize:widthOn(36)];

        [self.contentView addSubview:self.contentLabel];
        
        
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, widthOn(34)).centerYEqualToView(self.contentView).widthIs(widthOn(100)).heightRatioToView(self.contentView, 1);
        
        self.contentLabel.sd_layout.leftSpaceToView(self.titleLabel, widthOn(20)).topEqualToView(self.titleLabel).bottomEqualToView(self.titleLabel).rightSpaceToView(self.contentView, widthOn(34));
        
        
        
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
