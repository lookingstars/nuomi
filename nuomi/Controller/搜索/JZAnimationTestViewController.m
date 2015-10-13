//
//  JZAnimationTestViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAnimationTestViewController.h"

#define WIDTH 50

@interface JZAnimationTestViewController ()

@end

@implementation JZAnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawMyLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//绘制图层
-(void)drawMyLayer{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //获得跟图层
    CALayer *layer = [[CALayer alloc] init];
    layer.hidden = NO;
    //设置颜色
    layer.backgroundColor = navigationBarColor.CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2);
    //设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    //设置圆角
    layer.cornerRadius = WIDTH/2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    //设置边框
    layer.borderColor = [UIColor greenColor].CGColor;
    layer.borderWidth = 1;
    //设置锚点
//    layer.anchorPoint = CGPointZero;
    [self.view.layer addSublayer:layer];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];    
    CALayer *layer=[self.view.layer.sublayers lastObject];
    CGFloat width=layer.bounds.size.width;
    if (width==WIDTH) {
        width=WIDTH*4;
    }else{
        width=WIDTH;
    }
    layer.bounds=CGRectMake(0, 0, width, width);
    layer.position=[touch locationInView:self.view];
    layer.cornerRadius=width/2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
