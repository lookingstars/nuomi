//
//  JZNetworkSingleton.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZNetworkSingleton.h"

@implementation JZNetworkSingleton




+(instancetype)request{
    
    return [[[self class] alloc] init];
//    static JZNetworkSingleton *sharedNetworkSingleton = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate,^{
//        sharedNetworkSingleton = [[self alloc] init];
//    });
//    return sharedNetworkSingleton;
}

- (AFHTTPRequestOperationManager *)manager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [self acceptableContentTypes];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    NSDictionary *headers = [self headerVaules];
    for (NSString *filed in [headers allKeys]) {
        [manager.requestSerializer setValue:headers[filed] forHTTPHeaderField:filed];
    }
    
    return manager;
}

- (NSSet *)acceptableContentTypes
{
    
    return [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html", nil];
}

- (NSDictionary *)headerVaules
{
    return nil;
}

-(void)getDataWithURL:(NSString *)url params:(NSDictionary *)userInfo success:(SuccessBlock)success failure:(FailureBlock)failure{
    AFHTTPRequestOperationManager *manager = [self manager];
    [manager GET:url parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            if (self.classModel) {
                OPDataResponse *response = [[OPDataResponse alloc] initWithResponse:responseObject dataModleClass:[NSClassFromString(self.classModel) class] responseType:OPDataResponseTypeDefault];
                success(response);
            }else{
                OPDataResponse *response = responseObject;
                success(response);
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)postDataWithURL:(NSString *)url params:(NSDictionary *)userInfo success:(SuccessBlock)success failure:(FailureBlock)failure{
    AFHTTPRequestOperationManager *manager = [self manager];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [manager POST:url parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            if (self.classModel) {
                OPDataResponse *response = [[OPDataResponse alloc] initWithResponse:responseObject dataModleClass:[NSClassFromString(self.classModel) class] responseType:OPDataResponseTypeDefault];
                success(response);
            }else{
                OPDataResponse *response = responseObject;
                success(response);
            }
        }
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
