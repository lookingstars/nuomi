//
//  JZAlbumCell.h
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZMovieAlbumDelegate <NSObject>

@optional
-(void)didSelectedAlbumAtIndex:(NSInteger)index;

@end

@interface JZMovieAlbumCell : UITableViewCell

@property(nonatomic, strong) NSArray *imgurlArray;/**< 图片URL */

@property(nonatomic, assign) id<JZMovieAlbumDelegate> delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
