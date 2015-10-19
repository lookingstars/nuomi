//
//  JZAnimationTestViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/13.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAnimationTestViewController.h"
#import "JZNetworkSingleton.h"

#define WIDTH 50
#define PHOTO_HEIGHT 150

@interface JZAnimationTestViewController ()

@end

@implementation JZAnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = RGB(239, 239, 239);
    [self drawImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入8位动态密码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil, nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    alertView.delegate = self;
    alertView.tag = 10;
    [alertView show];
}

//绘图
-(void)drawImage{
    //阴影图层
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layerShadow.position = CGPointMake(160, 200);
    layerShadow.cornerRadius = PHOTO_HEIGHT/2;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = 2;
//    [self.view.layer addSublayer:layerShadow];
    
    //自定义图层
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position = CGPointMake(160, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = PHOTO_HEIGHT/2;
    //图层设置圆角，必须
    layer.masksToBounds = YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 2;
    
    //1.
    //利用图层形变解决图像倒立问题
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    layer.delegate = self;
    
    //2.使用contents
    UIImage *image = [UIImage imageNamed:@"detailViewDefaultMidImage"];
    [layer setContents:(id)image.CGImage];
    [self.view.layer addSublayer:layer];
    
    
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"%@",layer);
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立问题
//    CGContextScaleCTM(ctx, 1, -1);
//    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    
    UIImage *image = [UIImage imageNamed:@"detailViewDefaultMidImage"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    
    
    CGContextRestoreGState(ctx);
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
