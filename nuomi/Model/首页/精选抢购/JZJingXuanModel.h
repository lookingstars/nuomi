//
//  JZJingXuanModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZJingXuanModel : MTLModel<MTLJSONSerializing>


@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSArray *period;
@property (nonatomic, strong) NSArray *prepare_period;
@property (nonatomic, strong) NSArray *list;

@end

@interface JZJingXuanListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSNumber *current_price;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *medium_title;

@property (nonatomic, strong) NSString *distance;
//@property (nonatomic, strong) NSString *ugc_score;
@property (nonatomic, strong) NSNumber *store_num;

@end