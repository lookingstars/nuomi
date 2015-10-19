//
//  JZMovieItemModel.m
//  nuomi
//
//  Created by jinzelu on 15/10/19.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMovieItemModel.h"

@implementation JZMovieItemModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"filter":@"filter",
             @"cityId":@"cityId",
             @"cityName":@"cityName",
             @"result":@"result",
             @"totalNum":@"totalNum",
             
             @"pageSize":@"pageSize",
             @"pageNum":@"pageNum",
             @"adBar":@"adBar"
             };
}

+(NSValueTransformer *)resultJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZMovieResultModel class]];
}

@end

@implementation JZMovieResultModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"name":@"name",
             @"address":@"address",
             @"distance":@"distance",
             @"minPrice":@"minPrice",
             @"isGroupon":@"isGroupon",
             
             @"isSeatSelectable":@"isSeatSelectable"
             };
}

+(NSValueTransformer *)isGrouponJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+(NSValueTransformer *)isSeatSelectableJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

@end