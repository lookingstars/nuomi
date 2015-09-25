//
//  JZHomeShopCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeShopCell.h"
#import "UIImageView+WebCache.h"

@implementation JZHomeShopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopM:(JZShopTuanModel *)shopM {
    _shopM = shopM;
    NSRange range = [shopM.image rangeOfString:@"src="];
    if (range.location != NSNotFound) {
        NSString *subStr = [shopM.image substringFromIndex:range.location+range.length];
        subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:subStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    }
//    NSString *str = [shopM.image stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopM.image] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    
    self.shopNameLabel.text = shopM.brand_name;
    self.shopDesLabel.text = shopM.short_title;
    self.distanceLabel.text = shopM.distance;
    self.newpriceLabel.text = [NSString stringWithFormat:@"￥%ld",[shopM.groupon_price integerValue]/100];
    self.scoreLabel.text = shopM.score_desc;

    NSString *oldStr = [NSString stringWithFormat:@"%ld",[shopM.market_price integerValue]/100];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    self.oldPriceLabel.attributedText = attribtStr;
    
    
}

@end
