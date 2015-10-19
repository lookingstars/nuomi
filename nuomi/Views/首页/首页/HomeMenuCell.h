//
//  HomeMenuCell.h
//  meituan
//
//  Created by jinzelu on 15/6/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMenuButton.h"

@protocol HomeMenuDelegate <NSObject>

-(void)homeMenuDidSelectedAtIndex:(NSInteger)index;

@end

@interface HomeMenuCell : UITableViewCell

@property (nonatomic, assign) id<HomeMenuDelegate> delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@end
