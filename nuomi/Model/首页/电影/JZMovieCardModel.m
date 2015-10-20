//
//  JZMovieCardModel.m
//  nuomi
//
//  Created by jinzelu on 15/10/20.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMovieCardModel.h"

@implementation JZMovieCardModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"result":@"result",
             @"adBar":@"adBar"
             };
}

+(NSValueTransformer *)resultJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZMovieCardResultModel class]];
}

@end



@implementation JZMovieCardResultModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"movieId":@"movieId",
             @"name":@"name",
             @"posterUrl":@"posterUrl",
             @"score":@"score"
             };
}

@end