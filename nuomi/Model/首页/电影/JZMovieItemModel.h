//
//  JZMovieItemModel.h
//  nuomi
//
//  Created by jinzelu on 15/10/19.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZMovieItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSDictionary *filter;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSNumber *totalNum;

@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, strong) NSDictionary *adBar;

@end


@interface JZMovieResultModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *minPrice;
@property (nonatomic, assign) BOOL isGroupon;

@property (nonatomic, assign) BOOL isSeatSelectable;

@end