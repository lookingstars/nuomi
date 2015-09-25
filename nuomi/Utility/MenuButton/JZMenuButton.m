//
//  JZMenuButton.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMenuButton.h"

@implementation JZMenuButton


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.8;
    self.imageView.frame = CGRectMake(0, 0, imageW, imageH);
    
    CGFloat labelH = self.bounds.size.height - imageH;
    self.titleLabel.frame = CGRectMake(0, imageH, imageW, labelH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
