//
//  JZMovieCardModel.h
//  nuomi
//
//  Created by jinzelu on 15/10/20.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZMovieCardModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSDictionary *adBar;

@end


@interface JZMovieCardResultModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *posterUrl;
@property (nonatomic, strong) NSNumber *score;

@end