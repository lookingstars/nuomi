//
//  ImageScrollCell.h
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ImageScrollCell : UITableViewCell

@property(nonatomic, strong) ImageScrollView *imageScrollView;
@property(nonatomic, strong) NSArray *imageArr;/**< 图片URL */

-(void)setImageArray:(NSArray *)imageArray;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
