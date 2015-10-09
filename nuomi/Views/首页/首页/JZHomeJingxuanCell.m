//
//  JZHomeJingxuanCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeJingxuanCell.h"

@interface JZHomeJingxuanCell ()
{
    NSTimeInterval _startTime;
    NSTimeInterval _nowTime;
}

@end

@implementation JZHomeJingxuanCell

- (void)awakeFromNib {
    // Initialization code
    self.hourLabel.layer.masksToBounds = YES;
    self.minLabel.layer.masksToBounds = YES;
    self.secLabel.layer.masksToBounds = YES;
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

-(void)setActiveTimeArray:(NSArray *)activeTimeArray{
    _activeTimeArray = activeTimeArray;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    _nowTime=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", _nowTime];
    NSLog(@"=== %@",timeString);
    for (int i = 0; i < activeTimeArray.count; i++) {
        NSInteger endtime = [[activeTimeArray[i] objectForKey:@"starttime"] integerValue];
        if (_nowTime < endtime) {
            _startTime = endtime;
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
            break;
        }
    }
    
}

-(void)updateUI{
    [self performSelectorOnMainThread:@selector(setTimeLabel) withObject:nil waitUntilDone:NO];
//    [self setTimeLabel];
}

-(void)setTimeLabel{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    _nowTime=[dat timeIntervalSince1970];
    if (_startTime <= _nowTime) {
        return;
    }
    NSInteger subTime = _startTime - _nowTime;
    NSInteger hour = subTime/3600;
    NSInteger min = (subTime%3600)/60;
    NSInteger sec = (subTime%3600)%60;    
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld",hour];
    self.minLabel.text = [NSString stringWithFormat:@"%02ld",min];
    self.secLabel.text = [NSString stringWithFormat:@"%02ld",sec];

}




@end
