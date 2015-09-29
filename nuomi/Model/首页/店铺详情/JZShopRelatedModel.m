//
//  JZShopRelatedModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopRelatedModel.h"

@implementation JZShopRelatedModel
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"seebuy":@"seebuy",
             @"hot_recommend":@"hot_recommend"
             };
}

+(NSValueTransformer *)seebuyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JZShopSeebuyModel class]];
}

@end

@implementation JZShopSeebuyModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"list":@"list",
             @"total":@"total",
             @"number":@"number",
             @"tuan_s":@"tuan_s"
             };
}

+(NSValueTransformer *)listJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZShopSeeBuyListModel class]];
}

@end


@implementation JZShopSeeBuyListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"deal_id":@"deal_id",
             @"current_price":@"current_price",
             @"favour_list":@"favour_list",
             @"market_price":@"market_price",
             @"min_title":@"min_title",
             
             @"mid_image":@"mid_image",
             @"poi":@"poi",
             @"tuan_s":@"tuan_s"
             };
}

@end
