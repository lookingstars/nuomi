//
//  JZHomeBlock2Cell.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeBlock2Cell.h"


@implementation JZHomeBlock2Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier array:(NSArray *)array{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = screen_width/2;
        CGFloat heigth = 80;

        for (int i = 0; i < array.count; i++) {
            NSInteger col = [[array[i] objectForKey:@"adv_col"] integerValue];//列
            NSInteger row = [[array[i] objectForKey:@"adv_row"] integerValue];//行
            NSInteger block_width = [[array[i] objectForKey:@"adv_block_width"] integerValue];//宽
            NSInteger block_height = [[array[i] objectForKey:@"adv_block_height"] integerValue];//高
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(width*(col-1), heigth*(row-1), width*block_width, heigth*block_height)];
            backView.tag = 100+i;
            
            backView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            [self addSubview:backView];
            backView.layer.borderWidth = 0.25;
            backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, width-60-10, 20)];
            titleLabel.tag = 20+i;
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textColor = [self randomColor];
            titleLabel.text = @"标题";
            [backView addSubview:titleLabel];
            //小标题
            UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, width-60-10, 20)];
            subtitleLabel.tag = 40+i;
            subtitleLabel.font = [UIFont systemFontOfSize:12];
            subtitleLabel.textColor = [self randomColor];
            subtitleLabel.text = @"小标题";
            [backView addSubview:subtitleLabel];
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 70, 10, 60, 60)];
            imageView.tag = 60+i;
            [backView addSubview:imageView];
            if (block_height == 2) {
                imageView.frame = CGRectMake(width/2-45, heigth*2-90, 90, 90);
            }
            
            
            titleLabel.text = [array[i] objectForKey:@"adv_title"];
            subtitleLabel.text = [array[i] objectForKey:@"adv_subtitle"];
            NSString *imgStr = [array[i] objectForKey:@"picture_url"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"ugc_photo"]];
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


-(UIColor *)randomColor{
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];//alpha为1.0,颜色完全不透明
}

+(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array {
    CGFloat width = screen_width/2;
    CGFloat heigth = 80;
    CGFloat cellHeight = 0;
    CGFloat maxHeight = 0;
    for (int i = 0; i < array.count; i++) {
        NSInteger col = [[array[i] objectForKey:@"adv_col"] integerValue];//列
        NSInteger row = [[array[i] objectForKey:@"adv_row"] integerValue];//行
        NSInteger block_width = [[array[i] objectForKey:@"adv_block_width"] integerValue];//宽
        NSInteger block_height = [[array[i] objectForKey:@"adv_block_height"] integerValue];//高
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(width*(col-1),heigth*(row-1), width*block_width, heigth*block_height)];
        cellHeight = CGRectGetMaxY(backView.frame);
        if (cellHeight > maxHeight) {
            maxHeight = cellHeight;
        }
        NSLog(@"backView:%@",backView);
    }
    
    return maxHeight;
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    UIView *backView = (UIView *)sender.view;
    int tag = (int)backView.tag-100;
    [self.delegate didSelectedHomeBlock2AtIndex:tag];
}

@end
