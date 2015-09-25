//
//  JZHomeNewCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeNewCell.h"
#import "UIImageView+WebCache.h"

@implementation JZHomeNewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setHomeNewDataDic:(NSDictionary *)homeNewDataDic{
    _homeNewDataDic = homeNewDataDic;
    self.titleLabel.text = [homeNewDataDic objectForKey:@"adv_title"];
    self.subtitleLabel.text = [homeNewDataDic objectForKey:@"adv_subtitle"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[homeNewDataDic objectForKey:@"picture_url"]] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
}

@end
