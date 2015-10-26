//
//  ISRDataHander.m
//  MSC
//
//  Created by ypzhao on 12-11-19.
//  Copyright (c) 2012年 iflytek. All rights reserved.
//

#import "ISRDataHelper.h"

@implementation ISRDataHelper

/**
 解析命令词返回的结果
 ****/
+ (NSString*)stringFromAsr:(NSString*)params;
{
    NSMutableString * resultString = [[NSMutableString alloc]init];
    NSString *inputString = nil;
    
    NSArray *array = [params componentsSeparatedByString:@"\n"];
    
    for (int  index = 0; index < array.count; index++)
    {
        NSRange range;
        NSString *line = [array objectAtIndex:index];
        
        NSRange idRange = [line rangeOfString:@"id="];
        NSRange nameRange = [line rangeOfString:@"name="];
        NSRange confidenceRange = [line rangeOfString:@"confidence="];
        NSRange grammarRange = [line rangeOfString:@" grammar="];
        
        NSRange inputRange = [line rangeOfString:@"input="];
        
        if (confidenceRange.length == 0 || grammarRange.length == 0 || inputRange.length == 0 )
        {
            continue;
        }
        
        //check nomatch
        if (idRange.length!=0) {
            NSUInteger idPosX = idRange.location + idRange.length;
            NSUInteger idLength = nameRange.location - idPosX;
            range = NSMakeRange(idPosX,idLength);
            NSString *idValue = [[line substringWithRange:range]
                                 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet] ];
            if ([idValue isEqualToString:@"nomatch"]) {
                return @"";
            }
        }
        
        //Get Confidence Value
        NSUInteger confidencePosX = confidenceRange.location + confidenceRange.length;
        NSUInteger confidenceLength = grammarRange.location - confidencePosX;
        range = NSMakeRange(confidencePosX,confidenceLength);
        
        
        NSString *score = [line substringWithRange:range];
        
        NSUInteger inputStringPosX = inputRange.location + inputRange.length;
        NSUInteger inputStringLength = line.length - inputStringPosX;
        
        range = NSMakeRange(inputStringPosX , inputStringLength);
        inputString = [line substringWithRange:range];
        
        [resultString appendFormat:@"%@ 置信度%@\n",inputString, score];
    }
    
    return resultString;
    
}

/**
 解析听写json格式的数据
 params例如：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 ****/
+ (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];

    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}


/**
 解析语法识别返回的结果
 ****/
+ (NSString *)stringFromABNFJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    NSArray *wordArray = [resultDic objectForKey:@"ws"];
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                NSString *score = [wDic objectForKey:@"sc"];
                [tempStr appendString: str];
                [tempStr appendFormat:@" 置信度:%@",score];
                [tempStr appendString: @"\n"];
            }
        }
    return tempStr;
}

@end
