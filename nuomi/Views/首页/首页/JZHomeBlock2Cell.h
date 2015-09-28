//
//  JZHomeBlock2Cell.h
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JZHomeBlock2Delegate <NSObject>

@optional
-(void)didSelectedHomeBlock2AtIndex:(NSInteger)index;

@end

@interface JZHomeBlock2Cell : UITableViewCell

@property (nonatomic, assign) id<JZHomeBlock2Delegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array;


+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array;
@end
