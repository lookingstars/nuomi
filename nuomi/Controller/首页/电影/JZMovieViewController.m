//
//  JZMovieViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/19.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZMovieViewController.h"
#import "JZNetworkSingleton.h"
#import "JZMovieItemCell.h"
#import "JZMovieItemModel.h"
#import "ImageScrollCell.h"
#import "JZWebViewController.h"
#import "JZMovieAlbumCell.h"
#import "JZMovieCardModel.h"
#import "MJRefresh.h"
#import "JZNuomiHeader.h"

@interface JZMovieViewController ()<UITableViewDataSource,UITableViewDelegate,ImageScrollViewDelegate,JZMovieAlbumDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//附近的电影院数组
@property (nonatomic, strong) NSMutableArray *movieResultArr;
//广告数组
@property (nonatomic, strong) NSMutableArray *adListArray;
//最新电影数组
@property (nonatomic, strong) NSMutableArray *movieListArray;

@property (nonatomic, strong) JZMovieItemModel *movieItemM;

@end

@implementation JZMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self initData];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _movieResultArr = [[NSMutableArray alloc] init];
    _adListArray = [[NSMutableArray alloc] init];
    _movieListArray = [[NSMutableArray alloc] init];
}

//MJRefresh下拉刷新，跟上一个版本比，有的方法变了，具体用发要参考源码
-(void)setUpTableView{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    //    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header = [JZNuomiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
}

-(void)loadNewData{
    [self getMovieItemData];
}

/**< 获取最新电影 */
-(void)getMovieData{
    NSString *url = @"http://movieapp.baidu.com/na/app/dispatcher?mockup=0";
    NSString *jsonStr = @"{\"api\":1001,\"version\":\"1.0.0.1\",\"user\":{\"bduss\":\"\",\"cuid\":\"11a2e62839f7bed05437dcb826be61a0c47a515c\"},\"data\":\"\",\"timestamp\":1444973950244,\"channel\":\"nuomi\",\"client\":\"na\",\"osName\":\"ios\",\"osVersion\":8.2,\"experimentIds\":[],\"subChannel\":\"com_dot_apple|portal\",\"sign\":\"254fb40aa3cf9c71190da1e7451e84f5\"}";
    NSDictionary *userInfo = [self dictionaryWithJsonString:jsonStr];
    NSString *dataStr = @"{\"cityId\":\"100010000\"}";
    [userInfo setValue:dataStr forKey:@"data"];
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZMovieCardModel";
    
    __weak typeof(self) weakself = self;
    
    [request postDataWithURL:url params:userInfo success:^(OPDataResponse *responseObject) {
        NSLog(@"获取 最新电影 成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        JZMovieCardModel *movieCardM = responseObject.data;
        if (movieCardM == nil) {
            return ;
        }
        _movieListArray = [NSMutableArray arrayWithArray:movieCardM.result];
        [weakself.tableView reloadData];
        [weakself.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"获取 最新电影 失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

/**< 获取附近电影城列表 */
-(void)getMovieItemData{
    NSString *url = @"http://movieapp.baidu.com/na/app/dispatcher?mockup=0";
    NSString *jsonStr = @"{\"api\": 1002,\"version\": \"1.0.0.1\",\"user\": {\"bduss\": \"\",\"cuid\": \"11a2e62839f7bed05437dcb826be61a0c47a515c\"},\"data\":\"\",\"timestamp\": 1444973393402,\"channel\": \"nuomi\",\"client\": \"na\",\"osName\": \"ios\",\"osVersion\": 8.2,\"experimentIds\": [],\"subChannel\": \"com_dot_apple|portal\",\"sign\": \"c0dd29691c143d899a13b2a6892556ad\"}";
    NSDictionary *userInfo = [self dictionaryWithJsonString:jsonStr];
    NSString *dataStr = @"{\"cityId\":\"100010000\",\"longitude\":116.31968,\"latitude\":39.98884,\"pageSize\":10,\"pageNum\":0,\"brandId\":\"\"}";
    [userInfo setValue:dataStr forKey:@"data"];
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZMovieItemModel";
    __weak typeof(self) weakself = self;
    [request postDataWithURL:url params:userInfo success:^(OPDataResponse *responseObject) {
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        _movieItemM = responseObject.data;
        if (_movieItemM ==nil) {
            return ;
        }
        _movieResultArr = [NSMutableArray arrayWithArray:_movieItemM.result];
        if (_movieItemM.adBar != nil) {
            _adListArray = [NSMutableArray arrayWithArray:[_movieItemM.adBar objectForKey:@"list"]];
        }
        [weakself getMovieData];
        NSLog(@"获取 附近电影城 成功");
    } failure:^(NSError *error) {
        NSLog(@"获取 附近电影城 失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr{
    if (jsonStr == nil) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - **************** UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_movieResultArr.count == 0) {
        return 0;
    }
    return _movieResultArr.count+2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else if (indexPath.row == 1){
        return 180;
    }else{
        return 100;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"courseCell0";
        ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[ImageScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 80)];
        }
        cell.imageScrollView.delegate = self;
        [cell setImageArr:_adListArray];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellIndentifier = @"courseCell1";
        JZMovieAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[JZMovieAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 180)];
            //下划线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 179.5, screen_width, 0.5)];
            lineView.backgroundColor = separaterColor;
            [cell addSubview:lineView];
        }
        
        cell.delegate = self;
        [cell setImgurlArray:_movieListArray];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"JZMovieItemCell";
        JZMovieItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        JZMovieResultModel *resultM = _movieResultArr[indexPath.row-2];
        [cell setResuleM:resultM];
        return cell;
    }
}

#pragma mark - **************** UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - **************** ImageScrollViewDelegate
-(void)didSelectImageAtIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
    
    NSString *plainUrl = [_adListArray[index] objectForKey:@"plainUrl"];
    NSLog(@"plainUrl:%@",plainUrl);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JZWebViewController *VC = [sb instantiateViewControllerWithIdentifier:@"JZWebViewController"];
    VC.url = plainUrl;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - **************** JZMovieAlbumDelegate
-(void)didSelectedAlbumAtIndex:(NSInteger)index{
    NSLog(@"AlbumIndex:%ld",index);
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
