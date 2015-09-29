//
//  JZShopCommentModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopCommentModel.h"

@implementation JZShopCommentModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"level_num":@"level_num",
             @"average_score":@"average_score",
             @"user_num":@"user_num",
             @"pic_comment_num":@"pic_comment_num",
             @"expression_label":@"expression_label",
             
             @"average_score_display":@"average_score_display",
             @"label_detail_comment":@"label_detail_comment",
             @"comment":@"comment"
             };
}

@end
