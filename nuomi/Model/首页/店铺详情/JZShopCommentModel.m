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

+(NSValueTransformer *)label_detail_commentJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZShopDetailCommentModel class]];
}

@end

@implementation JZShopDetailCommentModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"nickname":@"nickname",
             @"score":@"score",
             @"pic_num":@"pic_num",
             @"update_time":@"update_time",
             @"content":@"content",
             
             @"pic_url":@"pic_url",
             @"reply":@"reply",
             @"reply_num":@"reply_num",
             @"isuser":@"isuser"
             };
}

@end