//
//  JZShopViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZShopViewController.h"
#import "JZNetworkSingleton.h"

#import "JZShopDetailModel.h"
#import "JZShopCommentModel.h"
#import "JZShopRelatedModel.h"

#import "JZShopPriceCell.h"


@interface JZShopViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *headView;


@property (nonatomic, strong) JZShopDetailModel *shopDetailM;
@property (nonatomic, strong) JZShopCommentModel *shopCommentM;
@property (nonatomic, strong) JZShopRelatedModel *shopRelatedM;

@end

@implementation JZShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestItemDetail];
    [self requestComment];
    [self requestRelatedData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestItemDetail {
    NSString *url = @"http://180.97.34.118/naserver/item/ItemDetailNew?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&deal_id=5039138&dealdetailOptimize=0&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=e299e2ee41f75828f1a1ab81dcd9f3c6&swidth=750&terminal_type=ios&timestamp=1443426373122&tn=ios&user_distance=&user_distance_status=&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopDetailModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 店铺详情 成功");
        _shopDetailM = responseObject.data;
        
        NSString *imgStr = [_shopDetailM.title_about.image firstObject];
        imgStr = [NSString convertImgStr:imgStr];
        [weakself.headView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"account_place_holder"]];
        
        
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 店铺详情 失败");
    }];
}

-(void)requestComment {
    NSString *url = @"http://180.97.34.118/naserver/ugc/brief?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&commentNum=3&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=c23270ebce924778f5a226655b2e578e&swidth=750&terminal_type=ios&timestamp=1443426373130&tinyPicHeight=180&tinyPicWidth=180&tn=ios&tuanId=5039138&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopCommentModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 评论 成功");
        _shopCommentM = responseObject.data;
        
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 评论 失败");
    }];
}

-(void)requestRelatedData {
    NSString *url = @"http://180.97.34.118/naserver/item/ItemRelatedSearch?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&deal_id=5039138&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=34636751140f178be81ef21b5b64292d&swidth=750&terminal_type=ios&timestamp=1443426373126&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopRelatedModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 热门推荐 成功");
        _shopRelatedM = responseObject.data;
        
        
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 热门推荐 失败");
    }];
}

-(void)reloadData{
    if (_shopDetailM != nil && _shopCommentM != nil && _shopRelatedM != nil) {
        [self.tableView reloadData];
    }
}


#pragma mark - **************** UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_shopDetailM == nil || _shopCommentM == nil || _shopRelatedM == nil) {
        return 0;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        return 60;
    }else{
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"shopPriceCell";
        JZShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIdentifier = @"shopPriceCell";
        JZShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"shopPriceCell";
        JZShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        return cell;
    }
}

#pragma mark - **************** UITableViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
