//
//  JZShopCommentCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZShopCommentModel.h"


@interface JZShopCommentCell : UITableViewCell

@property (nonatomic, strong) JZShopDetailCommentModel *commentM;


@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(JZShopDetailCommentModel *)commentM;

@end
