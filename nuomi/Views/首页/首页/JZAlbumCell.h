//
//  JZAlbumCell.h
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZAlbumDelegate <NSObject>

@optional
-(void)didSelectedAlbumAtIndex:(NSInteger)index;

@end

@interface JZAlbumCell : UITableViewCell

@property(nonatomic, strong) NSArray *specialArray;/**< 数据源数组 */

@property(nonatomic, assign) id<JZAlbumDelegate> delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
