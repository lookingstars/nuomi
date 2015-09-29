//
//  JZShopCommentModel.h
//  nuomi
//
//  Created by jinzelu on 15/9/29.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Mantle/Mantle.h>

@class JZShopDetailCommentModel;

@interface JZShopCommentModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSDictionary *level_num;
@property (nonatomic, strong) NSNumber *average_score;
@property (nonatomic, strong) NSNumber *user_num;
@property (nonatomic, strong) NSNumber *pic_comment_num;
@property (nonatomic, strong) NSArray *expression_label;

@property (nonatomic, strong) NSNumber *average_score_display;
@property (nonatomic, strong) NSArray *label_detail_comment;
@property (nonatomic, strong) NSNumber *comment;

@end


@interface JZShopDetailCommentModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *pic_num;
@property (nonatomic, strong) NSNumber *update_time;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSArray *pic_url;
@property (nonatomic, strong) NSArray *reply;
@property (nonatomic, strong) NSNumber *reply_num;
@property (nonatomic, strong) NSNumber *isuser;

@end