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
#import "JZShopNoticeCell.h"
#import "JZShopPingjiaCell.h"
#import "JZShopCommentCell.h"
#import "JZShopSeeBuyCell.h"


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
    
    self.navigationController.navigationBarHidden = NO;
    
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self requestItemDetail];
    [self requestComment];
    [self requestRelatedData];
}

-(void)requestItemDetail {
    NSString *url = @"http://180.97.34.118/naserver/item/ItemDetailNew?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&deal_id=5039138&dealdetailOptimize=0&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=e299e2ee41f75828f1a1ab81dcd9f3c6&swidth=750&terminal_type=ios&timestamp=1443426373122&tn=ios&user_distance=&user_distance_status=&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopDetailModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 店铺详情 成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        _shopDetailM = responseObject.data;
        
        [weakself setItemDetailData];
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 店铺详情 失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

-(void)setItemDetailData{
    NSString *imgStr = [_shopDetailM.title_about.image firstObject];
    imgStr = [NSString convertImgStr:imgStr];
    [self.headView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"account_place_holder"]];
    self.title = _shopDetailM.title_about.business_title;
}

-(void)requestComment {
    NSString *url = @"http://180.97.34.118/naserver/ugc/brief?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&commentNum=3&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=c23270ebce924778f5a226655b2e578e&swidth=750&terminal_type=ios&timestamp=1443426373130&tinyPicHeight=180&tinyPicWidth=180&tn=ios&tuanId=5039138&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopCommentModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 评论 成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        _shopCommentM = responseObject.data;
        
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 评论 失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

-(void)requestRelatedData {
    NSString *url = @"http://180.97.34.118/naserver/item/ItemRelatedSearch?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&deal_id=5039138&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&locate_city_id=100010000&location=39.989410%2C116.324400&logpage=DealDetail&net=wifi&os=8.2&s=6407d0bdb7fd7ef47d30786b435cb493&sheight=1334&sign=34636751140f178be81ef21b5b64292d&swidth=750&terminal_type=ios&timestamp=1443426373126&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0";
    
    JZNetworkSingleton *request = [JZNetworkSingleton request];
    request.classModel = @"JZShopRelatedModel";
    __weak typeof(self) weakself = self;
    
    [request getDataWithURL:url params:nil success:^(OPDataResponse *responseObject) {
        NSLog(@"请求 热门推荐 成功");
        if (responseObject.error) {
            NSLog(@"error:  %@",responseObject.error);
            [SVProgressHUD showInfoWithStatus:responseObject.error.description];
            [weakself.tableView.header endRefreshing];
            return ;
        }
        _shopRelatedM = responseObject.data;
        
        
        [weakself reloadData];
    } failure:^(NSError *error) {
        NSLog(@"请求 热门推荐 失败");
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        [weakself.tableView.header endRefreshing];
    }];
}

-(void)reloadData{
    if (_shopDetailM != nil && _shopCommentM != nil && _shopRelatedM != nil) {
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
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
        return _shopCommentM.label_detail_comment.count+1;
    }else{
        return _shopRelatedM.seebuy.list.count+1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else{
            return [JZShopNoticeCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:[_shopDetailM.notice objectForKey:@"notice"]];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 40;
        }else{
            JZShopDetailCommentModel *commentM = _shopCommentM.label_detail_comment[indexPath.row -1];
            return [JZShopCommentCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:commentM];
        }
    }else{
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 90;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"shopPriceCell";
            JZShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (_shopDetailM.rush_buy) {
                [cell setRushBuyM:_shopDetailM.rush_buy];
            }
            return cell;
        }else{
            static NSString *cellIdentifier = @"shopNoticeCell";
            JZShopNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (_shopDetailM.notice) {
                NSString *notice = [_shopDetailM.notice objectForKey:@"notice"];
                cell.noticeLabel.text = notice;
            }
            
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"shopPingjiaCell";
            JZShopPingjiaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (_shopCommentM) {
                cell.commentNumLabel.text = [NSString stringWithFormat:@"%@人评价",_shopCommentM.comment];
            }
            
            return cell;
        }else{
            static NSString *cellIdentifier = @"shopCommentCell";
            JZShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            JZShopDetailCommentModel *commentM = _shopCommentM.label_detail_comment[indexPath.row - 1];
            [cell setCommentM:commentM];
            
            return cell;
        }
        
    }else{
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"normalCell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.textLabel.text = @"为您推荐";
            
            return cell;
        }else{
            static NSString *cellIdentifier = @"shopSeeBuyCell";
            JZShopSeeBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            JZShopSeeBuyListModel *listM = _shopRelatedM.seebuy.list[indexPath.row - 1];
            
            [cell setListM:listM];
            return cell;
        }
        
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
