//
//  JZMovieItemCell.h
//  nuomi
//
//  Created by jinzelu on 15/10/19.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMovieItemModel.h"

@interface JZMovieItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopTuanLabel;


@property (nonatomic, strong) JZMovieResultModel *resuleM;

@end
