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

@end
