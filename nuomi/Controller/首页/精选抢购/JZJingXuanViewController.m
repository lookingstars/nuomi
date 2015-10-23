//
//  JZJingXuanViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/28.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZJingXuanViewController.h"
#import "JZNetworkSingleton.h"
#import "JZJingXuanVIPCell.h"
#import "JZJingXuanBtnCell.h"
#import "JZJingXuanShopCell.h"
#import "JZJingXuanModel.h"
#import "JZNuomiHeader.h"

@interface JZJingXuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) JZJingXuanModel *jingxuanM;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JZJingXuanViewController

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
    _dataSource = [[NSMutableArray alloc] init];
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
    [self requestData];
}

-(void)requestData{
    NSString *url = @"http://t10.nuomi.com/webapp/na/toptenajax?from=fr_na_t10&tid=t_home_na&bn_v=5.13.0&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&location=39.98942%2C116.32452&areaId=100010000&pn=0&pageSize=20&bduss=&comppage=index&needstorecard=1&compid=t10brand";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZJingXuanModel";
    
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 数据成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [self.tableView.header endRefreshing];
            return ;
        }
        _jingxuanM = responseObject.data;
        if (_jingxuanM) {
            _dataSource = [NSMutableArray arrayWithArray:_jingxuanM.list];
        }
        
        [weakself.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"请求 数据失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [self.tableView.header endRefreshing];
    }];
}


#pragma mark - **************** UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_jingxuanM) {
        return 2+_dataSource.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 37;
    }else{
        return 92;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"JingXuanVIPCell";
        JZJingXuanVIPCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"JingXuanBtnCell";
        JZJingXuanBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"JingXuanShopCell";
        JZJingXuanShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        JZJingXuanListModel *listM = _dataSource[indexPath.row - 2];
        [cell setListM:listM];
        
        
        return cell;
    }
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
