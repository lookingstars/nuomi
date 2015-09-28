//
//  JZTopicListCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZTopicModel.h"

@interface JZTopicListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopSubtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNewPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopOldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopSaleLabel;


@property (nonatomic, strong) JZTopicSpecialModel *specialM;

@end
