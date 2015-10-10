//
//  JZNearViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/10.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZNearViewController.h"
#import "JZNetworkSingleton.h"

@interface JZNearViewController ()

@end

@implementation JZNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getNearItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getNearItemData{
    NSString *url = @"http://112.80.255.88/naserver/search/nearitem?appid=ios&auto_broaden=1&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&distance=0%2C3000&fst_cattag_id=0&goods_per_page=15&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324500&logpage=NearList&net=wifi&os=8.2&page_idx=0&poi_per_page=10&priceRange=&sheight=1334&sign=959f3502d7f990f2907209da21b3d595&sort_type=5&swidth=750&terminal_type=ios&timestamp=1444460141952&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 附近数据 成功");
    } failure:^(NSError *error) {
        NSLog(@"请求 附近数据 失败");
    }];
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
