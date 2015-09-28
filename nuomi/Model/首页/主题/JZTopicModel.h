//
//  JZTopicModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZTopicModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *special_id;
@property (nonatomic, strong) NSString *special_title;
@property (nonatomic, strong) NSString *min_title;
@property (nonatomic, strong) NSString *special_image;
@property (nonatomic, strong) NSNumber *share_display;

@property (nonatomic, strong) NSString *special_s;
@property (nonatomic, strong) NSString *wap_url;
@property (nonatomic, strong) NSString *share_img;
@property (nonatomic, strong) NSArray *special_list;
@property (nonatomic, strong) NSNumber *tuan_count;

@property (nonatomic, strong) NSNumber *hasmore;

@end

//
@interface JZTopicSpecialModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *brand_name;
@property (nonatomic, strong) NSString *short_title;
@property (nonatomic, strong) NSString *groupon_price;

@property (nonatomic, strong) NSString *market_price;
@property (nonatomic, strong) NSNumber *appoint;
@property (nonatomic, strong) NSNumber *is_flash;
@property (nonatomic, strong) NSNumber *ifvirtual;
@property (nonatomic, strong) NSString *virtual_redirect_url;

@property (nonatomic, strong) NSNumber *newgroupon;/**< new_groupon */
@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *deal_type;
@property (nonatomic, strong) NSString *tinyurl;
@property (nonatomic, strong) NSString *distance;

@property (nonatomic, strong) NSNumber *sale_count;
@property (nonatomic, strong) NSString *other_desc;
@property (nonatomic, strong) NSDictionary *favour_list;
@property (nonatomic, strong) NSNumber *card_type;
@property (nonatomic, strong) NSString *schema_url;

@end
