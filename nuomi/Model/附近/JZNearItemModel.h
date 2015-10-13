//
//  JZNearItemModel.h
//  nuomi
//
//  Created by jinzelu on 15/10/12.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZNearItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *poi_list;

@end

@interface JZPoiListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *poi_name;
@property (nonatomic, strong) NSString *poi_id;
@property (nonatomic, strong) NSString *poi_distance;
@property (nonatomic, strong) NSString *bizarea_title;
@property (nonatomic, strong) NSArray *tuan_list;

@property (nonatomic, strong) NSDictionary *ugc;
@property (nonatomic, strong) NSArray *special_label;
@property (nonatomic, strong) NSString *poi_image;

@end
