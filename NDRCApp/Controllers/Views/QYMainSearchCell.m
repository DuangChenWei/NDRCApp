//
//  QYMainSearchCell.m
//  NDRCApp
//
//  Created by vp on 2017/5/19.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "QYMainSearchCell.h"

@implementation QYMainSearchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(widthOn(34), 0, k_ScreenWidth-widthOn(34)*2, widthOn(100))];
        self.nameLabel.numberOfLines=2;
        self.nameLabel.textColor=appDarkLabelColor;
        self.nameLabel.font=[UIFont systemFontOfSize:widthOn(30)];
        [self.contentView addSubview:self.nameLabel];
        
        
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame),CGRectGetHeight(self.nameLabel.frame)-1, CGRectGetWidth(self.nameLabel.frame), 1)];
        lineView.backgroundColor=appLineColor;
        [self.contentView addSubview:lineView];
        
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
