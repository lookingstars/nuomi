//
//  JZShopDetailModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@class JZShopTitleModel;
@class JZShopRushBuyModel;

@interface JZShopDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *deal_id;
@property (nonatomic, strong) NSNumber *deal_type;
@property (nonatomic, strong) JZShopRushBuyModel *rush_buy;
@property (nonatomic, strong) JZShopTitleModel *title_about;
@property (nonatomic, strong) NSArray *safeguard_info;

@property (nonatomic, strong) NSDictionary *notice;
@property (nonatomic, strong) NSDictionary *buy_content;
@property (nonatomic, strong) NSDictionary *consumer_tips;
@property (nonatomic, strong) NSString *more_info;
@property (nonatomic, strong) NSNumber *have_store;

@property (nonatomic, strong) NSNumber *join_cart;
@property (nonatomic, strong) NSDictionary *merchant_baseinfo;
@property (nonatomic, strong) NSString *merchant_phone;


@end


@interface JZShopTitleModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *min_image;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSString *business_title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSNumber *remain_time;

@property (nonatomic, strong) NSNumber *sell_count;
@property (nonatomic, strong) NSNumber *special_mark;
@property (nonatomic, strong) NSString *tinyurl;

@end

@interface JZShopRushBuyModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *market_price;
@property (nonatomic, strong) NSNumber *current_price;
@property (nonatomic, strong) NSNumber *sell_status;
@property (nonatomic, strong) NSDictionary *favour_info;
@property (nonatomic, strong) NSDictionary *top_info;

@end