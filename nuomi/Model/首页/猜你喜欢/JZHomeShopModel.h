//
//  JZHomeShopModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZHomeShopModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSMutableArray *tuan_list;
@property (nonatomic, strong) NSNumber *tuan_num;

@end


@interface JZShopTuanModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *deal_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *brand_name;
@property (nonatomic, strong) NSString *short_title;
@property (nonatomic, strong) NSNumber *sale_count;

@property (nonatomic, strong) NSNumber *groupon_price;
@property (nonatomic, strong) NSNumber *market_price;
@property (nonatomic, strong) NSNumber *pay_start_time;
@property (nonatomic, strong) NSNumber *pay_end_time;
@property (nonatomic, strong) NSNumber *newgroupon;//new_groupon

@property (nonatomic, strong) NSNumber *sale_out;
@property (nonatomic, strong) NSNumber *groupon_type;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *comment_num;
@property (nonatomic, strong) NSNumber *bought_weekly;

@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSNumber *is_latest;
@property (nonatomic, strong) NSString *other_desc;
@property (nonatomic, strong) NSString *score_desc;
@property (nonatomic, strong) NSNumber *appoint;

@property (nonatomic, strong) NSNumber *is_flash;
@property (nonatomic, strong) NSNumber *is_t10;
@property (nonatomic, strong) NSNumber *is_card;
@property (nonatomic, strong) NSMutableDictionary *favour_list;
@property (nonatomic, strong) NSString *distance;

@property (nonatomic, strong) NSNumber *user_distance_status;
@property (nonatomic, strong) NSNumber *user_distance_poi;
@property (nonatomic, strong) NSNumber *user_distance;
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSNumber *ifvirtual;

@property (nonatomic, strong) NSString *virtual_redirect_url;

@end