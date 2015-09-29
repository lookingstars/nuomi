//
//  JZShopRelatedModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@class JZShopSeebuyModel;

@interface JZShopRelatedModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) JZShopSeebuyModel *seebuy;
@property (nonatomic, strong) NSDictionary *hot_recommend;

@end

@interface JZShopSeebuyModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *tuan_s;

@end

@interface JZShopSeeBuyListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *deal_id;
@property (nonatomic, strong) NSNumber *current_price;
@property (nonatomic, strong) NSDictionary *favour_list;
@property (nonatomic, strong) NSNumber *market_price;
@property (nonatomic, strong) NSString *min_title;

@property (nonatomic, strong) NSString *mid_image;
@property (nonatomic, strong) NSDictionary *poi;
@property (nonatomic, strong) NSString *tuan_s;

@end