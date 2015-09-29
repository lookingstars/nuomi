//
//  JZShopSeeBuyCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZShopRelatedModel.h"

@interface JZShopSeeBuyCell : UITableViewCell

@property (nonatomic, strong) JZShopSeeBuyListModel *listM;

@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNewPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;



@end
