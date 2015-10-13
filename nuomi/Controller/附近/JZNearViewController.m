//
//  JZNearViewController.m
//  nuomi
//
//  Created by jinzelu on 15/10/10.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZNearViewController.h"
#import "JZNetworkSingleton.h"
#import "JZNearItemModel.h"
#import "JZNearItemCell.h"

@interface JZNearViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JZNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self getNearItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    _dataSource = [[NSMutableArray alloc] init];
}

-(void)getNearItemData{
    NSString *url = @"http://112.80.255.88/naserver/search/nearitem?appid=ios&auto_broaden=1&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&distance=0%2C3000&fst_cattag_id=0&goods_per_page=15&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324500&logpage=NearList&net=wifi&os=8.2&page_idx=0&poi_per_page=10&priceRange=&sheight=1334&sign=959f3502d7f990f2907209da21b3d595&sort_type=5&swidth=750&terminal_type=ios&timestamp=1444460141952&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZNearItemModel";
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 附近数据 成功");
        if (responseObject.code == 0) {
            JZNearItemModel *nearItemM = responseObject.data;
            _dataSource = [[NSMutableArray alloc] initWithArray:nearItemM.poi_list];
            
            
            [weakself.tableView reloadData];
        }else{
            NSLog(@"%@",responseObject.msg);
        }
    } failure:^(NSError *error) {
        NSLog(@"请求 附近数据 失败");
        NSLog(@"%@",error);
    }];
}


#pragma mark - **************** UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count == 0) {
        return 0;
    }
    JZPoiListModel *poiListM = _dataSource[section];
    return poiListM.tuan_list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    headerView.backgroundColor = [UIColor blueColor];
    return headerView;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
//    footerView.backgroundColor = RGB(240, 240, 240);
//    return footerView;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"NearItemCell";
    JZNearItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (_dataSource.count>0) {
        JZPoiListModel *poiM = _dataSource[indexPath.section];
        JZNearTuanListModel *tuanListM = poiM.tuan_list[indexPath.row];
        [cell setTuanListM:tuanListM];
    }
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
