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

@end
