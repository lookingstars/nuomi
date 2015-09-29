//
//  NSString+convertImgStr.h
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (convertImgStr)

//$$$转imgurl
+(NSString *)convertImgStr:(NSString *)imgStr;

+(NSString *)getSpecialId:(NSString *)special;

+(NSString *)getWebUrl:(NSString *)cont;

+(NSString *)getComponentUrl:(NSString *)cont;

@end
