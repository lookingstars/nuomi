//
//  JZJingXuanModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZJingXuanModel.h"

@implementation JZJingXuanModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"total":@"total",
             @"period":@"period",
             @"prepare_period":@"prepare_period",
             @"list":@"list"
             };
}

+(NSValueTransformer *)listJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZJingXuanListModel class]];
    
}

@end



@implementation JZJingXuanListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"brand":@"brand",
             @"current_price":@"current_price",
             @"deal_id":@"deal_id",
             @"image":@"image",
             @"medium_title":@"medium_title",
             
             @"distance":@"distance",
//             @"ugc_score":@"ugc_score",
             @"store_num":@"store_num"
             };
}

@end