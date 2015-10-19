//
//  JZMovieItemCell.m
//  nuomi
//
//  Created by jinzelu on 15/10/19.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMovieItemCell.h"

@implementation JZMovieItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setResuleM:(JZMovieResultModel *)resuleM{
    _resuleM = resuleM;
    
    self.shopNameLabel.text = resuleM.name;
    self.shopAddressLabel.text = resuleM.address;
    self.shopDistanceLabel.text = [NSString stringWithFormat:@"%@m",resuleM.distance];
    NSString *tuanStr = @"";
    if (resuleM.isSeatSelectable) {
        tuanStr = [tuanStr stringByAppendingString:@"座"];
    }
    if (resuleM.isGroupon) {
        if (resuleM.isSeatSelectable) {
            tuanStr = [tuanStr stringByAppendingString:@"|"];
        }
        tuanStr = [tuanStr stringByAppendingString:@"团"];
    }
    self.shopTuanLabel.text = tuanStr;
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f起",[resuleM.minPrice floatValue]/100.0];
    self.shopPriceLabel.text = priceStr;
}

@end
