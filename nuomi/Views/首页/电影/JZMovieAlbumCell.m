//
//  JZAlbumCell.m
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMovieAlbumCell.h"
#import "UIImageView+WebCache.h"
#import "JZMovieCardModel.h"

@interface JZMovieAlbumCell ()
{
    UIScrollView *_scrollView;
}

@end

@implementation JZMovieAlbumCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        //添加图片
        for (int i = 0; i < 10; ++i) {
            CGFloat width = 85;
            CGFloat height = 120;
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((width+5)*i, 0, width, frame.size.height)];
            backView.tag = 80+i;
            backView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            [backView addGestureRecognizer:tap];
            [_scrollView addSubview:backView];
            
            
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((screen_width*2/5+5)*i, 5, screen_width*2/5, frame.size.height-10)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, width, height)];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 5;
//            [imageView setImage:[UIImage imageNamed:@"lesson_default"]];
            imageView.tag = i+20;
            [backView addSubview:imageView];
            
            //电影名
            UILabel *movieNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView.frame), width, 25)];
            movieNameLabel.tag = i+40;
            movieNameLabel.font = [UIFont systemFontOfSize:13];
            [backView addSubview:movieNameLabel];
            //分数
            UILabel *movieScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(movieNameLabel.frame), width, 25)];
            movieScoreLabel.tag = i+60;
            movieScoreLabel.font = [UIFont systemFontOfSize:13];
            movieScoreLabel.textColor = navigationBarColor;
            [backView addSubview:movieScoreLabel];
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

-(void)setImgurlArray:(NSArray *)imgurlArray{
    CGFloat width = 85;
    if (imgurlArray.count>10) {
        _scrollView.contentSize = CGSizeMake((width+5)*10+5, _scrollView.frame.size.height);
    }else{
        _scrollView.contentSize = CGSizeMake((width+5)*imgurlArray.count+5, _scrollView.frame.size.height);
    }
    for (int i = 0; i < imgurlArray.count; i++) {
        if (i == 10) {
            return;
        }
        UIImageView *imageView = (UIImageView *)[_scrollView viewWithTag:20+i];
        UILabel *movieNameLabel = (UILabel *)[_scrollView viewWithTag:40+i];
        UILabel *movieScoreLabel = (UILabel *)[_scrollView viewWithTag:60+i];
        
        JZMovieCardResultModel *resultM = imgurlArray[i];
        NSString *urlStr = [resultM.posterUrl objectForKey:@"small"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"lesson_default"]];
        
        movieNameLabel.text = resultM.name;
        movieScoreLabel.text = [NSString stringWithFormat:@"%.1f",[resultM.score integerValue]/10.0];
    }
}

-(void)OnTapImage:(UITapGestureRecognizer *)sender{
    UIImageView *imageView = (UIImageView *)sender.view;
    int tag = (int)imageView.tag-80;
    [self.delegate didSelectedAlbumAtIndex:tag];
}


@end
