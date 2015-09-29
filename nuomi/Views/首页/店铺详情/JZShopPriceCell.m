//
//  JZShopPriceCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopPriceCell.h"

@implementation JZShopPriceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRushBuyM:(JZShopRushBuyModel *)rushBuyM {
    _rushBuyM = rushBuyM;
    
    NSString *newPrice = [NSString stringWithFormat:@"￥%ld",[rushBuyM.current_price integerValue]/100];
    self.shopNewPriceLabel.text = newPrice;
    
    NSString *oldPrice = [NSString stringWithFormat:@"%ld",[rushBuyM.market_price integerValue]/100];
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldPrice attributes:attribtDic];
    self.shopOldPriceLabel.attributedText = attribtStr;
}

@end
