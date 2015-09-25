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
//    NSString *str = [shopM.image stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopM.image] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    NSString *str = @"http://popmobtest.staff.xdf.cn/pop_resource/learno2o/qrCode/36af4769-5aee-4822-a3ae-87d1daaca16e.jpg";
//    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
    NSLog(@"image:  %@",shopM.image);
    self.shopNameLabel.text = shopM.brand_name;
    self.shopDesLabel.text = shopM.short_title;
    self.distanceLabel.text = shopM.distance;
//    self.newpriceLabel.text = shopM
//    self.oldPriceLabel.text
    self.scoreLabel.text = shopM.score_desc;
    
    
    
}

@end
