//
//  IFlyResourceUtil.h
//  MSCDemo
//
//  Created by admin on 14-6-20.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

//#import <Foundation/Foundation.h>



@interface IFlyResourceUtil : NSObject

/**通过MSPSetParam，启动引擎的标识
 */
+(NSString*) ENGINE_START;

/**通过MSPSetParam，销毁引擎的标识
 */
+(NSString*) ENGINE_DESTROY;

/**识别引擎的资源目录标识
 */
+(NSString*) ASR_RES_PATH;

/**语法构建目录
 */
+(NSString*) GRM_BUILD_PATH;

/**合成引擎的资源目录标识，同时需要先传入voice_name方可生效
 */
+(NSString*) TTS_RES_PATH;

/**唤醒资源的资源目录标识
 */
+(NSString*) IVW_RES_PATH;

/**语法类型
 */
+(NSString*) GRAMMARTYPE;

/**资源存放路径
 *@return 资源目录
 */
+(NSString*) generateResourcePath:(NSString *)path;

@end
