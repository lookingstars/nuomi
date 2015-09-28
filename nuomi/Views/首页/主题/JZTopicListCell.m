//
//  JZTopicListCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZTopicListCell.h"

@implementation JZTopicListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSpecialM:(JZTopicSpecialModel *)specialM {
    _specialM = specialM;
    
    self.shopTitleLabel.text = specialM.brand_name;
    self.shopSubtitleLabel.text = specialM.short_title;
    self.shopSaleLabel.text = specialM.other_desc;
    
    NSString *imgStr = [NSString convertImgStr:specialM.image];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    NSInteger newPrice = [specialM.groupon_price integerValue]/100;
    self.shopNewPriceLabel.text = [NSString stringWithFormat:@"￥%ld",newPrice];
    
    NSInteger oldPrice = [specialM.market_price integerValue]/100;
    
    NSString *oldStr = [NSString stringWithFormat:@"%ld",oldPrice];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    self.shopOldPriceLabel.attributedText = attribtStr;
}

@end
