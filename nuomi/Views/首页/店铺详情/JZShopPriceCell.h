//
//  JZShopPriceCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZShopDetailModel.h"

@interface JZShopPriceCell : UITableViewCell

@property (nonatomic, strong) JZShopRushBuyModel *rushBuyM;

@property (weak, nonatomic) IBOutlet UILabel *shopNewPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopOldPriceLabel;

@end
