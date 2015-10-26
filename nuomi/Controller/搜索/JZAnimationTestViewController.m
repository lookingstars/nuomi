//
//  JZAnimationTestViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAnimationTestViewController.h"
#import "JZNetworkSingleton.h"

//包含头文件
//文字转语音
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

//语音转文字
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"

#import "ISRDataHelper.h"

#define WIDTH 50
#define PHOTO_HEIGHT 150

@interface JZAnimationTestViewController ()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate,UITextFieldDelegate>
{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    NSString *_resultStr;
}

@end

@implementation JZAnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = RGB(239, 239, 239);
    
    [self initIFly];
    [self initViews];
    
    [self drawImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [_iFlySpeechSynthesizer stopSpeaking];
//    [_iFlySpeechRecognizer stopListening];
}



#pragma mark - **************** 语音《-》文字
//文字转语音
-(void)initIFly{
    //1.创建合成对象
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //2.设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]]; //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"xiaoxin" forKey: [IFlySpeechConstant VOICE_NAME]]; //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
    //    [_iFlySpeechSynthesizer startSpeaking: @"喜欢你，那双眼动人，笑声更迷人，愿再可，轻抚你。你好,我是科大讯飞的小燕"];
    [_iFlySpeechSynthesizer startSpeaking: @"我只是个小孩,干吗那么认真啊。不对,动感超人是这样笑的，5呼呼呼呼~~~~~~。"];
}

-(void)initViews{
    //搜索框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64+10, screen_width-60, 30)];
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"请 “尝试语音输入课程“";
    self.textField.text = @"";
    self.textField.backgroundColor = RGB(242, 242, 242);
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
    
    
    //语音按钮
    UIImageView *voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screen_width-60, 64+6, 60, 36)];
    [voiceImageView setImage:[UIImage imageNamed:@"voice"]];
    [self.view addSubview:voiceImageView];
    UITapGestureRecognizer *voiceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapVoice)];
    voiceImageView.userInteractionEnabled = YES;
    [voiceImageView addGestureRecognizer:voiceTap];
}

-(void)OnTapVoice{
    _resultStr = @"";
    [self startBtn];
}

/**
 *  启动听写
 */
-(void)startBtn{
    if (_iflyRecognizerView == nil) {
        [self initRecognizer ];
    }
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iflyRecognizerView start];
}

//有界面
-(void)initRecognizer{
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil) {
        //设置最长录音时间
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点 3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点   3000
        [_iflyRecognizerView setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //设置采样率，推荐使用16K    16000
        [_iflyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //        if ([instance.language isEqualToString:[IATConfig chinese]]) {
        //            //设置语言   zh_cn
        [_iflyRecognizerView setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //            //设置方言  mandarin
        [_iflyRecognizerView setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //        }else if ([instance.language isEqualToString:[IATConfig english]]) {
        //            //设置语言
        //            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //        }
        //        //设置是否返回标点符号   0
        [_iflyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
}



#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IFlySpeechSynthesizerDelegate
//结束代理
-(void)onCompleted:(IFlySpeechError *)error{
    NSLog(@"onCompleted");
}
//合成开始
- (void) onSpeakBegin{
    NSLog(@"onSpeakBegin");
}
//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"onBufferProgress");
}
//合成播放进度
- (void) onSpeakProgress:(int) progress{
    //    NSLog(@"onSpeakProgress");
}

#pragma mark - IFlySpeechRecognizerDelegate
//没有界面时的语音听写
//识别结果返回代理
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];//合并结果
    }
    NSLog(@"识别成功:%@",result);
    _resultStr = [NSString stringWithFormat:@"%@%@",_textField.text,result];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
    _textField.text = [NSString stringWithFormat:@"%@%@", _textField.text,resultFromJson];
}

-(void)onError:(IFlySpeechError *)errorCode{
    NSLog(@"识别失败");
}

-(void)onEndOfSpeech{
    NSLog(@"停止录音");
}

-(void)onBeginOfSpeech{
    NSLog(@"开始录音");
}

-(void)onVolumeChanged:(int)volume{
    //    NSLog(@"音量");
}




/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    _resultStr = [NSString stringWithFormat:@"%@%@",_textField.text,result];
    if (isLast) {
        NSLog(@"结果：%@",_resultStr);
        self.textField.text = _resultStr;
    }
}


#pragma mark - **************** 动画
-(void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入8位动态密码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil, nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    alertView.delegate = self;
    alertView.tag = 10;
    [alertView show];
}

//绘图
-(void)drawImage{
    //阴影图层
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layerShadow.position = CGPointMake(160, 200);
    layerShadow.cornerRadius = PHOTO_HEIGHT/2;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = 2;
//    [self.view.layer addSublayer:layerShadow];
    
    //自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT/2;
    //图层设置圆角，必须
    layer.masksToBounds = YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    
    //1.
    //利用图层形变解决图像倒立问题
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    layer.delegate = self;
    
    //2.使用contents
    UIImage *image = [UIImage imageNamed:@"detailViewDefaultMidImage"];
    [layer setContents:(id)image.CGImage];
    [self.view.layer addSublayer:layer];
    
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"%@",layer);
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立问题
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"detailViewDefaultMidImage"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    
    CGContextRestoreGState(ctx);
}



//绘制图层
-(void)drawMyLayer{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //获得跟图层
    CALayer *layer = [[CALayer alloc] init];
    layer.hidden = NO;
    //设置颜色
    layer.backgroundColor = navigationBarColor.CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    //设置圆角
    layer.cornerRadius = WIDTH/2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    //设置边框
    layer.borderColor = [UIColor greenColor].CGColor;
    layer.borderWidth = 1;
    //设置锚点
//    layer.anchorPoint = CGPointZero;
    [self.view.layer addSublayer:layer];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];    
    CALayer *layer=[self.view.layer.sublayers lastObject];
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH*4;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
