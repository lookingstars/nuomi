//
//  JZAnimationTestViewController.h
//  nuomi
//
//  Created by jinzelu on 15/10/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/iflyMSC.h"

@interface JZAnimationTestViewController : UIViewController<IFlyRecognizerViewDelegate>


@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象

@end
