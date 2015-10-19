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

@interface JZMovieViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *movieResultArr;

@property (nonatomic, strong) JZMovieItemModel *movieItemM;

@end

@implementation JZMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    [self initData];
    
    [self getMovieItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _movieResultArr = [[NSMutableArray alloc] init];
}

/**< 获取最新电影 */
-(void)getMovieData{
    NSString *url = @"http://movieapp.baidu.com/na/app/dispatcher?mockup=0";
    NSString *jsonStr = @"{\"api\":1001,\"version\":\"1.0.0.1\",\"user\":{\"bduss\":\"\",\"cuid\":\"11a2e62839f7bed05437dcb826be61a0c47a515c\"},\"data\":\"\",\"timestamp\":1444973950244,\"channel\":\"nuomi\",\"client\":\"na\",\"osName\":\"ios\",\"osVersion\":8.2,\"experimentIds\":[],\"subChannel\":\"com_dot_apple|portal\",\"sign\":\"254fb40aa3cf9c71190da1e7451e84f5\"}";
    NSDictionary *userInfo = [self dictionaryWithJsonString:jsonStr];
    NSString *dataStr = @"{\"cityId\":\"100010000\"}";
    [userInfo setValue:dataStr forKey:@"data"];
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    __weak typeof(self) weakself = self;
    
    [request postDataWithURL:url params:userInfo success:^(OPDataResponse *responseObject) {
        NSLog(@"获取 最新电影 成功");
        
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"获取 最新电影 失败");
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
        
        _movieItemM = responseObject.data;
        if (_movieItemM !=nil) {
            _movieResultArr = [NSMutableArray arrayWithArray:_movieItemM.result];
        }
        
        [weakself getMovieData];
        NSLog(@"获取 附近电影城 成功");
    } failure:^(NSError *error) {
        NSLog(@"获取 附近电影城 失败");
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
    return _movieResultArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"JZMovieItemCell";    
    JZMovieItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    JZMovieResultModel *resultM = _movieResultArr[indexPath.row];
    [cell setResuleM:resultM];
    return cell;
}

#pragma mark - **************** UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
