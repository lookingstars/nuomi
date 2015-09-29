//
//  NSString+convertImgStr.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NSString+convertImgStr.h"

@implementation NSString (convertImgStr)

+(NSString *)convertImgStr:(NSString *)imgStr{
    NSRange range = [imgStr rangeOfString:@"src="];
    if (range.location != NSNotFound) {
        NSString *subStr = [imgStr substringFromIndex:range.location+range.length];
        subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return subStr;
    }else{
        return @"ugc_photo";
    }
}

+(NSString *)getSpecialId:(NSString *)special{
    NSRange range = [special rangeOfString:@"specialid="];
    if (range.location != NSNotFound) {
        NSString *subStr = [special substringFromIndex:range.location+range.length];
        subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return subStr;
    }else{
        return @"";
    }
}

+(NSString *)getWebUrl:(NSString *)cont{
    NSRange range = [cont rangeOfString:@"web?url="];
    if (range.location != NSNotFound) {
        NSString *subStr = [cont substringFromIndex:range.location+range.length];
        subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return subStr;
    }else{
        return @"https://www.baidu.com/";
    }
}

+(NSString *)getComponentUrl:(NSString *)cont{
    NSRange range = [cont rangeOfString:@"component?url="];
    if (range.location != NSNotFound) {
        NSString *subStr = [cont substringFromIndex:range.location+range.length];
        subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return subStr;
    }else{
        return @"https://www.baidu.com/";
    }
}

@end
