//
//  IFlySpeechConstant.h
//  MSCDemo
//
//  Created by iflytek on 5/9/14.
//  Copyright (c) 2014 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  公共常量类
 *  主要定义参数的key value值
 */
@interface IFlySpeechConstant : NSObject


#pragma mark - 通用参数key

/*!
 *  语音应用ID
 *  通过开发者网站申请
 *
 *  @return 语音应用IDkey
 */
+(NSString*)APPID;


/*!
 *  语言区域。
 *
 *  @return 语言区域key。
 */
+(NSString*)ACCENT;

/*!
 *  语言区域。
 *
 *  @return 普通话value。
 */
+(NSString*)ACCENT_MANDARIN;

/*!
 *  语言区域。
 *
 *  @return 河南话value。
 */
+(NSString*)ACCENT_HENANESE;

/*!
 *  语言区域。
 *
 *  @return 粤语value。
 */
+(NSString*)ACCENT_CANTONESE;

/*!
 *  语言
 *  支持：zh_cn，zh_tw，en_us<br>
 *
 *  @return 语言key
 */
+(NSString*)LANGUAGE;

/*!
 *  语言
 *
 *  @return 中文value
 */
+(NSString*)LANGUAGE_CHINESE;


/*!
 *  语言
 *
 *  @return 中文台湾value
 */
+(NSString*)LANGUAGE_CHINESE_TW;

/*!
 *  语言
 *
 *  @return 英文value
 */
+(NSString*)LANGUAGE_ENGLISH;

/*!
 *  返回结果的数据格式，
 *  可设置为json，xml，plain，默认为json。
 *
 *  @return 返回结果的数据格式key
 */
+(NSString*)RESULT_TYPE;

/*!
 *  应用领域。
 *
 *  @return 应用领域key
 */
+(NSString*)IFLY_DOMAIN;

/*!
 *  个性化数据上传类型
 *
 *  @return 个性化数据上传类型key
 */
+(NSString*)DATA_TYPE;

/*!
 *  语音输入超时时间
 *   单位：ms，默认30000
 *
 *  @return 语音输入超时时间key
 */
+(NSString*)SPEECH_TIMEOUT;

/*!
 *  网络连接超时时间
 *  单位：ms，默认20000
 *
 *  @return 网络连接超时时间key
 */
+(NSString*)NET_TIMEOUT;

/*!
 *  业务类型。
 *
 *  @return 业务类型key。
 */
+(NSString*)SUBJECT;

/*!
 *  扩展参数。
 *
 *  @return 扩展参数key。
 */
+(NSString*)PARAMS;

/*!
 *  录音音量返回时间间隔。
 *
 *  @return 间隔key。
 */
+(NSString*)POWER_CYCLE;

/*!
 *  合成、识别、唤醒、评测、声纹等业务采样率。
 *
 *  @return 合成及识别采样率key。
 */
+(NSString*)SAMPLE_RATE;

/*!
 *  合成、识别、唤醒、评测、声纹等业务采样率。
 *
 *  @return 合成及识别采样率8K Value。
 */
+(NSString*)SAMPLE_RATE_8K;

/*!
 *  合成、识别、唤醒、评测、声纹等业务采样率。
 *
 *  @return 合成及识别采样率16K Value。
 */
+(NSString*)SAMPLE_RATE_16K;

/*!
 *  引擎类型。
 *    可选：local，cloud，auto
 *  默认：auto
 *
 *  @return 引擎类型key。
 */
+(NSString*)ENGINE_TYPE;

/*!
 *  本地识别引擎。
 *
 *  @return 本地识别引擎value。
 */
+(NSString*)TYPE_LOCAL;

/*!
 *  云端识别引擎。
 *
 *  @return 云端识别引擎value。
 */
+(NSString*)TYPE_CLOUD;

/*!
 *  混合识别引擎。
 *
 *  @return 混合识别引擎value。
 */
+(NSString*)TYPE_MIX;

/*!
 *  引擎根据当前配置进行选择。
 *
 *  @return 引擎根据当前配置进行选择value。
 */
+(NSString*)TYPE_AUTO;

/*!
 *  输入文本编码格式。
 *
 *  @return 编码格式key。
 */
+(NSString*)TEXT_ENCODING;

/*!
 *  结果编码格式。
 *
 *  @return 结果编码格式key。
 */
+(NSString*)RESULT_ENCODING;

#pragma mark -  合成相关设置key
/*!
 *  语速
 *  范围 （0~100） 默认值:50
 *
 *  @return 语速key
 */
+(NSString*)SPEED;

/*!
 *  音调
 *  范围（0~100）默认值:50
 *
 *  @return 音调key
 */
+(NSString*)PITCH;

/*!
 *  合成录音保存路径
 *
 *  @return 合成录音保存路径key
 */
+(NSString*)TTS_AUDIO_PATH;

/**
 *  启用VAD功能
 *
 *  @return 启用VAD功能key
 */
+(NSString*)VAD_ENABLE;

/*!
 *  VAD前端点超时
 *  范围：0-10000(单位ms)
 *
 *  @return VAD前端点超时key
 */
+(NSString*)VAD_BOS;

/*!
 *  VAD后端点超时 。
 *  可选范围：0-10000(单位ms)
 *
 *  @return VAD后端点超时key
 */
+(NSString*)VAD_EOS;

/*
 *  云端支持如下发音人：
 *  对于网络TTS的发音人角色，不同引擎类型支持的发音人不同，使用中请注意选择。
 *
 *  |--------|----------------|
 *  |  发音人 |  参数          |
 *  |--------|----------------|
 *  |  小燕   |   xiaoyan     |
 *  |--------|----------------|
 *  |  小宇   |   xiaoyu      |
 *  |--------|----------------|
 *  |  凯瑟琳 |   catherine   |
 *  |--------|----------------|
 *  |  亨利   |   henry       |
 *  |--------|----------------|
 *  |  玛丽   |   vimary      |
 *  |--------|----------------|
 *  |  小研   |   vixy        |
 *  |--------|----------------|
 *  |  小琪   |   vixq        |
 *  |--------|----------------|
 *  |  小峰   |   vixf        |
 *  |--------|----------------|
 *  |  小梅   |   vixl        |
 *  |--------|----------------|
 *  |  小莉   |   vixq        |
 *  |--------|----------------|
 *  |  小蓉   |   vixr        |
 *  |--------|----------------|
 *  |  小芸   |   vixyun      |
 *  |--------|----------------|
 *  |  小坤   |   vixk        |
 *  |--------|----------------|
 *  |  小强   |   vixqa       |
 *  |--------|----------------|
 *  |  小莹   |   vixyin      |
 *  |--------|----------------|
 *  |  小新   |   vixx        |
 *  |--------|----------------|
 *  |  楠楠   |   vinn        |
 *  |--------|----------------|
 *  |  老孙   |   vils        |
 *  |--------|----------------|
 */

/*!
 *  发音人
 *  <table>
 *  <thead>
 *  <tr><th>*云端发音人名称</th><th><em>参数</em></th>
 *  </tr>
 *  </thead>
 *  <tbody>
 *  <tr><td>小燕</td><td>xiaoyan</td></tr>
 *  <tr><td>小宇</td><td>xiaoyu</td></tr>
 *  <tr><td>凯瑟琳</td><td>catherine</td></tr>
 *  <tr><td>亨利</td><td>henry</td></tr>
 *  <tr><td>玛丽</td><td>vimary</td></tr>
 *  <tr><td>小研</td><td>vixy</td></tr>
 *  <tr><td>小琪</td><td>vixq</td></tr>
 *  <tr><td>小峰</td><td>vixf</td></tr>
 *  <tr><td>小梅</td><td>vixl</td></tr>
 *  <tr><td>小莉</td><td>vixq</td></tr>
 *  <tr><td>小蓉(四川话)</td><td>vixr</td></tr>
 *  <tr><td>小芸</td><td>vixyun</td></tr>
 *  <tr><td>小坤</td><td>vixk</td></tr>
 *  <tr><td>小强</td><td>vixqa</td></tr>
 *  <tr><td>小莹</td><td>vixying</td></tr>
 *  <tr><td>小新</td><td>vixx</td></tr>
 *  <tr><td>楠楠</td><td>vinn</td></tr>
 *  <tr><td>老孙</td><td>vils</td></tr>
 *  </tbody>
 *  </table>
 *
 *  @return 发音人key
 */
+(NSString*)VOICE_NAME;

/*!
 *  音量
 *  范围（0~100） 默认值:50
 *
 *  @return 音量key
 */
+(NSString*)VOLUME ;

/*!
 *  合成音频播放缓冲时间
 *    即缓冲多少秒音频后开始播放，如tts_buffer_time=1000;
 *  默认缓冲1000ms毫秒后播放。
 *
 *  @return 合成音频播放缓冲时间缓冲时间key
 */
+(NSString*)TTS_BUFFER_TIME ;

/** 合成数据即时返回
 */

/**
 *  合成数据是否即时返回
 *  是否需要数据回调，为1时，当合成一段音频会通过onEvent回调返回，直接合成结束；
 *  设置为1为即时返回；0为非即时返回；默认值为0；
 *
 *  @return 成数据即时返回key
 */
+(NSString*)TTS_DATA_NOTIFY;

/**
 *  预合成文本
 *
 *  @return 约合成文本参数key
 */
+(NSString*)NEXT_TEXT;

/**
 *  是否需要打开MPPlayingInfocenter
 *
 *  @return 是否需要打开MPPlayingInfocenter 参数key
 */
+(NSString*)MPPLAYINGINFOCENTER;

#pragma mark - 识别、听写、语义相关设置key

/*!
 *  录音源
 *    录音时的录音方式，默认为麦克风，设置为1；
 *  如果需要外部送入音频，设置为-1，通过WriteAudio接口送入音频。
 *
 *  @return 录音源key
 */
+(NSString*)AUDIO_SOURCE;

/*!
 *  识别录音保存路径
 *
 *  @return 识别录音保存路径key
 */
+(NSString*) ASR_AUDIO_PATH;

/*!
 *  设置是否开启语义
 *
 *  @return 设置是否开启语义key
 */
+(NSString*)ASR_SCH;

/*!
 *  设置是否有标点符号
 *
 *  @return 设置是否有标点符号key
 */
+(NSString*)ASR_PTT;

/*!
 *  设置是否有标点符号
 *
 *  @return 设置是有标点符号Value
 */
+(NSString*)ASR_PTT_HAVEDOT;

/*!
 *  设置是否有标点符号
 *
 *  @return 设置是无标点符号Value
 */
+(NSString*)ASR_PTT_NODOT;

/*!
 *  本地语法名称。
 *    本地语法名称，对应云端的有CLOUD_GRAMMAR
 *
 *  @return 本地语法名称key。
 */
+(NSString*)LOCAL_GRAMMAR;

/*!
 *  云端语法ID。
 *  云端编译语法返回的表示，早期版本使用GRAMMAR_ID，仍然兼容，但建议使用新的。
 *
 *  @return 云端语法ID key。
 */
+(NSString*)CLOUD_GRAMMAR;

/*!
 *  语法类型
 *
 *  @return 语法类型key
 */
+(NSString*)GRAMMAR_TYPE;

/*!
 *  语法内容。
 *
 *  @return 语法内容key。
 */
+(NSString*)GRAMMAR_CONTENT;

/*!
 *  字典内容。
 *
 *  @return 字典内容key。
 */
+(NSString*)LEXICON_CONTENT;

/*!
 *  字典名字。
 *
 *  @return 字典名字key。
 */
+(NSString*)LEXICON_NAME;

/*!
 *  语法名称列表。
 *
 *  @return 语法名称列表key。
 */
+(NSString*)GRAMMAR_LIST;

/*!
 *  开放语义协议版本号。
 *  如需使用请在http://osp.voicecloud.cn/上进行业务配置
 *
 *  @return 开放语义协议版本号key。
 */
+(NSString*)NLP_VERSION;

#pragma mark -  唤醒相关设置key
/*!
 *  唤醒门限值。
 *
 *  @return 唤醒门限值key。
 */
+(NSString*)IVW_THRESHOLD;

/*!
 *  唤醒服务类型。
 *
 *  @return 唤醒服务类型key。
 */
+(NSString*)IVW_SST;

/*!
 *  唤醒+识别。
 *
 *  @return 唤醒+识别key。
 */
+(NSString*)IVW_ONESHOT;

/*!
 *  唤醒工作方式
 *    1：表示唤醒成功后继续录音，0：表示唤醒成功后停止录音。
 *
 *  @return 唤醒工作方式key
 */
+(NSString*)KEEP_ALIVE;

#pragma mark -  评测相关设置key
/*!
 *  评测类型<br>
 *   可选值：read_syllable(英文评测不支持):单字;read_word:词语;read_sentence:句子;read_chapter(待开放):篇章。
 *
 *  @return 评测类型 key
 */
+(NSString*)ISE_CATEGORY;

/*!
 *  评测结果等级<br>
 *    可选值：complete：完整 ；plain：简单
 *
 *  @return 评测结果等级 key
 */
+(NSString*)ISE_RESULT_LEVEL;

/*!
 *  评测结果格式
 *    可选值：xml;plain
 *
 *  @return 评测结果格式 key
 */
+(NSString*)ISE_RESULT_TYPE;

/*!
 *  评测录音保存路径
 *
 *  @return 评测录音保存路径key
 */
+(NSString*) ISE_AUDIO_PATH;


#pragma mark -  语音+业务key
/**
 *  本地所有资源
 *
 *  @return 本地所有资源key
 */
+ (NSString *)PLUS_LOCAL_ALL;

/**
 *  本地合成资源
 *
 *  @return 本地合成资源key
 */
+ (NSString *)PLUS_LOCAL_TTS;

/**
 *  本地识别资源
 *
 *  @return 本地识别资源key
 */
+ (NSString *)PLUS_LOCAL_ASR;

/**
 *  本地唤醒资源
 *
 *  @return 本地唤醒资源key
 */
+ (NSString *)PLUS_LOCAL_IVW;

#pragma mark -  身份验证业务key

/**
 *  auth_id
 *  用于用户注册和登录、查询、删除等业务时标识用户身份
 *
 *  @return 用户标识
 */
+ (NSString*)MFV_AUTH_ID;

/**
 *  请求业务类型，可选值：mfv（默认，融合验证），ivp（声纹），ifr（人脸）
 *
 *  @return 请求业务类型key
 */
+ (NSString*)MFV_SUB;

/**
 *  会话类型，不同sub有不同的sst取值。
 *  ifr：enroll，verify，identify，reenroll，query，delete
 *  ivp：enroll（train），verify，reenroll，query，delete，download
 *
 *  @return 会话类型key
 */
+ (NSString*)MFV_SST;

/**
 *  融合验证模式，仅在融合验证场景下使用。可选值：sin（单一生物特征数据验证），mix（混合生物特征数据验证），agi（灵活生物特征数据验证）
 *
 *  @return 融合验证模式key
 */
+ (NSString*)MFV_VCM;

/**
 *  特征场景，用来说明本次验证将涉及的业务。可选值：ivp，ifr，ivp|ifr
 *
 *  @return 特征场景 key
 */
+ (NSString*)MFV_SCENES;

/**
 *  确认周期(affirmance cycle，单位：s)，用户设置的确认超时时间（生命周期），仅在灵活融合验证场景下使用
 *
 *  @return 确认周期key
 */
+ (NSString*)MFV_AFC;

/**
 *  数据保存路径
 *
 *  @return 数据保存路径key
 */
+ (NSString*)MFV_DATA_PATH;

/**
 *  训练次数：取值2~9.无默认值，必须明确指定。
 *
 *  @return 训练次数key
 */
+ (NSString*)MFV_RGN;

/**
 *  声纹确认门限值，验证得分>=tsd验证通过，否则验证失败（该参数目前不支持,作为保留参数。）却只范围：0~100.
 *
 *  @return 声纹确认门限值key
 */
+ (NSString*)MFV_TSD;

/**
 *  密码文本。从服务端下载，比如数字密码所需要的数字串。
 *
 *  @return 密码文本key
 */
+ (NSString*)MFV_PTXT;

/**
 *  密码类型。取值：1(文本密码),2(自由说),3(数字密码).
 *
 *  @return 密码类型key
 */
+ (NSString*)MFV_PWDT;

/**
 *  取消注册。取值：0(不取消，即不生效),1(取消本次注册).
 *
 *  @return 取消注册key
 */
+ (NSString*)MFV_FIN;

/**
 *  等待超时时间:描述客户端等待结果的超时时间
 *
 *  @return 等待超时时间:key
 */
+ (NSString*)MFV_WTT;

/**
 *  数据格式
 *  声纹为音频采样率支持：16000和8000;人脸为图片格式，支持jpg和gif
 *
 *  @return 数据格式key
 */
+ (NSString*)MFV_DATA_FORMAT;

/**
 *  数据压缩编码
 *  声纹为;人脸支持raw，不对图片压缩
 *
 *  @return 数据压缩编码key
 */
+ (NSString*)MFV_DATA_ENCODING;

@end
