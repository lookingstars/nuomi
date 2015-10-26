//
//  IFlyISVDelegate.h
//  msc_UI
//
//  Created by admin on 14-9-15.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlySpeechError.h"

@protocol IFlyISVDelegate

-(void) onResult:(NSDictionary *)dic;

-(void) onError:(IFlySpeechError *) errorCode;

@optional
-(void) onRecognition;

-(void) onVolumeChanged: (int)volume;

@end