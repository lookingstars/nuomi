//
//  JZNearItemCell.h
//  nuomi
//
//  Created by jinzelu on 15/10/12.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZNearItemModel.h"

@interface JZNearItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopNewPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopOldPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopActivityLabel;


@property (nonatomic, strong) JZNearTuanListModel *tuanListM;

@end
