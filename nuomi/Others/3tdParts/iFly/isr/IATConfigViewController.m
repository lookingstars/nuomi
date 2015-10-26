//
//  ISRConfigViewController.m
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "IATConfigVIewController.h"
#import "IATConfig.h"


@interface IATConfigVIewController ()
@property (nonatomic,strong) SAMultisectorSector *bosSec;
@property (nonatomic,strong) SAMultisectorSector *eosSec;
@property (nonatomic,strong) SAMultisectorSector *recSec;
@end

@implementation IATConfigVIewController


#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setupMultisectorControl];
    [self needUpdateView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 用于storyboard scrollview 可以滑动
 ****/
-(void)viewDidLayoutSubviews
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    _backScrollView.contentSize = CGSizeMake(size.width ,size.height+300);
}


#pragma mark -  界面UI处理
-(void)initView
{
    _accentPicker.delegate = self;
    _accentPicker.dataSource = self;
    _accentPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _accentPicker.textColor = [UIColor whiteColor];
    _accentPicker.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    _accentPicker.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:17];
    _accentPicker.highlightedTextColor = [UIColor colorWithRed:0.0 green:168.0/255.0 blue:255.0/255.0 alpha:1.0];
    _accentPicker.interitemSpacing = 20.0;
    _accentPicker.fisheyeFactor = 0.001;
    _accentPicker.pickerViewStyle = AKPickerViewStyle3D;
    _accentPicker.maskDisabled = false;
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
}


- (void)setupMultisectorControl{
    [_roundSlider addTarget:self action:@selector(multisectorValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    UIColor *blueColor = [UIColor colorWithRed:0.0 green:168.0/255.0 blue:255.0/255.0 alpha:1.0];
    UIColor *redColor = [UIColor colorWithRed:245.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    UIColor *greenColor = [UIColor colorWithRed:29.0/255.0 green:207.0/255.0 blue:0.0 alpha:1.0];
    
    _bosSec = [SAMultisectorSector sectorWithColor:redColor maxValue:10000];//前端点
    _eosSec = [SAMultisectorSector sectorWithColor:blueColor maxValue:10000];//后端点
    _recSec = [SAMultisectorSector sectorWithColor:greenColor maxValue:60000];//录音超时

    _bosSec.endValue = (double)[IATConfig sharedInstance].vadBos.integerValue;
    
    
    _eosSec.endValue = [IATConfig sharedInstance].vadEos.integerValue;
    _recSec.endValue = [IATConfig sharedInstance].speechTimeout.integerValue;
    
    [_roundSlider addSector:_bosSec];
    [_roundSlider addSector:_eosSec];
    [_roundSlider addSector:_recSec];//半径依次增大
    
    _backScrollView.canCancelContentTouches = YES;
    _backScrollView.delaysContentTouches = NO;//优先使用子页面的触摸事件
    
}


- (void)updateDataView{

    IATConfig *config = [IATConfig sharedInstance];
    config.speechTimeout =  [NSString stringWithFormat:@"%ld", (long)_recSec.endValue];
    config.vadBos =  [NSString stringWithFormat:@"%ld", (long)_bosSec.endValue];
    config.vadEos =  [NSString stringWithFormat:@"%ld", (long)_eosSec.endValue];
    

    _bosLabel.text = config.vadBos;
    _eosLabel.text = config.vadEos;
    _recTimeoutLabel.text = config.speechTimeout;
    
    _recSec.endValue = [config.speechTimeout integerValue];
    _bosSec.endValue = [config.vadBos integerValue];
    _eosSec.endValue = [config.vadEos integerValue];
    
}


-(void)needUpdateView {
    
    IATConfig *instance = [IATConfig sharedInstance];
    
    _recTimeoutLabel.text = instance.speechTimeout;//超时等时间设置
    _eosLabel.text = instance.vadEos;
    _bosLabel.text = instance.vadBos;
    
    _recSec.endValue = instance.speechTimeout.integerValue;
    _bosSec.endValue = instance.vadBos.integerValue;
    _eosSec.endValue = instance.vadEos.integerValue;
    
    
    if ([instance.language isEqualToString:[IFlySpeechConstant LANGUAGE_CHINESE]]) {//语种选择
        if ([instance.accent isEqualToString:[IFlySpeechConstant ACCENT_CANTONESE]]) {
            [_accentPicker selectItem:0 animated:NO];
            
        }else if ([instance.accent isEqualToString:[IFlySpeechConstant ACCENT_HENANESE]]) {
            [_accentPicker selectItem:2 animated:NO];
            
        }else if ([instance.accent isEqualToString:[IFlySpeechConstant ACCENT_MANDARIN]]) {
            [_accentPicker selectItem:1 animated:NO];
            
        }
    }else if ([instance.language isEqualToString:[IFlySpeechConstant LANGUAGE_ENGLISH]]) {
        [_accentPicker selectItem:3 animated:NO];
    }
    
    
    if ([instance.sampleRate isEqualToString:[IFlySpeechConstant SAMPLE_RATE_8K]]) {//采样率
        _sampleSeg.selectedSegmentIndex = 1;
        
    }else if ([instance.sampleRate isEqualToString:[IFlySpeechConstant SAMPLE_RATE_16K]]) {
        _sampleSeg.selectedSegmentIndex = 0;
        
    }
    
    if ([instance.dot isEqualToString:[IFlySpeechConstant ASR_PTT_HAVEDOT]]) {//标点
        _dotSeg.selectedSegmentIndex = 0;
        
    }else if ([instance.dot isEqualToString:[IFlySpeechConstant ASR_PTT_NODOT]]) {
        _dotSeg.selectedSegmentIndex = 1;
        
    }
    
    if (instance.haveView == NO) {
        _viewSeg.selectedSegmentIndex = 0;
        
    }else if (instance.haveView == 1) {
        _viewSeg.selectedSegmentIndex = 1;
        
    }
    
}


#pragma 事件处理函数

- (void)multisectorValueChanged:(id)sender{
    [self updateDataView];
}


- (IBAction)accentSegHandler:(id)sender {

    
    UISegmentedControl *control = sender;
    if (control.selectedSegmentIndex == 0) {//粤语
        
        [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_CHINESE];
        [IATConfig sharedInstance].accent = [IFlySpeechConstant ACCENT_MANDARIN];
        
    }else if (control.selectedSegmentIndex == 1) {//英语
        [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_ENGLISH];
        
    }else if (control.selectedSegmentIndex == 2) {//河南话
        [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_CHINESE];
        [IATConfig sharedInstance].accent = [IFlySpeechConstant ACCENT_HENANESE];
        
    }else if (control.selectedSegmentIndex == 3) {//粤语
        
        [IATConfig sharedInstance].language = [IFlySpeechConstant LANGUAGE_CHINESE];
        [IATConfig sharedInstance].accent = [IFlySpeechConstant ACCENT_CANTONESE];
        
    }
}

- (IBAction)viewSegHandler:(id)sender {
    UISegmentedControl *control = sender;
    if (control.selectedSegmentIndex == 0) {
        [IATConfig sharedInstance].haveView = NO;
        
    }else if (control.selectedSegmentIndex == 1) {
        [IATConfig sharedInstance].haveView = YES;
        
    }
}

- (IBAction)sampleSegHandler:(id)sender {
    
    UISegmentedControl *control = sender;
    if (control.selectedSegmentIndex == 0) {
        [IATConfig sharedInstance].sampleRate = [IFlySpeechConstant SAMPLE_RATE_16K];
        
    }else if (control.selectedSegmentIndex == 1) {
        [IATConfig sharedInstance].sampleRate = [IFlySpeechConstant SAMPLE_RATE_8K];
        
    }
}


- (IBAction)dotSegHandler:(id)sender {
    UISegmentedControl *control = sender;
    
    if (control.selectedSegmentIndex == 0) {
        [IATConfig sharedInstance].dot = [IFlySpeechConstant ASR_PTT_HAVEDOT];
        
    }else if (control.selectedSegmentIndex == 1) {
        [IATConfig sharedInstance].dot = [IFlySpeechConstant ASR_PTT_NODOT];
    }
}




#pragma mark - 识别语言选择器数据源

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    IATConfig* instance = [IATConfig sharedInstance];
    return instance.accentNickName.count;
}
- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item;
{
    IATConfig* instance = [IATConfig sharedInstance];
    return  [instance.accentNickName objectAtIndex:item];
}


#pragma mark - 选择识别语言事件回调
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    IATConfig *instance = [IATConfig sharedInstance];

    if (item == 0) { //粤语
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
        instance.accent = [IFlySpeechConstant ACCENT_CANTONESE];
    }else if (item == 1) {//普通话
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
        instance.accent = [IFlySpeechConstant ACCENT_MANDARIN];
    }else if (item == 2) {//河南话
        instance.language = [IFlySpeechConstant LANGUAGE_CHINESE];
        instance.accent = [IFlySpeechConstant ACCENT_HENANESE];
    }else if (item == 3) {//英文
        instance.language = [IFlySpeechConstant LANGUAGE_ENGLISH];
    }
    
}


@end
