//
//  QuestionTJFirstCell.m
//  NDRCApp
//
//  Created by vp on 2017/6/9.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QuestionTJFirstCell.h"

@implementation QuestionTJFirstCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.stateIcon=[[UIImageView alloc] init];
        self.stateIcon.backgroundColor=[UIColor yellowColor];
        [self.contentView addSubview:self.stateIcon];
        
        self.titleLabel=[[UILabel alloc] init];
        self.titleLabel.font=[UIFont systemFontOfSize:widthOn(34)];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.contentLabel=[[UILabel alloc] init];
        self.contentLabel.font=[UIFont systemFontOfSize:widthOn(36)];
        self.contentLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:self.contentLabel];
        
        self.rightIcon=[[UIImageView alloc] init];
        self.rightIcon.image=[UIImage imageNamed:@""];
        [self.contentView addSubview:self.rightIcon];
        
        self.stateIcon.sd_layout.leftSpaceToView(self.contentView, widthOn(34)).centerYEqualToView(self.contentView).widthIs(widthOn(30)).heightEqualToWidth();
        self.stateIcon.sd_cornerRadius=[NSNumber numberWithFloat:widthOn(15)];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.stateIcon, widthOn(34)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(widthOn(300));
        
        self.rightIcon.sd_layout.rightSpaceToView(self.contentView, widthOn(34)).centerYEqualToView(self.titleLabel).widthIs(30).heightIs(40);
        self.contentLabel.sd_layout.rightSpaceToView(self.rightIcon, widthOn(20)).topEqualToView(self.titleLabel).bottomEqualToView(self.titleLabel).widthIs(widthOn(200));
        
        
        
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
