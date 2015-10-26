//
//  JZBaseTabBarViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZBaseTabBarViewController.h"
#import "JZNetworkSingleton.h"

@interface JZBaseTabBarViewController ()

@end

@implementation JZBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAdvView];
    [self initTabBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initAdvView{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];
    NSLog(@"filePath:  %@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isExit = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (isExit) {
        NSLog(@"存在");
        _advImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        [_advImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        [self.view addSubview:_advImage];
        [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //加载启动广告并保存到本地沙盒，因为保存的图片较大，每次运行都要保存，所以注掉了
            [self getLoadingImage];
        });
    }else{
        NSLog(@"不存在");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getLoadingImage];
        });
    }
}

-(void)getLoadingImage{
    NSString *urlStr = @"http://app.nuomi.com/naserver/item/splashpage?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=40c974d176568886ad0e72516645e23f&swidth=750&terminal_type=ios&timestamp=1442906717563&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    
    [request getDataWithURL:urlStr params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"加载 启动页广告 成功");
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSDictionary *dic = [responseDic objectForKey:@"data"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (dic) {
                NSString *picUrl = [dic objectForKey:@"pic_url"];
                if ([picUrl isEqualToString:@""]) {
                    NSLog(@"pic_url:%@",picUrl);
                }else{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    
                    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"loading.png"]];   // 保存文件的名称
                    //    BOOL result = [UIImagePNGRepresentation() writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
                    NSLog(@"paths:%@    %@",paths,filePath);
                    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
                }
            }
        });
        
    } failure:^(NSError *error) {
        NSLog(@"加载 启动页广告 失败");
    }];
}

-(void)removeAdvImage{
    NSLog(@"removeAdvImage");
    [UIView animateWithDuration:0.3f animations:^{
        _advImage.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _advImage.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_advImage removeFromSuperview];
    }];
}

- (void)initTabBarItem {
    UITabBar *tabbar = self.tabBar;
//    self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:3];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:4];
    
    item0.selectedImage = [[UIImage imageNamed:@"icon_tab_shouye_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.image = [[UIImage imageNamed:@"icon_tab_shouye_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"icon_tab_fujin_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tab_fujin_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"tabbar_voice_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"tabbar_voice_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//注意这里的两个值
    
    item3.selectedImage = [[UIImage imageNamed:@"tab_icon_selection_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"tab_icon_selection_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"icon_tab_wode_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tab_wode_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navigationBarColor,UITextAttributeTextColor, nil] forState:UIControlStateSelected];
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
