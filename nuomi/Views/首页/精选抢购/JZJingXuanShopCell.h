//
//  JZJingXuanShopCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZJingXuanModel.h"

@interface JZJingXuanShopCell : UITableViewCell


@property (nonatomic, strong) JZJingXuanListModel *listM;


@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;

@property (weak, nonatomic) IBOutlet UILabel *shopNamaLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDesLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopNewPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopScoreLabel;

@end
