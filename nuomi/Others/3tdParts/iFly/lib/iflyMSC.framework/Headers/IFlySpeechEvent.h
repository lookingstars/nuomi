//
//  IFlySpeechEvent.h
//  MSCDemo
//
//  Created by admin on 14-8-12.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    /**
	 *  网络状态消息
	 */
    IFly_EVENT_NETPREF = 10001,
	
	/**
	 * 服务端会话id
	 */
	IFly_EVENT_SESSION_ID = 20001,
	
	/**
	 * TTS合成数据消息
	 * - (void) onEvent:(int)eventType arg0:(int)arg0 arg1:(int)arg1 data:(NSData *)eventData
	 * 其中eventData中包含数据
	 * */
	IFly_EVENT_TTS_BUFFER = 21001,
	
	/**TTS 取音频数据key*/
//	KEY_EVENT_TTS_BUFFER = 21002
    
    
    /**IVW oneshot 听写 or 识别结果*/
	IFly_EVENT_IVW_RESULT = 22001,
    
    /**服务端音频url*/
	IFly_EVENT_AUDIO_URL = 23001
    
}IFlySpeechEventEnum;


@interface IFlySpeechEvent : NSObject

/**服务端会话key*/
+(NSString*)KEY_EVENT_SESSION_ID;


/**TTS取音频数据key*/
+(NSString*)KEY_EVENT_TTS_BUFFER;


/**IVW oneshot 听写 or 识别结果 key*/
+(NSString*)KEY_EVENT_IVW_RESULT;


/**服务端音频url key*/
+(NSString*)KEY_EVENT_AUDIO_URL;


@end
