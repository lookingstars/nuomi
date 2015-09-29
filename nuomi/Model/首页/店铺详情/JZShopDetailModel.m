//
//  JZShopDetailModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopDetailModel.h"

@implementation JZShopDetailModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"deal_id":@"deal_id",
             @"deal_type":@"deal_type",
             @"rush_buy":@"rush_buy",
             @"title_about":@"title_about",
             @"safeguard_info":@"safeguard_info",
             
             @"notice":@"notice",
             @"buy_content":@"buy_content",
             @"consumer_tips":@"consumer_tips",
             @"more_info":@"more_info",
             @"have_store":@"have_store",
             
             @"join_cart":@"join_cart",
             @"merchant_baseinfo":@"merchant_baseinfo",
             @"merchant_phone":@"merchant_phone"
             };
}

+(NSValueTransformer *)title_aboutJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JZShopTitleModel class]];
    
}

+(NSValueTransformer *)rush_buyJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JZShopRushBuyModel class]];
    
}

@end


@implementation JZShopTitleModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"min_image":@"min_image",
             @"image":@"image",
             @"business_title":@"business_title",
             @"subtitle":@"subtitle",
             @"remain_time":@"remain_time",
             
             @"sell_count":@"sell_count",
             @"special_mark":@"special_mark",
             @"tinyurl":@"tinyurl"
             };
}

@end


@implementation JZShopRushBuyModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"market_price":@"market_price",
             @"current_price":@"current_price",
             @"sell_status":@"sell_status",
             @"favour_info":@"favour_info",
             @"top_info":@"top_info"
             };
}

@end


