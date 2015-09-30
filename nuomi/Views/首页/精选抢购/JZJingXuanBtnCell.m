//
//  JZJingXuanBtnCell.m
//  nuomi
//
//  Created by jinzelu on 15/9/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZJingXuanBtnCell.h"

@implementation JZJingXuanBtnCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)OnSegBtn:(UIButton *)sender {
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:10+i];
        btn.selected = NO;
    }
    sender.selected = YES;
}



@end
