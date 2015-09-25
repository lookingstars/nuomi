//
//  JZHomeJingxuanCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeJingxuanCell.h"

@implementation JZHomeJingxuanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListArray:(NSArray *)listArray {
    _listArray = listArray;
    
    if (listArray.count == 3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:100+i];
            UILabel *shopNameLabel = (UILabel *)[self.contentView viewWithTag:110+i];
            UILabel *newPriceLabel = (UILabel *)[self.contentView viewWithTag:120+i];
            UILabel *oldPriceLabel = (UILabel *)[self.contentView viewWithTag:130+i];
            
            
            shopNameLabel.text = [listArray[i] objectForKey:@"brand"];
            newPriceLabel.text = [NSString stringWithFormat:@"￥%ld",[[listArray[i] objectForKey:@"current_price"] integerValue]/100];
            
            NSString *oldStr = [NSString stringWithFormat:@"%ld",[[listArray[i] objectForKey:@"market_price"] integerValue]/100];
            //中划线
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
            oldPriceLabel.attributedText = attribtStr;
            //
            
            NSString *imgStr = [listArray[i] objectForKey:@"na_logo"];
            NSRange range = [imgStr rangeOfString:@"src="];
            if (range.location != NSNotFound) {
                NSString *subStr = [imgStr substringFromIndex:range.location+range.length];
                subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [imageView sd_setImageWithURL:[NSURL URLWithString:subStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
            }
        }
    }else{
        
    }
    
}

@end
