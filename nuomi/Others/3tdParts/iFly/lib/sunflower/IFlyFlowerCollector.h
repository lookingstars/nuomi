//
//  IFlyFlowerCollector.m
//  SunFlower
//
//  Created by cheng ping on 14-2-17.
//  Copyright (c) 2014年 IFLYTEK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    Male = 1,
    Female = 2,
    Unknown = 0,
}IFlyGender;


#define SUNFLOWERNOTIFICATION @"SUNFLOWERNSNOTIFICATION"

/** IFlyFlowerCollector是统计的核心类，本身不需要实例化，所有方法以类方法的形式提供.
 
 */
@interface IFlyFlowerCollector : NSObject


#pragma mark 开启统计

/**
 *  设置用户账号 只运行一次，多次设置无效
 *
 *  @param userID
 */
+ (void) SetAppid:(NSString*) appid;

#pragma mark 配置

/** 开启CrashReport收集, 默认是开启状态.
 
 @param value 设置成NO,就可以关闭CrashReport收集.
 @return void.
 */
+ (void) SetCaptureUncaughtException:(BOOL)value;

/**
 *  设置开启Debug模式（默认关闭）
 *
 *  @param flag 默认NO
 */
+ (void) SetDebugMode:(BOOL)flag;

/**
 *  为了更精确的统计用户地理位置，可以调用此方法传入经纬度信息
 需要链接 CoreLocation.framework 并且 #import <CoreLocation/CoreLocation.h>
 *
 *  @param flag 标志位
 */
+ (void) SetAutoLocation:(BOOL)flag;

/**
 *  设置channelID
 *
 *  @param channel
 */
+ (void) setChannelID:(NSString *) channel;

#pragma mark 根据需要选择使用
/**
 *  用户性别
 *
 *  @param gender 1 Male 2 Female  0 unknown
 */
+ (void) SetGender:(IFlyGender)gender;

/**
 *  用户年龄
 *
 *  @param age 0 <= i <= 200
 */
+ (void) SetAge:(int) age;

/**
 *  用户ID
 *
 *  @param userId
 */
+ (void) SetUserId:(NSString *) userId;

#pragma mark 立即发送数据
/**
 *  立即发送数据
 */
+ (void) Flush;


#pragma mark 页面统计


/**
 *  页面时长统计,记录某个view被打开多长时间,并计时
 *
 *  @param pageName 需要记录时长的view名称.
 */
+ (void) OnPageStart:(NSString *)pageName;

/**
 *  页面时长统计,记录某个view被打开多长时间,并计时
 *
 *  @param pageName 需要记录时长的view名称.
 */
+ (void) OnPageEnd:(NSString *)pageName;



#pragma mark 事件统计


/**
 *  自定义事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 */
+ (void) OnEvent:(NSString *)eventId;

/**
 *  自定义事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 *  @param label   分类标签
 */
+ (void) OnEvent:(NSString *)eventId label:(NSString *)label;

/**
 *  自定义事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 *  @param dic
 */
+ (void) OnEvent:(NSString *)eventId paramDic:(NSDictionary *)dic;

/**
 *  自定义事件统计
 *
 *  @param eventId  网站上注册的事件Id.
 *  @param duration 时长
 */
+ (void) OnEventDuration:(NSString *)eventId duration:(long) duration;

/**
 *  自定义事件统计
 *
 *  @param eventId  网站上注册的事件Id.
 *  @param label    分类标签
 *  @param duration 时长
 */
+ (void) OnEventDuration:(NSString *)eventId label:(NSString *)label duration:(long) duration;

/**
 *  自定义事件统计
 *
 *  @param eventId  网站上注册的事件Id.
 *  @param paramDic
 *  @param duration 时长
 */
+ (void) OnEventDuration:(NSString *)eventId paramDic:(NSDictionary *)dic duration:(long) duration;

/**
 *  开始事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 */
+ (void) OnBeginEvent:(NSString *)eventId;

/**
 *  开始事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 *  @param dic
 */
+ (void) OnBeginEvent:(NSString *)eventId paramDic:(NSDictionary *)dic;

/**
 *  结束事件统计
 *
 *  @param eventId 网站上注册的事件Id.
 */
+ (void) OnEndEvent:(NSString *)eventId;

#pragma mark log
/**
 *   传入日志
 *
 *  @param businessType
 *  @param dic
 */
+ (void) onLog:(NSString *)businessType paramDic:(NSDictionary *)dic;

/**
 *  传入日志
 *
 *  @param businessType
 *  @param dic
 *  @param duration
 *  @param label
 */
+ (void) onLog:(NSString *)businessType paramDic:(NSDictionary *)dic duration:(long) duration label:(NSString *)label;

#pragma mark 在线参数

/**
 *  更新在线参数,仅在参数有变化的情况下返回
 */
+ (void) updateOnlineConfig;

/**
 *  获取在线参数
 *
 *  @param key
 */
+ (NSString *) getOnlineParams:(NSString *)key;

#pragma mark ---


/** 判断设备是否越狱
 */
+ (BOOL) isJailbroken;
/** 判断你的App是否被破解
 */
+ (BOOL) isPirated;

@end