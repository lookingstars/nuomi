//
//  JZShopNoticeCell.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZShopNoticeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;



+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(NSString *)notice;

@end
