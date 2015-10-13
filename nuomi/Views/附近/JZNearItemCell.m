//
//  JZNearItemCell.m
//  nuomi
//
//  Created by jinzelu on 15/10/12.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZNearItemCell.h"
#import "NSString+convertImgStr.h"

@implementation JZNearItemCell

- (void)awakeFromNib {
    // Initialization code
    self.shopActivityLabel.layer.borderColor = navigationBarColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTuanListM:(JZNearTuanListModel *)tuanListM{
    _tuanListM = tuanListM;
    
    NSString *imgUrl = [NSString convertImgStr:tuanListM.image];
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    self.shopTitleLabel.text = tuanListM.short_title;
    self.shopDesLabel.text = tuanListM.other_desc;
    
    //价格，标签
}

@end
