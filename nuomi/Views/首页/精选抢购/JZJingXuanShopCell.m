//
//  JZJingXuanShopCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZJingXuanShopCell.h"

@implementation JZJingXuanShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListM:(JZJingXuanListModel *)listM{
    _listM = listM;
    
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:listM.image] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    self.shopNamaLabel.text = listM.brand;
    self.shopDesLabel.text = listM.medium_title;
    self.shopDistanceLabel.text = listM.distance;
//    self.shopScoreLabel.text = [NSString stringWithFormat:@"%@分 售%@份",listM.ugc_score,listM.store_num];
    self.shopNewPriceLabel.text = [NSString stringWithFormat:@"￥%ld",[listM.current_price integerValue]/100];
}

@end
