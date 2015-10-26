//
//  JZNetworkSingleton.h
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "OPDataResponse.h"


//请求超时
#define TIMEOUT 15

typedef void(^SuccessBlock)(OPDataResponse *responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface JZNetworkSingleton : NSObject

@property (nonatomic, strong) NSString *classModel;


+(instancetype)request;

//    url内部添加有签名加密，所以只能把url写死，不能动态的改变url
-(void)getDataWithURL:(NSString *)url params:(NSDictionary *)userInfo success:(SuccessBlock)success failure:(FailureBlock)failure;

-(void)postDataWithURL:(NSString *)url params:(NSDictionary *)userInfo success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
