//
//  JZHomeViewController.m
//  nuomi
//
//  Created by jinzelu on 15/9/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZHomeViewController.h"
#import "JZHomeShopCell.h"
#import "JZHomeNewCell.h"
#import "JZHomeJingxuanCell.h"

#import "JZNetworkSingleton.h"
#import "JZHomeShopModel.h"
#import "JZHomepageModel.h"

@interface JZHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;




/**
 *  猜你喜欢数据源
 */
@property (nonatomic, strong) NSMutableArray *likeArray;

@property (nonatomic, strong) JZHomepageModel *homepageM;


@property (nonatomic, strong) NSMutableArray *bannersArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) NSMutableArray *recommendArray;
@property (nonatomic, strong) JZHomespecialModel *specialModel;
@property (nonatomic, strong) JZHometoptenModel *topenModel;



@end

@implementation JZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self getHotData];
    [self getRecommendData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData {
    self.likeArray = [[NSMutableArray alloc] init];
    
    self.bannersArray = [[NSMutableArray alloc] init];
    self.categoryArray = [[NSMutableArray alloc] init];
    self.recommendArray = [[NSMutableArray alloc] init];
}

- (IBAction)OnSaoyisaoBtn:(UIButton *)sender {
    NSLog(@"扫一扫");
}

- (IBAction)OnGouwucheBtn:(UIButton *)sender {
    NSLog(@"购物车");
}

- (IBAction)OnMoreCityBtn:(id)sender {
    NSLog(@"选择城市");
}

//获取数据
-(void)getHotData {
    NSString *url = @"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=40c974d176568886ad0e72516645e23f&swidth=750&terminal_type=ios&timestamp=1442906717563&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton sharedManager];
    request.classModel = @"JZHomepageModel";
    
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"获取 首页 数据成功");
        _homepageM = responseObject.data;
        
        _bannersArray = [[NSMutableArray alloc] initWithArray:_homepageM.banners];
        _categoryArray = [[NSMutableArray alloc] initWithArray:_homepageM.category];
        _recommendArray = [[NSMutableArray alloc] initWithArray:_homepageM.recommend];
        _specialModel = _homepageM.special;
        _topenModel = _homepageM.topten;
        
//        [weakself.tableView reloadData];
        NSLog(@"special===:   %@",_homepageM.special);
        NSLog(@"topten===:   %@",_homepageM.topten);
    } failure:^(NSError *error) {
        NSLog(@"获取 首页 数据失败");
    }];
}

//获取猜你喜欢数据
-(void)getRecommendData {
    
    NSString *url = @"http://app.nuomi.com/naserver/search/likeitem?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=faf73b65333f52c39dbe7f9e1a3ec04c&sort_type=0&swidth=750&terminal_type=ios&timestamp=1442906717567&tn=ios&tuan_size=25&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton sharedManager];
    request.classModel = @"JZHomeShopModel";
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject){
        NSLog(@"获取 猜你喜欢 数据成功");
        if (responseObject.code == 0) {
            JZHomeShopModel *homeShopM = responseObject.data;
            _likeArray = homeShopM.tuan_list;
            [weakself.tableView reloadData];
        }else{
            
        }
    } failure:^(NSError *error){
        NSLog(@"获取 猜你喜欢 数据失败");
    }];
}

#pragma mark - **************** UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_homepageM != nil) {
        NSInteger num = 5;
        if (_likeArray.count>0) {
            num = 1+_likeArray.count;
        }
        return num;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 184;
    }else if(indexPath.row == 1){
        return 172;
    }else if (indexPath.row == 2){
        return 80;
    }else if (indexPath.row == 3){
        return 240;
    }else if (indexPath.row == 4){
        return 132;
    }else if (indexPath.row == 5){
        return 36;
    }else{
        return 96;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.textLabel.text = @"美食，电影";
        //赋值
        return cell;
    }else if(indexPath.row == 1){
        static NSString *cellIndentifier = @"JZHomeJingxuanCell";
        JZHomeJingxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (_topenModel) {
            [cell setListArray:_topenModel.list];
        }
        
        
        return cell;
    }else if (indexPath.row == 2){
        static NSString *cellIndentifier = @"JZHomeNewCell";
        JZHomeNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (_specialModel.block_1) {
            [cell setHomeNewDataDic:_specialModel.block_1];
        }
        //赋值
        return cell;
    }else if (indexPath.row == 3){
        static NSString *cellIndentifier = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.textLabel.text = @"块";
        //赋值
        return cell;
    }else if (indexPath.row == 4){
        static NSString *cellIndentifier = @"cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.textLabel.text = @"滑动";
        //赋值
        return cell;
    }else if (indexPath.row == 5){
        static NSString *cellIndentifier = @"normalCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        cell.textLabel.text = @"猜你喜欢";
        //赋值
        return cell;
    }else{
        static NSString *cellIndentifier = @"JZHomeShopCell";
        JZHomeShopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (_likeArray.count>0) {
            JZShopTuanModel *shopM = _likeArray[indexPath.row - 3];
            [cell setShopM:shopM];
        }
        //赋值
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
