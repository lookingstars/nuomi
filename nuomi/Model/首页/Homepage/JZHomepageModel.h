//
//  JZHomepageModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>


//1
@interface JZHomebannersModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *banner_id;
@property (nonatomic, strong) NSString *picture_url;
@property (nonatomic, strong) NSNumber *goto_type;
@property (nonatomic, strong) NSString *cont;

@end

//2
@interface JZHomecategoryModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *category_name;
@property (nonatomic, strong) NSString *category_picurl;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, strong) NSNumber *has_icon;

@property (nonatomic, strong) NSString *schema;

@end

//3
@interface JZHomespecialModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSDictionary *block_1;
@property (nonatomic, strong) NSArray *block_2;
@property (nonatomic, strong) NSArray *block_3;

@end

//4
@interface JZHometoptenModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *activetime;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSNumber *isLogo;
@property (nonatomic, strong) NSString *target_url;

@end

@interface JZHomepageModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *category;
@property (nonatomic, strong) JZHomespecialModel *special;
@property (nonatomic, strong) NSArray *recommend;
@property (nonatomic, strong) JZHometoptenModel *topten;

@end







