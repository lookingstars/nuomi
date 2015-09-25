//
//  OPDataResponse.h
//  OPNetAdapter
//
//  Created by sunguanglei on 15/5/19.
//  Copyright (c) 2015年 sunix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    OPDataResponseTypeDefault,
    OPDataResponseTypeList,
    OPDataResponseTypePage,
} OPDataResponseType;

@interface OPDataResponse : NSObject

@property (nonatomic, assign) NSInteger code;//errno
@property (nonatomic, copy)   NSString  *msg;
@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSNumber *timestamp;
@property (nonatomic, strong) NSNumber *cached;
@property (nonatomic, strong) NSNumber *serverstatus;
@property (nonatomic, strong) NSString *errmsg;
@property (nonatomic, strong) NSNumber *serverlogid;





@property (nonatomic, strong) NSError   *error;
@property (nonatomic, strong) NSDictionary *extraData;

- (instancetype)initWithResponse:(id)response;
- (instancetype)initWithResponse:(id)response
                  dataModleClass:(Class)dataModelClass
                    responseType:(OPDataResponseType)responseType;

@end
