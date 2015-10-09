//
//  JZHomeJingxuanCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZHomeJingxuanCell : UITableViewCell

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) NSArray *activeTimeArray;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;


@end
