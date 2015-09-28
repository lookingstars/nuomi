//
//  JZAlbumCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAlbumCell.h"
#import "UIImageView+WebCache.h"

@interface JZAlbumCell ()
{
    UIScrollView *_scrollView;
}

@end

@implementation JZAlbumCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        //添加图片
        for (int i = 0; i < 10; ++i) {
            CGFloat width = screen_width*2/7;
            //
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((screen_width*2/7+5)*i, 0, width, frame.size.height)];
            backView.tag = 80+i;
            backView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            [backView addGestureRecognizer:tap];
            [_scrollView addSubview:backView];
            
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-25, 5, 50, 50)];
            imageView.tag = i+20;
            [backView addSubview:imageView];
            
            //大标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2+5, width, 25)];
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.tag = 40+i;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = RGB(34, 34, 34);
            [backView addSubview:titleLabel];
            
            //小标题
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2+5+25, width, 25)];
            subtitleLabel.font = [UIFont systemFontOfSize:13];
            subtitleLabel.tag = 60 + i;
            subtitleLabel.textAlignment = NSTextAlignmentCenter;
            subtitleLabel.textColor = RGB(100, 100, 100);
            [backView addSubview:subtitleLabel];
        }
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSpecialArray:(NSArray *)specialArray {
    CGFloat width = screen_width*2/7;
    _scrollView.contentSize = CGSizeMake((width+5)*specialArray.count+5, _scrollView.frame.size.height);
    for (int i = 0; i < specialArray.count; i++) {
        if (i == 10) {
            return;
        }
        UIImageView *imageView = (UIImageView *)[_scrollView viewWithTag:20+i];
        UILabel *titleLabel = (UILabel *)[_scrollView viewWithTag:40+i];
        UILabel *subtitleLabel = (UILabel *)[_scrollView viewWithTag:60+i];
        
        NSString *imgStr = [specialArray[i] objectForKey:@"picture_url"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
        titleLabel.text = [specialArray[i] objectForKey:@"adv_title"];
        subtitleLabel.text = [specialArray[i] objectForKey:@"adv_subtitle"];
    }
}

-(void)OnTapImage:(UITapGestureRecognizer *)sender{
    UIView *backView = (UIView *)sender.view;
    int tag = (int)backView.tag-80;
    [self.delegate didSelectedAlbumAtIndex:tag];
}


@end
