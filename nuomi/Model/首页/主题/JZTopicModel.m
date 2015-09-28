//
//  JZTopicModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZTopicModel.h"

@implementation JZTopicModel


+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"special_id":@"special_id",
             @"special_title":@"special_title",
             @"min_title":@"min_title",
             @"special_image":@"special_image",
             @"share_display":@"share_display",
             
             @"special_s":@"special_s",
             @"wap_url":@"wap_url",
             @"share_img":@"share_img",
             @"special_list":@"special_list",
             @"tuan_count":@"tuan_count",
             
             @"hasmore":@"hasmore"
             };
}

+(NSValueTransformer *)special_listJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZTopicSpecialModel class]];
}


@end



@implementation JZTopicSpecialModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"deal_id":@"deal_id",
             @"image":@"image",
             @"brand_name":@"brand_name",
             @"short_title":@"short_title",
             @"groupon_price":@"groupon_price",
             
             @"market_price":@"market_price",
             @"appoint":@"appoint",
             @"is_flash":@"is_flash",
             @"ifvirtual":@"ifvirtual",
             @"virtual_redirect_url":@"virtual_redirect_url",
             
             @"newgroupon":@"new_groupon",
             @"s":@"s",
             @"deal_type":@"deal_type",
             @"tinyurl":@"tinyurl",
             @"distance":@"distance",
             
             @"sale_count":@"sale_count",
             @"other_desc":@"other_desc",
             @"favour_list":@"favour_list",
             @"card_type":@"card_type",
             @"schema_url":@"schema_url"
             };
}

@end