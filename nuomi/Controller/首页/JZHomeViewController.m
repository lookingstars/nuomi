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
#import "HomeMenuCell.h"
#import "JZAlbumCell.h"
#import "JZHomeBlock2Cell.h"
#import "JZTopicViewController.h"
#import "JZWebViewController.h"
#import "JZCityViewController.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "JZNuomiHeader.h"
#import "JZScanViewController.h"
//#import "ZBarSDK.h"
#include <objc/runtime.h>

@interface JZHomeViewController ()<UITableViewDataSource, UITableViewDelegate,JZAlbumDelegate,JZHomeBlock2Delegate,HomeMenuDelegate>

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
    [self setUpTableView];
    NSString *subStr = @"http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fzhongqiu_manfan%3Fallcity%3D1%26key%3De492d73e8fed3aeac8a9321c94b77932%26cuid%3D11a2e62839f7bed05437dcb826be61a0c47a515c&hasshare=0&shareurl=http%3A%2F%2Fhuodong.nuomi.com%2Factshow%2Fmobile%2Fcommon%2Fshort%2Fzhongqiu_manfan_wap%3Fallcity%3D1";
    subStr = [subStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"subStr :%@",subStr);
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideKeyboard)];
//    [self.view addGestureRecognizer:tap];
}

-(void)HideKeyboard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)initData {
    self.likeArray = [[NSMutableArray alloc] init];
    
    self.bannersArray = [[NSMutableArray alloc] init];
    self.categoryArray = [[NSMutableArray alloc] init];
    self.recommendArray = [[NSMutableArray alloc] init];
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
    [self getHotData];
    [self getRecommendData];
}

- (IBAction)OnSaoyisaoBtn:(UIButton *)sender {
    NSLog(@"扫一扫");
//    [self scan];
    JZScanViewController *scanVC = [[JZScanViewController alloc] init];
    [self presentViewController:scanVC animated:YES completion:nil];
    
}

//ZBarReaderViewController方法
-(void)scan{
//    ZBarReaderViewController *reader = [[ZBarReaderViewController alloc] init];
////    reader.readerDelegate = self;
//    [reader.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:0];
//    reader.readerView.zoom = 1.0;
//    
//    [self presentViewController:reader animated:YES completion:nil];
}


- (IBAction)OnGouwucheBtn:(UIButton *)sender {
    NSLog(@"购物车");
}

- (IBAction)OnMoreCityBtn:(id)sender {
    NSLog(@"选择城市");
    JZCityViewController *cityVC = [[JZCityViewController alloc] init];
    [self presentViewController: cityVC animated:YES completion:nil];
}

//获取数据
-(void)getHotData {
//    url内部添加有签名加密，所以只能把url写死，不能动态的改变url
    NSString *url = @"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=40c974d176568886ad0e72516645e23f&swidth=750&terminal_type=ios&timestamp=1442906717563&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZHomepageModel";
    
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"获取 首页 数据成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        _homepageM = responseObject.data;
        
        _bannersArray = [[NSMutableArray alloc] initWithArray:_homepageM.banners];
        _categoryArray = [[NSMutableArray alloc] initWithArray:_homepageM.category];
        _recommendArray = [[NSMutableArray alloc] initWithArray:_homepageM.recommend];
        _specialModel = _homepageM.special;
        _topenModel = _homepageM.topten;
        
        [weakself.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [weakself.tableView.header endRefreshing];
//        NSLog(@"special===:   %@",_homepageM.special);
//        NSLog(@"topten===:   %@",_homepageM.topten);
    } failure:^(NSError *error) {
        NSLog(@"获取 首页 数据失败");
        // 拿到当前的下拉刷新控件，结束刷新状态
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

//获取猜你喜欢数据
-(void)getRecommendData {
    
    NSString *url = @"http://app.nuomi.com/naserver/search/likeitem?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=faf73b65333f52c39dbe7f9e1a3ec04c&sort_type=0&swidth=750&terminal_type=ios&timestamp=1442906717567&tn=ios&tuan_size=25&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZHomeShopModel";
    __weak typeof(self) weakself = self;
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject){
        NSLog(@"获取 猜你喜欢 数据成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        if (responseObject.code == 0) {
            JZHomeShopModel *homeShopM = responseObject.data;
            _likeArray = homeShopM.tuan_list;
            [weakself.tableView reloadData];
            // 拿到当前的下拉刷新控件，结束刷新状态
            [weakself.tableView.header endRefreshing];
        }else{
            
        }
    } failure:^(NSError *error){
        NSLog(@"获取 猜你喜欢 数据失败");
        // 拿到当前的下拉刷新控件，结束刷新状态
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushTopicSegue"]) {
        JZTopicViewController *topicVC = segue.destinationViewController;
        NSString *cont = [_homepageM.special.block_1 objectForKey:@"cont"];
        topicVC.specialid = [NSString getSpecialId:cont];
        
    }
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
        if (_specialModel.block_2) {
            return [JZHomeBlock2Cell tableView:tableView heightForRowAtIndexPath:indexPath withArray:_specialModel.block_2];
        }else{
            return 5;
        }
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
        static NSString *cellIndentifier = @"menucell";
        HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier menuArray:_categoryArray];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 1){
        static NSString *cellIndentifier = @"JZHomeJingxuanCell";
        JZHomeJingxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (_topenModel) {
            [cell setListArray:_topenModel.list];
            [cell setActiveTimeArray:_topenModel.activetime];
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
        JZHomeBlock2Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            if (_specialModel.block_2) {
                cell = [[JZHomeBlock2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier array:_specialModel.block_2];
            }else{
                cell = [[JZHomeBlock2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
        }
        
//        cell.textLabel.text = @"块";
        //赋值
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 4){
        static NSString *cellIndentifier = @"cell4";
        JZAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[JZAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 132)];
        }
        if (_specialModel.block_3) {
            [cell setSpecialArray:_specialModel.block_3];
        }
        //赋值
        cell.delegate = self;
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


#pragma mark - **************** JZAlbumDelegate
-(void)didSelectedAlbumAtIndex:(NSInteger)index {
    NSLog(@"index:%ld",index);
    NSDictionary *dic = _homepageM.special.block_3[index];
    NSString *cont = [dic objectForKey:@"cont"];
    NSInteger goto_type = [[dic objectForKey:@"goto_type"] integerValue];
    
    [self gotoViewControllerWithType:goto_type withCont:cont];
}

#pragma mark - **************** JZHomeBlock2Delegate
-(void)didSelectedHomeBlock2AtIndex:(NSInteger)index{
    NSLog(@"block2  index:%ld",index);
    NSDictionary *dic = _homepageM.special.block_2[index];
    NSInteger goto_type = [[dic objectForKey:@"goto_type"] integerValue];
    NSString *cont = [dic objectForKey:@"cont"];
    
    [self gotoViewControllerWithType:goto_type withCont:cont];
}

#pragma mark - **************** HomeMenuDelegate
-(void)homeMenuDidSelectedAtIndex:(NSInteger)index{
    [self performSegueWithIdentifier:@"pushToMovie" sender:nil];
}


-(void)gotoViewControllerWithType:(NSInteger)type withCont:(NSString *)cont{
    NSLog(@"goto_type:%ld",type);
    if (type == 1) {
        
    }else if (type == 2){
        //bainuo://web?
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JZWebViewController *VC = [sb instantiateViewControllerWithIdentifier:@"JZWebViewController"];
        VC.url = [NSString getWebUrl:cont];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (type == 3){
        
    }else if (type == 4){
        
    }else if (type == 5){
        //bainuo://topic?
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JZTopicViewController *VC = [sb instantiateViewControllerWithIdentifier:@"JZTopicViewController"];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (type == 6){
        
    }else if (type == 7){
        [self showSuccessHUD:cont];        
    }else if (type == 8){
        //http://
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        JZWebViewController *VC = [sb instantiateViewControllerWithIdentifier:@"JZWebViewController"];
        VC.url = [NSString getComponentUrl:cont];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (type == 9){
        
    }else{
        
    }
    
    
}

-(void)showSuccessHUD:(NSString *)string{
    [SVProgressHUD showInfoWithStatus:string];
}

-(void)showErrorHUD:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
}


#pragma mark - **************** ZBarReaderDelegate
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [picker dismissModalViewControllerAnimated:YES];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
