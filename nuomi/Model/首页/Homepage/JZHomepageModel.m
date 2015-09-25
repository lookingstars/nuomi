//
//  JZHomepageModel.m
//  nuomi
//
//  Created by jinzelu on 15/9/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomepageModel.h"

@implementation JZHomepageModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"banners":@"banners",
             @"category":@"category",
             @"special":@"special",
             @"recommend":@"recommend",
             @"topten":@"topten"
             };
}

+(NSValueTransformer *)bannersJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZHomebannersModel class]];
}

+(NSValueTransformer *)categoryJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[JZHomecategoryModel class]];
}

+(NSValueTransformer *)specialJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JZHomespecialModel class]];
}

+ (NSValueTransformer *)toptenJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[JZHometoptenModel class]]; 
}

@end



//1
@implementation JZHomebannersModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"banner_id":@"banner_id",
             @"picture_url":@"picture_url",
             @"goto_type":@"goto_type",
             @"cont":@"cont"
             };
}

@end


//2
@implementation JZHomecategoryModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"category_id":@"category_id",
             @"category_name":@"category_name",
             @"category_picurl":@"category_picurl",
             @"icon_url":@"icon_url",
             @"has_icon":@"has_icon",
             
             @"schema":@"schema"
             };
}

@end

//3
@implementation JZHomespecialModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"block_1":@"block_1",
             @"block_2":@"block_2",
             @"block_3":@"block_3"
             };
}

@end


//4
@implementation JZHometoptenModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"activetime":@"activetime",
             @"list":@"list",
             @"isLogo":@"isLogo",
             @"target_url":@"target_url"
             };
}

@end

















