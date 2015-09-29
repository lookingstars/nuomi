//
//  HomeMenuCell.m
//  meituan
//
//  Created by jinzelu on 15/6/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "HomeMenuCell.h"
#import "JZHomepageModel.h"

@interface HomeMenuCell ()<UIScrollViewDelegate>
{
    UIView *_backView1;
    UIView *_backView2;
    UIPageControl *_pageControl;
}

@end

@implementation HomeMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
        _backView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180)];
        scrollView.contentSize = CGSizeMake(2*screen_width, 180);
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        [scrollView addSubview:_backView1];
        [scrollView addSubview:_backView2];
        [self addSubview:scrollView];
        
        
        
        //创建8个
        for (int i = 0; i < 20; i++) {
            JZHomecategoryModel *categoryM = menuArray[i];
            if (i < 5) {
                CGRect frame = CGRectMake(i*screen_width/5, 0, screen_width/5, 80);
                NSString *title = categoryM.category_name;
//                NSString *imageStr = categoryM.category_picurl;
                NSString *imageStr = @"icon_homepage_entertainmentCategory";

                JZMenuButton *btnView = [[JZMenuButton alloc] initWithFrame:frame];
                [btnView setTitle:title forState:UIControlStateNormal];
                [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnView setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else if(i<10){
                CGRect frame = CGRectMake((i-5)*screen_width/5, 80, screen_width/5, 80);
                NSString *title = categoryM.category_name;
//                NSString *imageStr = categoryM.category_picurl;
                NSString *imageStr = @"icon_homepage_entertainmentCategory";
                
                JZMenuButton *btnView = [[JZMenuButton alloc] initWithFrame:frame];
                [btnView setTitle:title forState:UIControlStateNormal];
                [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnView setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else if(i < 15){
                CGRect frame = CGRectMake((i-10)*screen_width/5, 0, screen_width/5, 80);
                NSString *title = categoryM.category_name;
//                NSString *imageStr = categoryM.category_picurl;
                NSString *imageStr = @"icon_homepage_entertainmentCategory";
                
                JZMenuButton *btnView = [[JZMenuButton alloc] initWithFrame:frame];
                [btnView setTitle:title forState:UIControlStateNormal];
                [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnView setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else{
                CGRect frame = CGRectMake((i-15)*screen_width/5, 80, screen_width/5, 80);
                NSString *title = categoryM.category_name;
//                NSString *imageStr = categoryM.category_picurl;
                NSString *imageStr = @"icon_homepage_entertainmentCategory";
                
                JZMenuButton *btnView = [[JZMenuButton alloc] initWithFrame:frame];
                [btnView setTitle:title forState:UIControlStateNormal];
                [btnView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btnView setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
//                JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_backView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }
        }
        
        //
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_width/2-20, 160, 0, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
//        self.backgroundColor = [UIColor redColor];
        [self addSubview:_pageControl];
        [_pageControl setCurrentPageIndicatorTintColor:navigationBarColor];
        [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        
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

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}


@end
