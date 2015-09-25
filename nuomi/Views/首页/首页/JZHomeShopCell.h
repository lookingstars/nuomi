//
//  JZHomeShopCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZHomeShopModel.h"

@interface JZHomeShopCell : UITableViewCell

@property (nonatomic, strong) JZShopTuanModel *shopM;

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *newpriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;


@end
