//
//  JZShopSeeBuyCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopSeeBuyCell.h"

@implementation JZShopSeeBuyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListM:(JZShopSeeBuyListModel *)listM{
    _listM = listM;
    
    self.shopNameLabel.text = listM.min_title;
    self.shopDistanceLabel.text = [listM.poi objectForKey:@"distance"];
    
    self.shopNewPriceLabel.text = [NSString stringWithFormat:@"￥%ld",[listM.current_price integerValue]/100];
    
    NSString *imgStr = listM.mid_image;
    imgStr = [NSString convertImgStr:imgStr];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
}

@end
