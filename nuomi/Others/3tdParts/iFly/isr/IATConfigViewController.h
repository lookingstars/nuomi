//
//  ISRConfigViewController.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMultisectorControl.h"
#import "AKPickerView.h"
#import "iflyMSC/iflyMSC.h"

@interface IATConfigVIewController : UIViewController<AKPickerViewDataSource,AKPickerViewDelegate>

@property (nonatomic,weak) IFlySpeechRecognizer *isrRecognizer;

@property (weak, nonatomic) IBOutlet SAMultisectorControl *roundSlider;

@property (weak, nonatomic) IBOutlet UILabel *recTimeoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *bosLabel;
@property (weak, nonatomic) IBOutlet UILabel *eosLabel;


@property (weak, nonatomic) IBOutlet UISegmentedControl *accentSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sampleSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dotSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *viewSeg;

@property (weak, nonatomic) IBOutlet AKPickerView *accentPicker;

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@end
