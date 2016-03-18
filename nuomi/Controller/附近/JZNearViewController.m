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
#import "JSDropDownMenu.h"

@interface JZNearViewController ()<UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    NSInteger _currentData1SelectedIndex;
    JSDropDownMenu *menu;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JZNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self setUpTableView];
    [self initDropMenu];
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
    [self getNearItemData];
}

//下拉Menu
//使用的是第三方GitHub开源项目：https://github.com/jsfu/JSDropDownMenu
-(void)initDropMenu{
    // 指定默认选中
    _currentData1Index = 1;
    _currentData1SelectedIndex = 1;
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, nil];
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"3~4人餐", nil];
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
}

-(void)getNearItemData{
    NSString *url = @"http://112.80.255.88/naserver/search/nearitem?appid=ios&auto_broaden=1&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&distance=0%2C3000&fst_cattag_id=0&goods_per_page=15&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324500&logpage=NearList&net=wifi&os=8.2&page_idx=0&poi_per_page=10&priceRange=&sheight=1334&sign=959f3502d7f990f2907209da21b3d595&sort_type=5&swidth=750&terminal_type=ios&timestamp=1444460141952&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZNearItemModel";
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 附近数据 成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        if (responseObject.code == 0) {
            JZNearItemModel *nearItemM = responseObject.data;
            _dataSource = [[NSMutableArray alloc] initWithArray:nearItemM.poi_list];
            
            
            [weakself.tableView reloadData];
        }else{
            NSLog(@"%@",responseObject.msg);
        }
        [weakself.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"请求 附近数据 失败");
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}


#pragma mark - **************** UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource.count == 0) {
        return 0;
    }
    JZPoiListModel *poiListM = _dataSource[section];
    return poiListM.tuan_list.count+1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZPoiListModel *poiListM = _dataSource[indexPath.section];
    if (indexPath.row == poiListM.tuan_list.count) {
        return 10;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JZPoiListModel *poiListM = _dataSource[section];
    NSLog(@"");
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, screen_width, 1)];
    lineView.backgroundColor = RGB(239, 239, 239);
    [headerView addSubview:lineView];
    //店名
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 25)];
    [headerView addSubview:shopNameLabel];
    //分数
    UILabel *shopScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 60, 20)];
    shopScoreLabel.font = [UIFont systemFontOfSize:13];
    shopScoreLabel.textColor = RGB(254, 208, 55);
    [headerView addSubview:shopScoreLabel];
    //评价
    UILabel *shopUserNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shopScoreLabel.frame)+10, 35, 90, 20)];
    shopUserNumLabel.font = [UIFont systemFontOfSize:13];
    shopUserNumLabel.textColor = [UIColor lightGrayColor];
    [headerView addSubview:shopUserNumLabel];
    //距离
    UILabel *shopDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-140, 35, 130, 20)];
    shopDistanceLabel.textColor = [UIColor lightGrayColor];
    shopDistanceLabel.font = [UIFont systemFontOfSize:13];
    shopDistanceLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:shopDistanceLabel];
    
    
    
    //辅助
    shopNameLabel.text = poiListM.poi_name;
    shopDistanceLabel.text = [NSString stringWithFormat:@"%@ %@",poiListM.bizarea_title,poiListM.poi_distance];
    if (poiListM.ugc == nil) {
        shopScoreLabel.text = @"暂无评分";
    }else{
        shopUserNumLabel.text = [NSString stringWithFormat:@"%@人评价",[poiListM.ugc objectForKey:@"user_num"]];
        shopScoreLabel.text = [NSString stringWithFormat:@"%@分",[poiListM.ugc objectForKey:@"average_score"]];
    }
    
    
    return headerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZPoiListModel *poiM = _dataSource[indexPath.section];
    if (indexPath.row == poiM.tuan_list.count) {
        static NSString *cellIndentifier = @"footerCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//        }
        
        
        return cell;
    }else{
        
    }
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



//下拉Menu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return [[_data1[_currentData1Index] objectForKey:@"data"] objectAtIndex:_currentData1SelectedIndex];
            break;
        case 1: return _data2[_currentData2Index];
            break;
        case 2: return _data3[_currentData3Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
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
