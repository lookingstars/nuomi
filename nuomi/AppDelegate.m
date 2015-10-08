//
//  AppDelegate.m
//  nuomi
//
//  Created by jinzelu on 15/9/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "JZNetworkSingleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//初始化友盟
- (void)initMob {
    
    //友盟统计
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:@"GitHub"];
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
        [self.window addSubview:_advImage];
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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window.hidden = NO;
    [self initMob];
    [self initAdvView];
    
    
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setTintColor:RGB(252, 74, 132)];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = navigationBarColor;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
